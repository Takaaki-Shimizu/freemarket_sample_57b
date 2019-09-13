class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?
  before_action :ddmenu
  protect_from_forgery with: :exception
  before_action :ddmenu
  private

  def ddmenu
    @categories = Category.all
    @parents = @categories.where(ancestry: nil)
  end

  def production?
    Rails.env.production?
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

  def ddmenu
    @categories = Category.all
    @parents = @categories.where(ancestry: nil)
  end
end
