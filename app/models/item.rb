class Item < ApplicationRecord
  belongs_to :user
  belongs_to :delivery
  belongs_to :category
  has_many   :buys#, dependent: :destroy
  has_many   :comments#, dependent: :destroy
  has_many   :images, dependent: :destroy
  has_many   :likes, dependent: :destroy
  has_many   :liked_users, through: :likes, source: :user
  accepts_nested_attributes_for :images, allow_destroy: true
  validates :images, length: { minimum: 1, maximum: 10 }
  validates :title,
            :price,
            :text,
            :stock,
            :condition,
            :leadtime,
            :category_id,
            :user_id,
            :delivery_id,
            presence: true
  def self.search(search)
    if search
      Item.where('title LIKE(?)', "%#{search}%")
    else
      redirect_to root_path
    end
  end
end
  