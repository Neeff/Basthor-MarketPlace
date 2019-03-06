class ShopsController < ApplicationController
  before_action :set_shop, only: %i[show edit update destroy]
  def index
    @shops = Shop.all
  end

  def new
    @shop = Shop.new
    respond_to :js
  end

  def create
    @shop = Shop.new(shop_params)
    @shop.user = current_user
    if @shop.save
      respond_to :js
    else
      redirect_to root_path, alert: 'Error Tienda no Creada Intente Nuevamente'
    end
  end

  def show
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

  private

  def set_shop
    @shop = Shop.find(params[:id])
  end

  def shop_params
    params.require(:shop).permit(:name, :description, :user_id, images: [])
  end
end
