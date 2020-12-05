class UsersController < ApplicationController
 before_action :authenticate_user!
 before_action :correct_user, only: [:edit, :update]


  def index
  	@user = current_user
    @new_book = Book.new
  	@users = User.all
  end

  def show
  	@user = User.find(params[:id])
    @new_book = Book.new
  	@books = Book.where(user_id: params[:id])
  end

  def edit
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have update user successfully"
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end