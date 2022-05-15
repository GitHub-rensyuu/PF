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
    @comment = current_customer.comments.new(comment_params)
    @source = @comment.source
    @source = Source.find(params[:source_id])
    @comment.source_id =@source.id
    if @comment.save
      # ここから
      @source.create_notice_comment!(current_customer, @comment.id)
      redirect_to source_path(@source)
      
      # ここまで
    else
      @newsource = Source.new
      # render 'error'
      @customer = current_customer
     redirect_to source_path(@source) #render if error hosii
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
