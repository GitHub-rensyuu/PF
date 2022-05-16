class Public::SourcesController < ApplicationController
  def show
    @newsource = Source.new
    @source = Source.find(params[:id])

    @customer = @source.customer
    @comment = Comment.new
    @source_tags = @source.tags
    unless ViewCount.find_by(customer_id: current_customer.id, source_id: @source.id)
      current_customer.view_counts.create(source_id: @source.id)
    end
  end
  def index
    
    @customer = current_customer
    @source = Source.new
    # @sources = Source.all
    @sources = Source.where(is_public: true).order('id DESC')
    @tag_list=Tag.all
    @source_tags = @source.tags
    
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
    blacklist = "死ね|殺す"
    
    if params[:post]
      if @source.purpose.match?(/(.*)#{blacklist}(.*)/)
        flash[:alert] = "NGワードが含まれています"
        @customer = current_customer
        @sources = Source.all
        render 'index'
      # @source.save! && !@source.purpose.match?(/(.*)#{blacklist}(.*)/)
      
      elsif !@source.save(context: :publicize)
        @customer = current_customer
        @sources = Source.all
        render 'index'
      else
        @source.update(is_public: true)
        tag_list=params[:source][:tagname].split(',')
        @source.save_tag(tag_list)
        redirect_to source_path(@source.id), notice: "情報ソースの作成しました!"
      end
    else
      if @source.purpose.match?(/(.*)#{blacklist}(.*)/)
        flash[:alert] = "登録できませんでした。NGワードが含まれています。"
        @customer = current_customer
        @sources = Source.all
        render 'index'
      # @source.save! && !@source.purpose.match?(/(.*)#{blacklist}(.*)/)
        
      elsif !@source.update(is_public: false)
        flash[:alert] = "登録できませんでした。"
        @customer = current_customer
        @sources = Source.all
        render 'index'
      else
        tag_list=params[:source][:tagname].split(',')
        # @source.save_tag(tag_list)
        redirect_to customer_path(current_customer), notice: "情報ソースの下書き保存しました！"
      end
    end
  end

  def edit
    @source = Source.find(params[:id])
    @tag_list=@source.tags.pluck(:name).join(',')
    if @source.customer == current_customer
      render "edit"
    else
      redirect_to sources_path
    end
  end

  def update
    @source = Source.find(params[:id])
    @source.customer_id = current_customer.id
    blacklist = "死ね|殺す"
    if params[:publicize_draft]
      @source.is_public = true
      # @source.attributes = source_params.merge(is_public: true)
      if @source.purpose.match?(/(.*)#{blacklist}(.*)/)
        @source.is_public = false
        flash[:alert] = "登録できませんでした。NGワードが含まれています。"
        @customer = current_customer
        @sources = Source.all
        render 'index'
      elsif  @source.save(context: :publicize)
        # @source.update(is_public: true)
        redirect_to source_path(@source.id), notice: "下書きの情報ソースを公開しました！"
        
      elsif !@source.update(is_public: true)
        @source.is_public = false
        flash[:alert] = "登録できませんでした。"
        @customer = current_customer
        @sources = Source.all
        render 'index'
      
      else
        @source.is_public = false
        tag_list=params[:source][:tagname].split(',')
        # @source.save_tag(tag_list)
        redirect_to customer_path(current_customer), notice: "情報ソースの下書き保存しました！"
      end
      
    
    elsif params[:update_post]
      
      tag_list=params[:source][:tagname].split(',')
      
      if @source.update(source_params)
       # このsource_idに紐づいていたタグを@oldに入れる
          @old_relations = SourceTag.where(source_id: @source.id)
          # それらを取り出し、消す。消し終わる
          @old_relations.each do |relation|
            relation.delete
          end
          @source.save_tag(tag_list)
        redirect_to source_path(@source), notice: "情報ソースを更新しました"
      else
        render "edit"
      end
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
  
  
  def save_tag(sent_tags)
    # タグが存在していれば、タグの名前を配列として全て取得
      current_tags = self.tags.pluck(:tagname) unless self.tags.nil?
      # 現在取得したタグから送られてきたタグを除いてoldtagとする
      old_tags = current_tags - sent_tags
      # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
      new_tags = sent_tags - current_tags
  
      # 古いタグを消す
      old_tags.each do |old|
        self.tags.deleteTag.find_by(tagname: old)
      end
  
      # 新しいタグを保存
      new_tags.each do |new|
        new_source_tag = Tag.find_or_create_by(tagname: new)
        self.tags << new_source_tag
     end
  end
  
  def search_tag
    #検索結果画面でもタグ一覧表示
    @tag_list=Tag.all
    #検索されたタグを受け取る
    @tag=Tag.find(params[:tag_id])
    #検索されたタグに紐づく投稿を表示
    @sources=@tag.sources.page(params[:page]).per(10)
  end

  private

  def source_params
    params.require(:source).permit(:source, :purpose, :performance_review, :note, :rate, :recommended_rank,:is_public, :is_valid)
  end

end