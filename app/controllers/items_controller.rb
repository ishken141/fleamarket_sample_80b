class ItemsController < ApplicationController
  def index
    @items = Item.all
  end
  
  def show  
    @item = Item.find(params[:id]) 
    @comment = Comment.new 
  end 
  
  #商品出品
  def new
    @item = Item.new
    # @item.images.new 
  end
  
  #商品情報
  def create
    @item = Item.new(item_params) 
    @item.save
    redirect_to root_path
  end
  
  #商品編集
  def edit
  end
  
  #商品更新機能
  def update
    # if @item.update(product_params)
    #   redirect_to root_path
    # else
    #   render :edit
    # end
  end

  #商品削除
  def destroy
    @item.destroy
    # redirect_to root_path
  end

  #ストロングパラメーター
  private
  def item_params
    params.require(:item).permit( 
      :id, 
      # :image, 
      :title,
      :price,
      :text,
      :stock,
      :brand,
      :condition,
      :user_id,
      :delivery_id,
      :category_id,
      # images_attributes:  [:image, :_destroy, :id],
    )
  end

  def set_product
    @item = Item.find(params[:id])
  end
  
end

