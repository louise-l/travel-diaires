class Api::V1::CategoriesController < ApplicationController
  skip_before_action :authenticate_author!

  def index
    @categories = Category.all
  end
  
  
  def show
    @category = Category.find(params[:id])
  end
end
