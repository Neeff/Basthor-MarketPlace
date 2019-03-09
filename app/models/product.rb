class Product < ApplicationRecord
  belongs_to :shop
  has_one_attached :image
  has_many :category_products, dependent: :destroy
  has_many :categories, through: :category_products
  has_many :orders, dependent: :destroy
  has_many :users, through: :orders
end
