require 'will_paginate/array'
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user! , execpt: [:edit,:update]

end