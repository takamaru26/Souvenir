class Public::ItemsController < ApplicationController

  def new
    @item = Item.new
  end

  def show
    @item = Item.find(params[:id])
    @tag_list = @item.item_tags.pluck(:name).join(',')
    @tag_tags = @item.item_tags
  end

  def index
    @item = Item.all
    @tag_list = ItemTag.all
    @user = current_user
    @items = Item.page(params[:page])
  end

  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id
    # 受け取った値を,で区切って配列にする
    tag_list = params[:item][:tag].split(',')
    if @item.save
      @item.save_item_tags(tag_list)
      redirect_to public_user_path(current_user), notice: "投稿が完了しました"
    else
      @items = Item.all
      render 'new'
    end
  end

  def edit
    @item = Item.find(params[:id])
    @tag_list = @item.item_tags.pluck(:name).join(',')
  end

  def update
    @item = Item.find(params[:id])
    tag_list=params[:item][:name].split(',')
    if @item.update(item_params)
      @item.save_item_tags(tag_list)
      flash[:notice] = "You have updated item successfully."
      redirect_to  public_item_path(@item.id)
    else
      @items = Item.all
      flash[:notice] = 'errors prohibited this obj from being saved:'
      render :edit
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to public_items_path
  end

  def search_tag
    @tag_list = ItemTag.all
    @item_tag = ItemTag.find(params[:item_tag_id])
    @items = @item_tag.items
  end

    private

  def item_params
    params.require(:item).permit(:name, :image, :price, :explanation, :star, :tag_id, :item_id)
  end
end
