class Public::LikesController < ApplicationController
  before_action :authenticate_customer!
  def index
  end

  def create
    @source = Source.find(params[:source_id])
    like = current_customer.likes.new(source_id: @source.id)
    like.save
    @source.create_notice_like!(current_customer)
  end

  def destroy
    @source = Source.find(params[:source_id])
    like = current_customer.likes.find_by(source_id: @source.id)
    like.destroy
  end
end
