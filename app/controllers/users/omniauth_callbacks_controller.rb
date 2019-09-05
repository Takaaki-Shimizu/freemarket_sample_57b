# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    callback_for(:facebook)
  end

  def google_oauth2
    callback_for(:google)
  end

  def callback_for(provider)
    
    # @user = User.new
    @user = User.from_omniauth(request.env["omniauth.auth"])
    # binding.pry
    if @user.persisted?
      # trueの時点でSNSのアカウントを持っていることが確定
      # Active Record object がDB に保存済みかどうかを判定するメソッド です。
      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
      # binding.pry
    else
      session[:uid] = @user.uid
      session[:email] = @user.email
      session[:provider] = @user.provider
      session[:nickname] = @user.nickname
      session[:first_name] = @user.first_name
      session[:family_name] = @user.family_name
      session[:encrypted_password] = @user.encrypted_password

      # session[:uid] = user_params[:uid]
      # session[:encrypted_password] = user_params[:encrypted_password]
      # session[:provider] = user_params[:provider]

      # uid: session[:uid]
      # provider: session[:provider]
      # encrypted_password: session[:encrypted_password]
      # :uid
      # :provider



      # redirect_to new_user_registration_path
      redirect_to new1_signup_index_path
      # binding.pry
    end
  end

  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
