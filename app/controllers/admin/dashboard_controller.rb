class Admin::DashboardController < ApplicationController
  def show
    @products = Product.order(id: :desc).all
    @product_count = Product.count
    @category_count = Category.count
  end
end
