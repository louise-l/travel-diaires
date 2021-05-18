class Api::V1::ReviewsController < ApplicationController
  before_action :set_article, only: [:create, :destroy]

  def create
    @review = Review.new(review_params)
    @review.author = current_author
    @review.article = @article

    if first_review? && @review.save
      # on met à jour le score moyen de l'article
      @article.calc_score
      redirect_to api_v1_article_path(@review.article)
    else
      # ajouter un message d'erreur
      redirect_to api_v1_article_path(@review.article)
    end
  end

  def destroy
    @review = Review.find(params[:id])
    if require_permission
      @review.destroy
      @article.calc_score
      # ajouter message de confirmation
      redirect_to api_v1_article_path(@review.article)
    else
      # ajouter message derreur
      redirect_to api_v1_article_path(@review.article)
    end
  end

  private 

  def review_params
    params.require(:review).permit(:comment, :rate)
  end

  def first_review?
    author_ids = []
    @article.reviews.each do |review|
      author_ids << review.author_id
    end
    # est-ce que la liste des id contient l'id de lutilisateur actuel  ?  si oui, alors ce n'est pas sa 1ere review, si non alors on renvoie true car c'est sa premiere
    author_ids.include?(current_author.id) ? false : true
  end

  def render_error
    render json: { errors: [] } #la je n'arrive pas à gérer les erreurs et savoir quoi afficher
  end

  def require_permission
    current_author == @review.author ? true : false
  end

  def set_article
    @article = Article.find(params[:article_id])
  end 

end
