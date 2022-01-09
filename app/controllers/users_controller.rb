class UsersController < ApplicationController
   before_action :correct_user, only: [:edit, :update]
   
   def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @user = current_user
    @books=Book.all
    if @book.save
    redirect_to book_path(@book)
    else
      render :index
      
    end
   end
  def show
      @user = User.find(params[:id])
      @books= @user.books.all
      @book=Book.new
  end
  def index
    @user=current_user
    @book=Book.new
    @users=User.all
  end
  def edit
  end  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
     flash[:notice] =' You have updated user successfully.'
     redirect_to user_path(@user.id)
    else
       render :edit
    end
  end
   private

  def user_params
    params.require(:user).permit(:name, :profile_image,:introduction)
  end
  def correct_user
    @user = User.find(params[:id])
    redirect_to(user_path(current_user)) unless @user == current_user
  end
  

end