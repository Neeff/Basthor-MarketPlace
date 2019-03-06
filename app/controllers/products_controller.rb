class ProductsController < ApplicationController
  before_action :set_product, only: %i[show]
  def show
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
      respond_to :js
    else
      redirect_to root_path, alert: 'Error al crear Producto'
    end
  end

  def destroy
    @product.delete
    respond_to :js
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :price, :stock, :description, :image)
  end
end
