class PagesController < ApplicationController
  def index
    # @random_product = Product.order("rand()").limit(3)
    @products = Product.all
  end
end
