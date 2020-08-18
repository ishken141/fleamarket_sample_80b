class Category < ApplicationRecord
  has_many :items#, depenedent: :destroy
  has_ancestry
end
