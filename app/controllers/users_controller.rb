class UsersController < ApplicationController
	# ログインしてる時だけ許可するアクションをonlyで指定
	before_action :authenticate_user!, only: [:index,:show,:edit,:update]

	def index
		@users = User.all
		@book = Book.new
		@user = current_user
		@books = @user.books.reverse_order
	end

	def new
		@user = User.new
	end

	def show
		@book = Book.new
		@user = User.find(params[:id])
		# 紐付けしてる
		@books = @user.books.reverse_order
		# binding.pry
	end

	def edit
		@user = User.find(params[:id])
		# カレントユーザーでない場合
	    if @user != current_user
	      redirect_to user_path(current_user.id)
	    end
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			flash[:notice] = "You have updated user successfully."
			redirect_to user_path(@user.id)
		else
			render 'edit'
		end
	end

	def create
		@book = Book.new(book_params)
		@book.user_id = current_user.id
		if
			@book.save
			flash[:notice] = "Welcome! You have signed up successfully."
			redirect_to book_path(@book.id)
		else
			@books = Book.all
			render 'index'
		end
	end

	def start
	end

	def about
	end

	private
	def user_params
		params.require(:user).permit(:name, :introduction, :profile_image)
	end
end
