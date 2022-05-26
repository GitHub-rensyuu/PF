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
    @comments = @source.comments.page(params[:page])
    @source_tags = @source.tags
  end

  def destroy
    source = Source.find(params[:id])
    source.destroy
    redirect_to admin_sources_path
  end

  def search_tag
    #検索結果画面でもタグ一覧表示
    @tag_list = Tag.all
    #検索されたタグを受け取る
    @tag = Tag.find(params[:tag_id])
    #検索されたタグに紐づく投稿を表示
    @sources = @tag.sources.page(params[:page])
  end
  
end
