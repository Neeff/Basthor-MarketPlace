class OrdersController < ApplicationController
  def create
    @order = Order.find_or_initialize_by(
            product_id: params[:product_id],
            shop_id: params[:shop_id],
            user_id: current_user.id,
            paid: false,
            completed: false,
            dispached: false)
     @order.price = @order.product.price
     @order.quantity += 1
     @cart_count = current_user.cart.count
     if @order.save
        respond_to :js
     end

     #redirect_to shop_product_cart_path(params[:shop_id],params[:product_id])
  end

  def cart
    @orders = current_user.cart
  end
end
