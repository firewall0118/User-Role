class ApplicationController < ActionController::Base
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore
    default_error_msg = 'Oops, you are not authorized to view this page'

    flash[:error] = I18n.t "pundit.#{policy_name}.#{exception.query}",
      default: default_error_msg
    redirect_to(request.referrer || root_path)
  end
end