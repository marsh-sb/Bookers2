class BooksController < ApplicationController
 before_action :authenticate_user!
 before_action :correct_user, only: [:edit, :update, :destroy]
 

  def create
    @new_book = Book.new(book_params)
    @new_book.user_id = current_user.id
    if @new_book.save
      flash[:notice] = "You have created book successfully"
      redirect_to book_path(@new_book.id)
    else
      @user = current_user
      @books = Book.all
      render :index
    end
  end

  def index
  	@user = current_user
    @new_book = Book.new
  	@books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  	@user = User.find_by(id: @book.user_id)
    @new_book = Book.new
    @book_comment = BookComment.new
  end

  def edit
  end

  def update
    if @book.update(book_params)
      flash[:notice] = "You have update book successfully"
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    @user = current_user
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end

  def correct_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
    redirect_to books_path
    end
  end
end
