class UsersController < ApplicationController

  before_action :authenticate_user!


  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

   def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to book_path(:id)
   end


  def index
    @user =  current_user
    @book = Book.new
    @users = User.all
  end

  def edit
    @user =  User.find(params[:id])
    if @user == current_user
      render "edit"
    else
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
   if @user.update(user_params)
    redirect_to user_path(@user.id)
    flash[:notice] = "You have updated profile successfully."
   else
    render :edit
   end
  end


private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end



end


