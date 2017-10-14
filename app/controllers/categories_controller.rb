class CategoriesController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  layout 'app-user'

  def index
    @categories = Category.all
  end

  def show
    @users = User.all
    @category = Category.find(params[:id])
    @products = Product.where(category_id: @category).paginate(:page => params[:page], :per_page => 10).order("created_at DESC")
  end

  def new
    @category = current_user.categories.build
  end

  def edit
  end

  def create
    @category = current_user.categories.build(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to products_path, notice: 'category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to products_path, notice: 'category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name)
    end
end
