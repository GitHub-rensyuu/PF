class Public::SourcesController < ApplicationController
  def show
    @newsource = Source.new
    @source = Source.find(params[:id])
    @customer = @source.customer
    @comment = Comment.new
  end
  def index
    @customer = current_customer
    @source = Source.new
    if params[:sort_new]
      @sources = Source.all.order(created_at: :desc)
    elsif params[:sort_rate]
      @sources = Source.all.order(rate: :desc)
    elsif params[:sort_like]
      @sources = Source.all.order(like: :desc)
    elsif params[:sort_comment]
      @sources = Source.all.order(comment: :desc)
    else
      @sources = Source.all
    end
  end

  def create
    @source = Source.new(source_params)
    @source.customer_id = current_customer.id
    if @source.save
      redirect_to source_path(@source.id), notice: "You have created source successfully."
    else
      @customer = current_customer
      @sources = Source.all
      render 'index'
    end
  end

  def edit
    @source = Source.find(params[:id])
    if @source.customer == current_customer
      render "edit"
    else
      redirect_to sources_path
    end
  end

  def update
    @source = Source.find(params[:id])
    @source.customer_id = current_customer.id
    if @source.update(source_params)
      redirect_to source_path(@source), notice: "You have updated source successfully."
    else
      render "edit"
    end
  end

  def destroy
    @source = Source.find(params[:id])
    if @source.destroy
      flash[:notice]="削除しました"
      redirect_to sources_path
    end
  end

  def search_source
     @source = Source.new
     @sources = Source.search(params[:keyword])
  end

  def public_update
  end


  private

  def source_params
    params.require(:source).permit(:source, :purpose, :performance_review, :note, :rate, :recommended_rank,:is_public, :is_valid)
  end

end