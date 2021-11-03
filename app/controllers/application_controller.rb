class ApplicationController < ActionController::API
  # skip_before_action :verify_authenticity_token
  before_action :set_csrf_cookie

  include ActionController::Cookies
  include ActionController::RequestForgeryProtection

  protect_from_forgery with: :exception

  include Response
  include ExceptionHandler

  def cookie
    'ok'
  end

  private

  def set_csrf_cookie
    cookies['CSRF-TOKEN'] = {
      value: form_authenticity_token,
      # domain: 'expert-class-backend.herokuapp.com',
      domain: %w[expert-class-backend.herokuapp.com expert-class-frontend-v2.netlify.app],
      # domain: 'expert-class-frontend-v2.netlify.app',
      #========= Production Setup for Heroku ==============#
      same_site: :None,
      secure: false
    }
  end
end
