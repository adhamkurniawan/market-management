class UsersController < ApplicationController
  layout 'app-user'

  def show
    @users = User.all
    @user = User.find(params[:id])
    @products = Product.where(user_id: @user).paginate(:page => params[:page], :per_page => 10).order("created_at DESC")
  end
end
