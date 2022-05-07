class Public::CommentsController < ApplicationController

  def create
    source = Source.find(params[:source_id])
    comment = current_customer.comments.new(comment_params)
    comment.source_id = source.id
    comment.save
    redirect_to source_path(source)
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to source_path(params[:source_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:comment,:recommended_rank,:review)
  end
end
