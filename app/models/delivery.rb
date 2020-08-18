class Delivery < ApplicationRecord
  has_many :items#, dependent: :destroy
end
