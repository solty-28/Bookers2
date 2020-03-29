class BooksController < ApplicationController
  before_action :authenticate_user!, except: [:welcome, :about]
  before_action :authbook, {only:[:edit]}

  def create
    @user = User.find(current_user.id)
  	@book = current_user.books.new(book_params)
    @books = Book.all
  	if @book.save
      flash[:message] = "You havu created book successfully."
  	  redirect_to book_path(@book)
    else
      render :index
    end
  end

  def index
  	@book = Book.new
    @books = Book.all
    @user = current_user
  end

  def show
    users = Book.find(params[:id])
    @user = users.user
    @book = Book.new
  	@books = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:message] = "You have updated book successfully."
      redirect_to book_path(@book)
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

    def authbook
      book = Book.find(params[:id])
      if book.user_id != current_user.id
        redirect_to books_path
      end
    end


end
