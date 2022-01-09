class BooksController < ApplicationController
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

  def index
    @user=current_user
    @book=Book.new
    @books=Book.all
    flash[:notice]="index"
  end

  def show
      @new_book = Book.new
      @book = Book.find(params[:id])
      @user=User.find(@book.user_id)
       flash[:notice] =' User was successfully created.'
  end
  def edit
    @book = Book.find(params[:id])
  end
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    redirect_to book_path(@book)
     flash[:notice] =' User was successfully created.'
    else
       render :edit
    end
  end
  
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end
   private

  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def correct_user
    @book = Book.find(params[:id])
    redirect_to(books_path) unless @book.user == current_user
  end
end
