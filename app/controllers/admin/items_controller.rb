class Admin::ItemsController < ApplicationController

  def show
    @item = Item.find(params[:id])
    @tag_list = @item.item_tags.pluck(:name).join(',')
    @tag_tags = @item.item_tags
  end

  def index
    @items = Item.page(params[:page])
  end
  
  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to public_items_path
  end

  def item_params
    params.require(:item).permit(:name, :image, :price, :explanation, :star, :tag_id, :item_id,)
  end

end
