class UsersController < ApplicationController
  before_action :authenticate_admin!, only: [:index, :new, :create, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end  

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_path, notice: "User was successfully created."
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to users_path, notice: "User was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])

    redirect_to users_path, notice: "User was successfully destroyed."
    @user.destroy

  end

  private

  def authenticate_admin!
    unless current_user && current_user.admin?
      redirect_to root_path, alert: "You are not authorized to perform this action."
    end
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :username, :role)
  end
end
