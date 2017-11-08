class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.create(comment_params)
    redirect_to @comment.review

  end

  def destroy
    @comment = Comment.find(params[:id])
    review = @comment.review
    @comment.destroy

    redirect_to review
  end

  private
  def comment_params
    params.require(:comment).permit(:review_id, :content)
  end
end
