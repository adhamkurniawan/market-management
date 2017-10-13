class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_product, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  layout 'app-user'

  def index
    @users = User.all

    if params[:category].blank?
      @products = Product.paginate(:page => params[:page], :per_page => 10).order("created_at DESC")
    else
      @category_id = Category.find_by(name: params[:category]).id
      @products = Product.where(category_id: @category_id).paginate(:page => params[:page], :per_page => 10).order("created_at DESC")
    end
  end

  def show
  end

  def new
    @product = current_user.products.build
  end

  # GET /products/1/edit
  def edit
  end

  def create
    @product = current_user.products.build(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to products_path, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to products_path, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def my_products
    @users = User.all
    @products = current_user.products.paginate(:page => params[:page], :per_page => 10).order("created_at DESC")
  end

  def upvote
    @product = Product.find(params[:id])
    @product.upvote_by current_user
    redirect_back(fallback_location: products_path)
  end

  def downvote
    @product = Product.find(params[:id])
    @product.downvote_by current_user
    redirect_back(fallback_location: products_path)
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :description, :category_id, :image)
    end
end
