class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[facebook]
  enum role: %i[client provider guest]
  has_one :shop
  has_many :orders
  has_many :products, through: :orders
  geocoded_by :address
  after_validation :geocode

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
      user.role = :client
    end
  end

  def cart
    orders.where(paid: false)
  end

  def self.provider
    where(role: :provider)
  end
end
