class ApplicationController < ActionController::API
  acts_as_token_authentication_handler_for Author, except: [:index, :show, :order]
  before_action :authenticate_author!
end
