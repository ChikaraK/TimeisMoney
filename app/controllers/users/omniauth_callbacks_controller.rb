# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
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

  def google_oauth2
    token = request.env['omniauth.auth']
    @user = User.find_by(uid: token.uid, provider: token.provider)
    if @user.blank?
      @user = User.create(
        uid:      token.uid,
        provider: token.provider,
        email:    token.info.email,
        name:     token.info.name
      )
    else
      @user.update(email: token.info.email) if @user.email != token.info.email
      @user.update(name: token.info.name) if @user.name != token.info.name
    end
    
    sign_in_and_redirect @user, event: :authentication
  end


end
