class Public::ItemsController < ApplicationController

  def new
    @item = Item.new
  end

  def show
    @item = Item.find(params[:id])
    @item_comment = ItemComment.new
    @tag_list = @item.item_tags.pluck(:name).join(',')
    @tag_tags = @item.item_tags
  end

  def index
    @items = Item.order(created_at: :desc).page(params[:page])
    if params[:price_range]
      min_price, max_price = params[:price_range].split("-")
      @items = @items.where(price: min_price..max_price)
    end
  
    if params[:item_tag_id].present?
      @items = @items.joins(:item_tags).where(item_tags: { id: params[:item_tag_id] })
    end
  
    if params[:keyword].present?
      @items = @items.search(params[:keyword])
    end
  
    @keyword = params[:keyword]
  end

  def create
    @item = Item.new(item_params)
    item_tags = Vision.get_image_data(item_params[:image])
    @item.user_id = current_user.id
    # 受け取った値を,で区切って配列にする
    tag_list = params[:item][:tag].split(',')
    
    if @item.save
      item_tags.each do |tag|
       @item.ai_tags.create!(name: tag, item_id: @item.id)
      end
  
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
