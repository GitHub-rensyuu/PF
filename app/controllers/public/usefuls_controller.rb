class Public::UsefulsController < ApplicationController
  def create
    comment = Comment.find(params[:comment_id])
    useful = current_customer.usefuls.new(comment_id: comment.id)
    useful.save
    redirect_to request.referer
  end

  def destroy
    comment = Comment.find(params[:comment_id])
    useful = current_customer.usefuls.find_by(comment_id: comment.id)
    useful.destroy
    redirect_to request.referer
  end
end
