# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
100.times do |i|
  User.create(name: Faker::Name.name, email: Faker::Internet.email, password: '123456', role: :client)
end

users_ids = User.where(role: :client).pluck(:id)
product_ids = Product.all.pluck(:id)
shop_ids = Shop.all.pluck(:id)
product_ids = Product.all.pluck(:id)
true_or_false = [true, false]
30.times do |i|
  Order.create(user_id: users_ids.sample, product_id: product_ids.sample,shop_id: shop_ids.sample, price: rand(1..5), dispached:true, paid: true, quantity: rand(1..3), created_at: Faker::Number.number(1).to_i.day.ago)
end