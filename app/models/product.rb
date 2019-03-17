class Product < ApplicationRecord
  belongs_to :shop
  has_one_attached :image
  has_many :category_products, dependent: :destroy
  has_many :categories, through: :category_products
  has_many :orders, dependent: :destroy
  has_many :users, through: :orders

  validates :name, :description, presence: true
  validates :stock, numericality: { only_integer: true }
  validates :price, presence: true, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }, numericality: { greater_than: 0, less_than: 1_000_000 }
end
