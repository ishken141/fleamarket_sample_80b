class BuysController < ApplicationController
  before_action :set_item, only: [:new, :done, :pay]

  require 'payjp'

  def new
    @item = Item.find(params[:id])
    card = Credit.where(user_id: current_user.id).first
    #Cardテーブルは前回記事で作成、テーブルからpayjpの顧客IDを検索
    if card.blank?
      #登録された情報がない場合にカード登録画面に移動
      redirect_to controller: "card", action: "new"
    else
      Payjp.api_key = "sk_test_f47e2234a107e305901f65aa"
      #保管した顧客IDでpayjpから情報取得
      customer = Payjp::Customer.retrieve(card.customer_id)
      #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end

  def index
  end

  def done
  end

  def pay
    card = Credit.where(user_id: current_user.id).first
    Payjp.api_key = "sk_test_f47e2234a107e305901f65aa"
    Payjp::Charge.create(
    :amount => @item.price, #支払金額を入力（itemテーブル等に紐づけても良い）
    :customer => card.customer_id, #顧客ID
    :currency => 'jpy', #日本円
    )
    @item.stock = 0
    @item.save
    redirect_to action: 'done' #完了画面に移動
  end

  # # ストロングパラメーター
  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(
      :name,
      :text,
      :price,
      #この辺の他コードは関係ない部分なので省略してます
    ).merge(user_id: current_user.id)
  end


end
