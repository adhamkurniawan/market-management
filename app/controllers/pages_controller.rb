class PagesController < ApplicationController
  def index
    # @random_product = Product.order("rand()").limit(3)
    @products = Product.limit(6).order("RANDOM()")
  end
end
