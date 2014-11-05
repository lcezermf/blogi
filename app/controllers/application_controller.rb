class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  respond_to :json, :html

  around_action :chewy_atomic

  def chewy_atomic
    Chewy.atomic do
      yield
    end
  end
end
