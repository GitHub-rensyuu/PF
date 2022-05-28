class Public::CommentsController < ApplicationController
  
  def create
    @comment = current_customer.comments.new(comment_params)
    @source = Source.find(params[:source_id])
    @comment.source_id = @source.id
    if @comment.save
      @source.create_notice_comment!(current_customer, @comment.id)
      total_rate = @source.comments.average(:rate)
      total_recommended_rank = @source.comments.average(:recommended_rank).round
      @source.update(total_rate: total_rate)
      @source.update(total_recommended_rank: total_recommended_rank)
      redirect_to source_path(@source), notice: "レビューを投稿しました"
      
    else
      @newsource = Source.new
      @customer = @source.customer
      @comments = @source.comments.page(params[:page])
      redirect_to request.referer
      # render "public/sources/show"
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    source = comment.source
    comment.destroy
    if source.comments.count == 0
      total_rate = source.rate
      total_recommended_rank = source.recommended_rank 
    else
      total_rate = source.comments.average(:rate)
      total_recommended_rank = source.comments.average(:recommended_rank).round
    end
    source.update(total_rate: total_rate)
    source.update(total_recommended_rank: total_recommended_rank)
    redirect_to source_path(params[:source_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:title, :comment,:recommended_rank,:rate)
  end
end
