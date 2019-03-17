class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]
  load_and_authorize_resource
  def show
  end

  def edit
    @shop = Shop.find(params[:shop_id])
    @category = Category.all
    respond_to :js
  end

  def new
    @shop = Shop.find(params[:shop_id])
    @product = Product.new
    @category = Category.all
    respond_to :js
  end

  def create
    @categories = params[:product][:category_id].reject!(&:blank?)
    @product = Product.new(product_params)
    @product.shop_id = params[:shop_id]
    @categories.each do |category|
      @product.category_products.build(category_id: category)
   end

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
    @product.destroy
    respond_to :js
  end

  def search
    @shop = Shop.find(params[:shop_id])
    parameters = params[:search]
    if parameters.blank?
      @products = Product.where(shop_id: @shop.id)
      respond_to :js
    elsif parameters.nil?
      @products = Product.where(shop_id: @shop.id)
      respond_to :js
    else
      @products = Product.where('name LIKE ?',"%#{parameters}%").where(shop_id: @shop.id)
      respond_to :js
    end
  end

  def search_range_price
    @shop = Shop.find(params[:shop_id])
    @range = params[:search]
    @products = Product.where('price <= ?',"#{@range}").where(shop_id: @shop.id)
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
