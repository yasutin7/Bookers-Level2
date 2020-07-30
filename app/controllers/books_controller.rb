class BooksController < ApplicationController
  before_action :ensure_correct_user, only: [:edit , :update , :destroy]

  def index
    @books = Book.all.order(created_at: :desc)
    @book = Book.new
  end

  def show 
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
   if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id)
      @book = Book.new
   else
      flash[:alert] = "Some error has occurred."
      @books = Book.all
      render :index
   end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    
    if @book.update(book_params)
       flash[:success] = "Book was successfully updated."
       redirect_to book_path(@book.id)
    else
      flash[:notice] = "Some error has occurred."
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
    flash[:success] = "Book was successfully destroyed."
  end


  private

  def book_params
    params.require(:book).permit(:title,:body,:id)
  end

  def ensure_correct_user
    @book = Book.find(params[:id]) 
    if @book.user_id != current_user.id
      flash[:notice] = "You don’t have the authority. "
      redirect_to  books_path
    end
  end

end
