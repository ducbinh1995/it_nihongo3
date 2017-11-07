class StaticPagesController < ApplicationController
  def home
    @books = Book.all.paginate(page: params[:page])
    @categories = Category.all
  end
end
