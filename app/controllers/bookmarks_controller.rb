class BookmarksController < ApplicationController
  def create
    load_review

    respond_to do |format|
      if current_user.add_bookmark(params[:book_id])
        format.js
      else
        format.json { render json: {status: :failed} }
      end
    end

  end

  def destroy
    load_review

    respond_to do |format|
      if current_user.unsubscribe?(params[:book_id])
        format.js
      else
        format.json { render json: {status: :failed} }
      end
    end
  end

  private

  def load_review
    @book = Book.find_by_id(params[:book_id])
  end
end
