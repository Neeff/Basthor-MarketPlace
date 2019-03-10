class OrdersController < ApplicationController
  def index
    @orders_provider = current_user.shop.orders.where(paid:true).where(dispached: false).order('created_at DESC').to_a
    @orders_provider.group_by { |order| order.user.id}
    #@orders_provider = current_user.shop.orders.where(paid: true).order('created_at DESC')
  end

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

  def dispached
    @orders_provider = current_user.shop.orders.where(paid: true).where(dispached: false).order('created_at DESC').to_a
    @orders_provider.group_by { |order| order.user.id }
    orders_per_user = @orders_provider.count
    puts orders_per_user
    @order = Order.find(params[:id])
    @order.update(dispached: true)
    if orders_per_user == 1
      puts 'Orden de compra del usuario ha sido despachada en su totalidad'
      #codigo de mail aqui!
    end
  end
end
