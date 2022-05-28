class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @comments = Comment.page(params[:page]).per(10)
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
    redirect_to request.referer
  end
end
