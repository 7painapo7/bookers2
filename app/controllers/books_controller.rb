class BooksController < ApplicationController

  # 本一蘭と投稿機能を実装
  def index
    @book = Book.new
    @books = Book.all

    @user = current_user
  end

  def show
    @book = Book.new
  	@book_show = Book.find(params[:id])
    @user = User.find(@book_show.user_id)

    # @post_comment = PostComment.new
  end

  def edit
  end

  def create
    @user = current_user
  	@book = Book.new(book_params)
    @book.user_id = current_user.id
    @books = Book.all
    @users = User.all
    if
      @book.save
      flash[:notice] = "You have creatad book successfully."
      redirect_to book_path(@book.id)
      # redirect_to root_path
    else
      render 'index'
    end
  end

  private
	def book_params
	  params.require(:book).permit(:title, :body)
	end
end
