class User::ItemsController < ApplicationController
  
  def new
    @item = Item.new
  end

  def show
  end

  def index
  end

  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id
    @item.save
    redirect_to user_user_path
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
    private

  def post_image_params
    params.require(:item).permit(:name, :image, :price,)
  end
end
