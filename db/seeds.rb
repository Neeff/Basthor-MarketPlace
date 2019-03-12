# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

product_id = Product.all.pluck(:id)
Order.destroy_all
1000.times do|i|
  Order.create(user_id: User.find(5).id,
  shop_id: Shop.first.id,
  paid: true,
  dispached: true,
  quantity: rand(1..5),
  product_id: product_id.sample,
  price: rand(2.0..5.0),
  created_at: Faker::Number.number(1).to_i.day.ago)
end