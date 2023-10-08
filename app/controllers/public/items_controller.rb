class Public::ItemsController < ApplicationController
  
  def new
    @item = Item.new
  end

  def show
    @item = Item.find(params[:id])
  end

  def index
    @item = Item.page(params[:page])
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

  def item_params
    params.require(:item).permit(:name, :image, :price,)
  end
end
