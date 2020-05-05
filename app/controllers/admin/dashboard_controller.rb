class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: "Jungle", password: "book"
  def show
    @products_total = Product.count
    @categories_total = Category.count
  end
end
