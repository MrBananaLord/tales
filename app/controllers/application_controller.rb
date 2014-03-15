class ApplicationController < ActionController::Base
  include Authorization

  protect_from_forgery with: :exception
end
