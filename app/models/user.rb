class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: %i[client provider guest]
  has_one :shop
  has_many :orders
  has_many :products, through: :orders
  geocoded_by :address
  after_validation :geocode
  def cart
    orders.where(paid: false)
  end
end
