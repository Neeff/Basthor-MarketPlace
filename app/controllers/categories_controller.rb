class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show]

  def show  
  end

  def search
    parameters = params[:search]
    if parameters.blank?
      @products = Product.all
    elsif parameters.nil?
      @products = Product.all
    else
      @products = Product.where('name LIKE ?', "%#{parameters}%")
    end
    respond_to :js
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end
end
