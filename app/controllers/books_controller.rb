class BooksController < ApplicationController
  # ログインしてる時だけ許可するアクションをonlyで指定
  before_action :authenticate_user!, only: [:index,:show,:edit,:create,:update,:destroy]

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
  	@book = Book.find(params[:id])
    if @book.user_id != current_user.id
      redirect_to books_path
    end
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

  def update
    @book = Book.find(params[:id])
    if
      @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render 'edit'
    end
  end

  def destroy
  	@book = Book.find(params[:id])
  	@book.destroy
    flash[:notice] = "You have destroyed book successfully."
  	redirect_to books_path
  end

  def start
  end

  private
	def book_params
	  params.require(:book).permit(:title, :body)
	end
end
