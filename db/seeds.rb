require "csv"

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Item.create(id:1, title:"macbook", price:100000, text:"中古です。", stock:1, brand:"apple", condition:"新品に近い")

# カテゴリー
CSV.foreach("db/csv/categories-table.csv") do |row|
  Category.create!(name: row[1])
end

# 送料
CSV.foreach("db/csv/deliveries-table.csv") do |row|
  Delivery.create!(name: row[1], size: row[2], price: row[3])
end 

Item.create!(title: "test1", price: 400, text: "test2", stock: 2, brand: "test3", condition: "test4", leadtime: "test5", user_id: 1, delivery_id: 1, category_id: 1)  
User.create!(name: "test1", email: "testtest@test", password: "testtest", password_confirmation: "testtest")

