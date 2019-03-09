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
    respond_to :js if @order.save
  end

  def cart
    @orders = current_user.orders.where(paid: false)
    @total = @orders.map { |order| order.price * order.quantity }.sum
  end

  def destroy
    @orders = current_user.orders.where(paid: false)
    @order = Order.find(params[:id])
    @order.destroy
    @total = @orders.map { |order| order.price * order.quantity }.sum
    respond_to :js if @order.save
  end

  def empty_cart
    @orders = current_user.orders.where(paid: false)
    @orders.destroy_all
    redirect_to cart_orders_path, notice: 'Carro vaciado con éxito!'
  end
  def add_item
    @orders = current_user.orders.where(paid: false)
    @order = Order.find(params[:id])
    @order.quantity += 1 
    @order.save if @order.changed?
    @total = @orders.map { |order| order.price * order.quantity }.sum
    respond_to :js
  end

  def less_item
    @orders = current_user.orders.where(paid: false)
    @order = Order.find(params[:id])
    @order.quantity -= 1 if @order.quantity > 1
    @order.save if @order.changed?
    @total = @orders.map { |order| order.price * order.quantity }.sum
    respond_to :js
  end
end
