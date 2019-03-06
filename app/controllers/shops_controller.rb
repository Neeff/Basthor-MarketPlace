class ShopsController < ApplicationController
  before_action :set_shop, only: %i[show update destroy]
  def index
    @shops = Shop.all
  end

  def new
    @shop = Shop.new
  end

  def create
    @shop = Shop.new(shop_params)
  end

  def show
  end

  def update
  end

  def destroy
  end

  private

  def set_shop
    @shop = Shop.find(params[:id])
  end

  def shop_params
    params.require(:shop).permit(:name, :description, :images [])
  end
end
