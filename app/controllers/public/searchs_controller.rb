class Public::SearchsController < ApplicationController
  def search
    @price_range = params["price_range"]
    @items = search_for(@price_range)
    redirect_to public_items_path
  end

  private
  def search_for(price_range)
    case price_range
    when '0-5000'
      Item.where(price: 0..5000)
    when '5001-10000'
      Item.where(price: 5001..10000)
    when '10001-20000'
      Item where(price: 10001..20000)
    when '20001-30000'
      Item where(price: 20001..30000)
    when '30001-1000000'
      Item where(price: 30001..1000000)
    else
      Item.all # If the price range doesn't match any case, show all items
    end
  end
end
