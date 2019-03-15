class ShopsController < ApplicationController
  #before_action :set_shop, only: %i[show edit update destroy]
  load_and_authorize_resource
  def index
    @shops = Shop.all
    @category = Category.all
  end

  def new
    @shop = Shop.new
    respond_to :js
  end

  def create
    @shop = Shop.new(shop_params)
    @shop.user = current_user
    if @shop.save
      redirect_to root_path, notice: 'Tienda Creada Con Exito'
    else
      redirect_to root_path, alert: 'Error Tienda no Creada Intente Nuevamente'
    end
  end

  def show
    @products = Product.where(shop_id: @shop.id)
    @order = Order.new
    @categories = Category.all
  end

  def edit
    respond_to :js
  end

  def update
    @shop.update(shop_params)
    if @shop.save
      respond_to :js
    else
      redirect_to root_path, alert: 'Error al Actualizar la Tienda'
    end
  end

  def destroy
    @shop.delete
    respond_to :js
  end

  def search
    parameters = params[:search]
    if parameters.blank?
      @shops = Shop.all
      respond_to :js
    elsif parameters.nil?
      @shops = Shop.all
      respond_to :js
    else
      @shops = Shop.where('name LIKE ?',"%#{parameters}%")
      respond_to :js
    end
  end

  private

  def set_shop
    @shop = Shop.find(params[:id])
  end

  def shop_params
    params.require(:shop).permit(:name, :description, :user_id, images: [])
  end
end
