class Admin::DashboardController < ApplicationController
  http_basic_autentication_with name: ENV['USERNAME'], password: ENV['PASSWORD'] 
  def show
  end
end
