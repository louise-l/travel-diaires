class Api::V1::ArticlesController < ApplicationController
  skip_before_action :authenticate_author!, only: [:index, :show, :order]
  before_action :set_article, only: [:show, :update, :destroy]


  def index
    @articles = Article.order(created_at: :desc)
  end

  def order
    # Un index pour ordonner les articles par note
    @articles = Article.order(score: :desc)
  end

  def new
    # @article = Article.new(article_params)
  end

  def create
    @article = Article.new(article_params)
    @article.author = current_author
    add_categories
    if @article.save
      redirect_to api_v1_article_path(@article)
    else
      render_error
    end
  end

  def edit
    # si j'avais fait la view moi même, j'aurais set_article dans cette action, mais je sais pas si c'est nécessaire ici 
  end

  def update
    if is_owner? && @article.update(article_params)
      # gérer les catégories, on détruit tout et on rajoute petit à petit
      @article.categories.destroy_all
      add_categories
      @article.save
      # rajouter un message de validation
      redirect_to api_v1_article_path(@article)
    else
      render_error
    end
  end

  def destroy
    if is_owner?
      @article.destroy
      # message de confirmation
      redirect_to api_v1_articles_path
    else
      # message derreur
      render_error
    end
  end

  private 

  def is_owner?
    current_author == @article.author ? true : false
  end

  def set_article
    @article = Article.find(params[:id])
  end 
  
  def article_params
    params.require(:article).permit(:title, :description, :url_cover_picture, :category_ids)
  end

  def render_error
    render json: { errors: [] } #la je n'arrive pas à gérer les erreurs et savoir quoi afficher
  end

  def add_categories
    @category_array = params[:category_ids]
    @category_array.each do |cat|
      @category = Category.find(cat)
      # ajouter les categories dans l'article
      @article.categories << @category
    end
  end
end