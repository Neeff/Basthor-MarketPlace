class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]
  def show
  end

  def edit
    @shop = Shop.find(params[:shop_id])
    respond_to :js
  end

  def new
    @shop = Shop.find(params[:shop_id])
    @product = Product.new
    respond_to :js
  end

  def create
    @product = Product.new(product_params)
    @product.shop_id = params[:shop_id]
    if @product.save
      redirect_to shop_path(params[:shop_id])
    else
      redirect_to root_path, alert: 'Error al crear Producto'
    end
  end

  def update
    @product.update(product_params)
    if @product.save
      redirect_to shop_path(params[:shop_id])
    else
      redirect_to root_path, alert: 'Error al Actualizar Producto'
    end
  end

  def destroy
    @product.delete
    respond_to :js
  end

  def search
    parameters = params[:search]
    if parameters.blank?
      @products = Product.all
      respond_to :js
    elsif parameters.nil?
      @products = Product.all
      respond_to :js
    else
      @products = Product.where('name LIKE ?',"%#{parameters}%")
      respond_to :js
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :price, :stock, :description, :image)
  end
end
