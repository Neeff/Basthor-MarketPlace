class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show serch]

  def show  
  end

  def search
    parameters = params[:search]
    if parameters.blank?
      @products = Product.where(category_id: @category.id)
    elsif parameters.nil?
      @products = Product.where(category_id: @category.id)
    else
      @products = Product.where('name LIKE ?', "%#{parameters}%").where(category_id: @category.id)
    end
    respond_to :js
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end
end
