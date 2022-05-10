class Public::SourcesController < ApplicationController
  def show
    @newsource = Source.new
    @source = Source.find(params[:id])
    @customer = @source.customer
    @comment = Comment.new
    unless ViewCount.find_by(customer_id: current_customer.id, source_id: @source.id)
      current_customer.view_counts.create(source_id: @source.id)
    end
  end
  def index
    @customer = current_customer
    @source = Source.new
    @sources = Source.all
    
    unless params[:source].blank?
      case params[:source][:keyword]
       when 'new' then
        @sources = Source.all.order(created_at: :desc)
       when 'rate' then
        @sources = Source.all.order(rate: :desc)
       when 'like' then
      # hash = {}
        #Source.all.each {|s| hash["#{s.id}"] = s.likes.count }
      # @sources = Source.find(hash.sort_by { |_, v| v }.reverse.to_h.keys)
        @sources =  Source.includes(:likes).sort {|a,b| b.likes.size <=> a.likes.size}
       when 'comment' then
        @sources =  Source.includes(:comments).sort {|a,b| b.comments.size <=> a.comments.size}
        # @sources = Source.all.order(comment: :desc)
       when 'watch' then
        @sources = Source.includes(:view_counts).sort {|a,b| b.view_counts.size <=> a.view_counts.size}
      end
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
  
  def search
    selection = params[:keyword]
    @sources = Source.sort(selection)
  end

  def public_update
  end
  
  


  private

  def source_params
    params.require(:source).permit(:source, :purpose, :performance_review, :note, :rate, :recommended_rank,:is_public, :is_valid)
  end

end