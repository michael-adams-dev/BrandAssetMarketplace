class CategoriesController < ApplicationController
  def create
    @category = Category.create(category_params)
  end

  def new
    @category = Category.new
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
