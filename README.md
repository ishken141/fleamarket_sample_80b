# フリマ DB設計
## usersテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|email|string|null: false|
|password|string|null: false|
### Association
- has_many :items
- has_many :buys
- has_one :address

## itemsテーブル(商品)
|Column|Type|Options|
|------|----|-------|
|title|string|null: false|
|price|integer|null: false|
|text|text|null: false|
|stock|integer|null: false|
|brand|string|null: false|
|condition|string|null: false|
|leadtime|integer|null: false|
|user_id|reference|null: false, foreign_key: true|
|delivery_id|reference|null: false, foreign_key: true|
|category_id|reference|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :delivery
- belongs_to :category
- has_many :buys
- has_many :images

## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
### Association
- has_many :items


## buysテーブル(購入)
|Column|Type|Options|
|------|----|-------|
|text|text|null: false|
|price|integer
|user_id|reference|null: false, foreign_key: true|
|item_id|reference|null: false, foreign_key: true|
### Association
- belongs_to :item
- belongs_to :user

## deliveriesテーブル(配送関係)
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|size|string|null: false|
|price|integer|null: false|
### Association
- has_many :items

## addressesテーブル(住所)
|Column|Type|Options|
|------|----|-------|
|zipcode|integer|null: false|
|area|string|null: false|
|city|string|null: false|
|street|text|null: false|
|user_id|reference|null: false, foreign_key: true|
### Association
- belongs_to :user

## imagesテーブル(商品画像)
|Column|Type|Options|
|------|----|-------|
|image|string|null: false|
|item_id|reference|null: false, foreign_key: true|
### Association
- belongs_to :item
