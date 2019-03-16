class PayoutBatchesController < ApplicationController
  def create
    users_providers = User.provider
    users_providers.each  do |pb|
        amount = pb.shop.orders.where(paid: true).where('created_at >= :month', month: Time.now - 30.days).map{|order| order.quantity * order.price}.sum 
        items =  []

        items << {
                recipient_type: "EMAIL",
                amount: {
                        value: "#{amount}",
                        currency: 'USD',
                },
                note: 'cualquier cosa',
                sender_item_id: "#{pb.id}",
                receiver: "#{pb.email}"

        }

        payout = PayPal::SDK::REST::Payout.new({
                sender_batch_header: {
                  sender_batch_id: SecureRandom.hex(10),
                  email_subject: 'You have a Payout!',
                },
                 items: items
              })
              begin
                payout_batch = payout.create
                # Logic to update any statements
               rescue ResourceNotFound => err
                logger.error payout.error.inspect
               end
               
    end
  end
end
