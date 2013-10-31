class ApplicationController < ActionController::Base
  before_filter :require_login  
  protect_from_forgery with: :exception
  rescue_from ActionController::RoutingError, :with => :render_page_not_found

  def render_page_not_found(e)
    render :json => {:ok => false, :message => e.message}
  end
  def render_not_authenticated
    render :json => {:ok => false, :message => "Not authenticated"}
  end
  def routing_error
    raise ActionController::RoutingError.new("Resource not found: " + params[:path])
  end
end
