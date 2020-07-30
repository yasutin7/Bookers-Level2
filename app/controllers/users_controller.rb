class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit , :update , :destroy]

  def index
    @users = User.all 
    @user = current_user
    @book = current_user.books.new
  end

  def show
    @user = User.find(params[:id])
    @current_user = current_user
    @books = Book.where(user_id: @user.id)
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path, notice: "You have updated user successfully."
    else 
      flash[:alert] = "Some error has occurred."
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email,:introduction, :created_at,:profile_image,:updated_at)
  end

  def ensure_correct_user
    @user = User.find(params[:id]) 
    if @user.id != current_user.id
      flash[:notice] = "You don’t have the authority. "
      redirect_to  user_path(current_user.id)
    end
  end

end
