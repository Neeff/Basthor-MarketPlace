class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product
  belongs_to :shop
  belongs_to :billing, optional: true

  def self.paid_and_dispached
    where(paid: true).where(dispached: true)
  end
end
