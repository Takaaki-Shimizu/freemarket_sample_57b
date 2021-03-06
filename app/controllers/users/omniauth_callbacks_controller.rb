# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def new1

  end

  def facebook
    callback_for(:facebook)
  end

  def google_oauth2
    callback_for(:google)
  end

  def callback_for(provider)
    provider = provider.to_sym
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication

    else
      unless @user.provider.blank?

      session[:uid] = @user.uid
      session[:email] = @user.email
      session[:provider] = @user.provider
      session[:nickname] = @user.nickname
      session[:password] = @user.password
      session[:first_name] = @user.first_name
      session[:family_name] = @user.family_name
      redirect_to new1_signup_index_path

      else
        session[:value] = provider
        redirect_to new_user_session_path, notice: "#{provider}での登録情報はありません。他の方法でログインをお試しください。"
      end
    end
  end
end
