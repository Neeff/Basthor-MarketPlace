class OrdersController < ApplicationController
  def index
    @orders_per_user = current_user.shop.orders.where(paid: true).where(dispached: false).group_by{|order| order.user.id}
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
    user = User.find(params[:id])
    orders_per_user = user.orders.where(paid: true).where(dispached: false)
    orders_per_user.update_all(dispached: true)
    puts 'Orden de compra del usuario ha sido despachada en su totalidad'
    UserMailer.new_pack_off(user, orders_per_user).deliver
    redirect_to orders_path
  end

  def user
    @orders_user = current_user.orders.where(paid: true)
    # estado de la orden... cambiar color del tr
  end
  def dashboard
    @orders = current_user.shop.orders.where(paid: true).where(dispached: true).group_by_month{|order| order.created_at}
    @count_products_shop = current_user.shop.products.count
    @orders_shop = current_user.shop.orders.count
    @orders_dispached_shop = current_user.shop.orders.where(paid: true).where(dispached: true).count
    @orders_not_dispached_shop = current_user.shop.orders.where(paid: true).where(dispached: false).count
  end

end
