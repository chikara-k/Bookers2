class BooksController < ApplicationController
  def index
    @user = User.find(current_user.id)
    @book = Book.new
    @books = Book.all
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = User.find(current_user.id)
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user_id == current_user.id
    else
      redirect_to books_path
    end
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @booknew = Book.new
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to "/books"
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end


  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
