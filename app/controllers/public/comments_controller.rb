class Public::CommentsController < ApplicationController

  # def create
  #   source = Source.find(params[:source_id])
  #   comment = current_customer.comments.new(comment_params)
  #   comment.source_id = source.id
  #   comment.save
  #   @source = Source.find(params[:source_id])
  #   @comment = Comment.new
  #   @source.create_notice_by(current_customer)
  #   redirect_to source_path(source)
  # end
  
  def create
    @customer = current_customer
    @comment = Comment.new(comment_params)
    @source = @comment.source
    if @comment.save
      # ここから
      @source.create_notice_comment!(current_customer, @comment.id)
      # ここまで
    else
      @newsource = Source.new
      @source = Source.find(params[:source_id])
      render 'public/sources/show'
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to source_path(params[:source_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:title, :comment,:recommended_rank,:rate)
  end
end
