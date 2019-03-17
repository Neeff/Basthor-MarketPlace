class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show search]

  def show  
  end

  def search
    parameters = params[:search]
    if parameters.blank?
      @products = Category.where(category_id: @category.id).products
    elsif parameters.nil?
      @products = Category.where(category_id: @category.id).products
    else
      @products = Category.where(category_id: @category.id).products.where('name LIKE ?', "%#{parameters}%")
    end
    respond_to :js
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end
end
