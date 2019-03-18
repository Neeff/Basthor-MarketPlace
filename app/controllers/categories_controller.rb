class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show search]

  def show  
  end

  def search
    @category = Category.find(params[:id])
    parameters = params[:search]
    if parameters.blank?
      @products = @category.products
    elsif parameters.nil?
      @products = @category.products
    else
      @products = @category.products.where('name LIKE ?', "%#{parameters}%")
    end
    respond_to :js
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end
end
