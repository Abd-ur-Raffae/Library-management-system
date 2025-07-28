class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
    devise_parameter_sanitizer.permit(:account_update, keys: [:role])
  end
  
  def require_librarian
    unless current_user&.librarian?
      redirect_to root_path, alert: 'Access denied. Librarian privileges required.'
    end
  end
  
  def require_librarian_or_self(member_id = nil)
    unless current_user&.librarian? || (current_user&.member? && current_user.id == member_id)
      redirect_to root_path, alert: 'Access denied.'
    end
  end
end
