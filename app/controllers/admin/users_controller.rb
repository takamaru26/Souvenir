class Admin::UsersController < ApplicationController
  
  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @status   = User.select("is_deleted").find_by(id: params[:id]) 
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "会員情報を更新しました。"
    else
      flash.now[:danger] = "予期せぬエラーが発生しました"
      @status   = User.select("is_deleted").find_by(id: params[:id]) 
      render 'show'
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:last_name, :first_name, :email, :is_deleted)
  end
end
