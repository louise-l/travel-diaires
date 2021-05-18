class Api::V1::AuthorsController < ApplicationController
  skip_before_action :authenticate_author!

  def index
    @authors = Author.all
  end

end

