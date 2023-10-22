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
    @items = Item.page(params[:page])
    if params[:price]
      case params[:price]
      when "option1"
        @items = Item.where(price: 0..5000).page(params[:page])
      when "option2"
        @items = Item.where(price: 5001..10000).page(params[:page])
      when "option3"
        @items = Item.where(price: 10001..20000).page(params[:page])
      when "option4"
        @items = Item.where(price: 20001..30000).page(params[:page])
      when "option5"
        @items = Item.where(price: 30001..999999).page(params[:page])
      when "option6"
        @items = Item.all.page(params[:page])
      end
    end
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
    tag_list=params[:item][:tag].split(',')
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
    params.require(:item).permit(:name, :image, :price, :explanation, :star, :tag_id, :item_id,)
  end
end
