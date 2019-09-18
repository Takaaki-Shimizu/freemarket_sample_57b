require "rails_helper"

describe "UserFeature" do

  describe "facebook連携でサインアップする" do

    before do
      OmniAuth.config.mock_auth[:facebook] = nil
      Rails.application.env_config['omniauth.auth'] = facebook_mock
      visit user_facebook_omniauth_authorize_path
    
      # click_link "ログイン"
    
    end

    it "サインアップするとユーザーが増える" do
      expect{
        click_on 'facebookで登録する'
      }.to change(User, :count).by(1)
    end

    it "すでに連携されたユーザーがサインアップしようとするとユーザーは増えない" do
      click_link "Facebookでログイン"
      # click_link "ログアウト"
      # click_link "ログイン"
      expect{
        click_link "facebookで登録する"
      }.not_to change(User, :count)
    end

  end
end