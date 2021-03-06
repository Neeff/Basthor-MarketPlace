class Shop < ApplicationRecord
  belongs_to :user
  has_many :products, dependent: :destroy
  has_many_attached :images
  has_many :orders, dependent: :destroy

  def self.created_by_day
    group_by_day(:created_at).count
  end
end
