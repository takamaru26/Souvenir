class Public::UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :is_matching_login_user, only: [:edit, :update]

  def show
    #byebug
    @user = User.find(params[:id])
    @item = Item.new
    @items = @user.items.page(params[:page])  
    @tag_list = @item.item_tags.pluck(:name).join(',')
  end

  def new
    flash[:notice]="Welcome! You have signed up successfully."
    @user == current_user
  end



  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render "edit"
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = current_user
    if @user.update!(user_params)
      redirect_to public_user_path(@user), notice: "プロフィールを更新しました"
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:last_name, :first_name, :introduction, :profile_image)
  end

  def is_matching_login_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
