class Public::LikesController < ApplicationController
  def index
  end

  def create
    @source = Source.find(params[:source_id])
    like = current_customer.likes.new(source_id: @source.id)
    like.save
  end

  def destroy
    @source = Source.find(params[:source_id])
    like = current_customer.likes.find_by(source_id: @source.id)
    like.destroy
  end
end
