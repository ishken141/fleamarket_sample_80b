class Address < ApplicationRecord
  belongs_to :user, optional: true
  validates :zipcode, :area, :city, :street, presence: true
end
