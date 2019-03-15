class BillingsController < ApplicationController
  def pre_pay
    orders = current_user.orders.where(paid: false)
    total = orders.map{|order| order.product.price * order.quantity}.sum
    # necesito un array de hashes donde cada hash es un item(orden)
    items = orders.map do |order|
    item = {}
    item[:name] = order.product.name,
    item[:sku]  = order.product.id.to_s,
    item[:price] = order.price.to_s,
    item[:currency] = 'USD',
    item[:quantity] = order.quantity
    item
    end
    payment = PayPal::SDK::REST::Payment.new({
                  intent: "sale",
                  payer: {
                    payment_method: "paypal" },
                    redirect_urls:{
                    return_url: "http://localhost:3000/billings/execute",
                    cancel_url: "http://localhost:3000/" },
                    transactions: [{
                      item_list: {
                        items: items},
                        amount: {
                        total: total.to_s,
                        currency: "USD" },
                        description:   "This is the payment transaction description." }]})
     if payment.create
       paypal_pay_url = payment.links.find { |v| v.method == "REDIRECT"}.href
       redirect_to paypal_pay_url
     else
       payment.error
     end
  end
  def execute
    paypal_payment = PayPal::SDK::REST::Payment.find(params[:paymentId])
      if paypal_payment.execute(payer_id: params[:PayerID])
        total = paypal_payment.transactions.first.amount.total
        billing = Billing.create(
                            user: current_user,
                            code: paypal_payment.id,
                            address: current_user.address,
                            payment_method: 'paypal',
                            amount: total.to_i,
                            currency: 'USD'
                    )
        orders =  current_user.orders.where(paid: false)
        orders.update_all(paid: true, billing_id: billing.id)
        orders_paid_current_user = current_user.orders.where(paid: true).where(type_order: 'last order').pluck(:product_id, :quantity)
        orders_paid_current_user.each do |pq|
          product = Product.find(pq.first)
          product.update(stock: (product.stock - pq.second))
        end
        current_user.orders.where(paid: true).update_all(type_order: 'old order')
        redirect_to user_orders_path, notice: 'el Pago se genero con exito!'
        else
          render plain: ':('
      end
  end
end
