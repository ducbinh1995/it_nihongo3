class StaticPagesController < ApplicationController
  def home
    @books = Book.all.paginate(page: params[:page])
  end
end
