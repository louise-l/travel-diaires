class Api::V1::ArticlesController < ApplicationController
  skip_before_action :authenticate_author!, only: [:index, :show, :order]
  #acts_as_token_authentication_handler_for Author, except: [:index, :show, :order]

  before_action :set_article, only: [:show, :update, :destroy]


  def index
    @articles = Article.order(created_at: :desc)
  end

  def order
    # Un index pour ordonner les articles par note
    @articles = Article.order(score: :desc)
  end

  def show
  end

  def new
    # @article = Article.new(article_params)
  end

  def create
    @article = Article.new(article_params)
    @article.author = current_author
    if @article.save
      render :show
    else
      render_error
    end
  end

  def edit
    # si j'avais fait la view moi même, j'aurais set_article dans cette action, mais je sais pas si c'est nécessaire ici 
  end

  def update
    if require_permission && @article.update(article_params)
      # rajouter un message de validation
      render :show
    else
      render_error
    end
  end

  def destroy
    if require_permission
      @article.destroy
      # message de confirmation
      # je sais pas trop comment rediriger ici ... en normal j'aurais fait un redirect_to articles_path
    else
      # message derreur
      render :show
    end
  end

  private 

  def require_permission
    current_author == @article.author ? true : false
  end

  def set_article
    @article = Article.find(params[:id])
  end 
  
  def article_params
    params.require(:article).permit(:title, :description, :url_cover_picture)
  end

  def render_error
    render json: { errors: [] } #la je n'arrive pas à gérer les erreurs et savoir quoi afficher
  end
end



# curl -i -X PATCH                                        \
#        -H 'Content-Type: application/json'              \
#        -H 'X-Author-Email: lanita@runolfsson-schuppe.info'   \
#        -H 'X-Author-Token: ynD8ogzsT5xxUBy1aEUB'          \
#        -d '{ "title": "New name" }'    \
#        http://localhost:3000/api/v1/articles/1
