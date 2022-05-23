class Admin::SourcesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @sources = Source.page(params[:page])
  end

  def show
    @newsource = Source.new
    @source = Source.find(params[:id])
    @customer = @source.customer
    @comment = Comment.new
    @comments = @source.comments.page(params[:page]).per(5)
    @source_tags = @source.tags
  end

  def destroy
    source = Source.find(params[:id])
    source.destroy
    redirect_to admin_sources_path
  end

  def valid_change
  end
end
