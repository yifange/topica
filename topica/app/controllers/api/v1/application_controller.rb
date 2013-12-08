##
# The base class for all the api controllers.
# 
# Author:: Yifan Ge

class Api::V1::ApplicationController < ApplicationController
  protect_from_forgery with: :null_session
  after_filter :set_csrf_cookie_for_ng
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  rescue_from Exception, :with => :server_error
  before_filter :require_login  
  skip_before_filter :require_login, only: [:ping]
  
  # return the api version to the user
 
  def ping
    render :text => "Pong! Topica backend api v1 is running."
  end

  private
 
  # set the csrf cookie for angularjs

  def set_csrf_cookie_for_ng
    #http://stackoverflow.com/questions/14734243/rails-csrf-protection-angular-js-protect-from-forgery-makes-me-to-log-out-on
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  def verified_request?
    super || form_authenticity_token == request.headers['HTTP_X_XSRF_TOKEN']
    erue # XXX Only for testing, must remove
  end

  # do not panic when quering for a nonexisted record
  
  def record_not_found
    #http://stackoverflow.com/questions/11859437/how-to-handle-exceptions-in-json-based-restful-code
    render :json => {:ok => false, :message => "Record not found"}, :status => :not_found
  end
  def server_error(e)
    render :json => {:ok => false, :message => e.message}, :status => :internal_server_error
  end
  def render_not_authenticated
    render :json => {:ok => false, :message => "Not authenticated"}, :status => :unauthorized
  end
end
