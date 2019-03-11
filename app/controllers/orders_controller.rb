class OrdersController < ApplicationController
  def index
    @orders_provider = current_user.shop.orders.where(paid:true).where(dispached: false).order('created_at DESC')
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
    @orders_provider = current_user.shop.orders.where(paid: true).where(dispached: false).order('created_at DESC')
    @order = Order.find(params[:id])
    user = User.find_by(id: @order.user_id)
    @order.update(dispached: true)
    orders_per_user = User.find(user.id).orders.where(paid: true).where(dispached: false).count
    puts orders_per_user
    if orders_per_user == 0
      puts 'Orden de compra del usuario ha sido despachada en su totalidad'
      UserMailer.new_pack_off(user, @orders_provider).deliver
    end
    redirect_to orders_path
  end

  def user
    @orders_user = current_user.orders.where(paid: true)
  end
end
