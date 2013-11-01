class Api::V1::ErrorsController < Api::V1::ApplicationController
  rescue_from ActionController::RoutingError, :with => :render_page_not_found

  def render_page_not_found(e)
    render :json => {:ok => false, :message => e.message}
  end
  def routing_error
    raise ActionController::RoutingError.new("Resource not found: " + params[:path])
  end
end
