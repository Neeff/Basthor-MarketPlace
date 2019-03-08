class CategoriesController < ApplicationController
  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to root_path, notice: 'categoria creada con exito'
    end
  end
private 

  def category_params
    params.require(:category).permit(:name)
  end
end
