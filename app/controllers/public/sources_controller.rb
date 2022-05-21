class Public::SourcesController < ApplicationController
  before_action :authenticate_customer!
  def show
    @newsource = Source.new
    @source = Source.find(params[:id])
    

    @customer = @source.customer
    @comment = Comment.new
    @comments = @source.comments.page(params[:page]).per(5)
    @source_tags = @source.tags
    unless ViewCount.find_by(customer_id: current_customer.id, source_id: @source.id)
      current_customer.view_counts.create(source_id: @source.id)
    end
  end
  def index
    
    @customer = current_customer
    @source = Source.new
    @sources = Source.where(is_public: true).order('id DESC').page(params[:page])
    @tag_list=Tag.all
    @source_tags = @source.tags
    
    unless params[:source].blank?
      case params[:source][:keyword]
       when 'new' then
        @sources = Source.where(is_public: true).order(created_at: :desc).page(params[:page])
       when 'rate' then
        @sources = Source.where(is_public: true).order(rate: :desc).page(params[:page])
       when 'like' then
        # kaminari適用するために以下のように描く（リファクタリングしたい）
        @things = Source.where(is_public: true).includes(:likes).sort{|a,b| b.likes.size <=> a.likes.size}
        @sources = Kaminari.paginate_array(@things).page(params[:page])
        
       when 'comment' then
        @things =  Source.where(is_public: true).includes(:comments).sort {|a,b| b.comments.size <=> a.comments.size}
        @sources = Kaminari.paginate_array(@things).page(params[:page])
       when 'watch' then
        @things = Source.where(is_public: true).includes(:view_counts).sort {|a,b| b.view_counts.size <=> a.view_counts.size}
        @sources = Kaminari.paginate_array(@things).page(params[:page])
      end
    end
  
  end
  
  def new
    @source = Source.new
  end

  def create
    @source = Source.new(source_params)
    @source.customer_id = current_customer.id
    # NGワードを定義
    blacklist = "死ね|殺す"
    
    if @source.purpose.match?(/(.*)#{blacklist}(.*)/)
        flash[:alert] = "NGワードが含まれています。"
        # name:publicをdelete
        @customer = current_customer
        @sources = Source.all
        render 'new'
    elsif params[:public]
      if !@source.save(context: :publicize)
        flash[:alert] = "登録できませんでした。"
        @customer = current_customer
        @sources = Source.all
        render 'new'
      else
        @source.update(is_public: true)
        tag_list=params[:source][:tagname].split(',')
        @source.save_tag(tag_list)
        redirect_to source_path(@source.id), notice: "情報ソース作成しました!"
      end
    elsif params[:draft]
      if !@source.update(is_public: false)
        flash[:alert] = "登録できませんでした。"
        @customer = current_customer
        @sources = Source.all
        render 'new'
      else
        tag_list=params[:source][:tagname].split(',')
        redirect_to source_path(@source.id), notice: "情報ソースの下書き保存しました！"
      end
    end
  end

  def edit
    @source = Source.find(params[:id])
    @tag_list = @source.tags.pluck(:tagname).join(',')
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
    
    @source.purpose = source_params[:purpose]
    
    # NGワードがあった場合
    if @source.purpose.match?(/(.*)#{blacklist}(.*)/)
        @source.is_public = false
        flash[:alert] = "登録できませんでした。NGワードが含まれています。"
        @customer = current_customer
        @sources = Source.all
        render 'edit'
    
    # ①下書き更新（公開）の場合
    elsif @source.is_public == false && params[:public]
      # 情報ソース公開時にバリデーションを実施
      # updateメソッドにはcontextが使用できないため、公開処理にはattributesとsaveメソッドを使用する
      tag_list=params[:source][:tagnames].split(',')
      @source.save_tag(tag_list)
      binding.pry
      @source.attributes = source_params.merge(is_public: true)
      if @source.save(context: :publicize)
        @source.save_tag(tag_list)
        redirect_to source_path(@source.id), notice: "下書きの情報ソースを公開しました！"
      else
        @source.is_public = false
        render :edit, alert: "情報ソースを公開できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      end
    # ②公開済み更新の場合
    elsif @source.is_public == true
      @source.attributes = source_params
      tag_list=params[:source][:tagnames].split(',')
      if @source.save(context: :publicize)
        # このsource_idに紐づいていたタグを@oldに入れる
          @old_relations = SourceTag.where(source_id: @source.id)
          # それらを取り出し、消す。消し終わる
          @old_relations.each do |relation|
            relation.delete
          end
          @source.save_tag(tag_list)
        redirect_to source_path(@source.id), notice: "情報ソースを更新しました！"
      else
        render :edit, alert: "情報ソースを更新できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      end
    # ③下書き更新（非公開）の場合
    elsif @source.is_public == false && params[:draft]
      if @source.update(source_params)
        redirect_to source_path(@source.id), notice: "下書き情報ソースを更新しました！"
      else
        render :edit, alert: "更新できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      end
    end
  end
    
  def destroy
    @source = Source.find(params[:id])
    if @source.destroy
      flash[:notice]="削除しました"
      redirect_to customer_path(current_customer) 
    end
  end

  def search_source
     @source = Source.new
     @sources = Source.where(is_public: true).search(params[:keyword])
  end
  
  # def search
  #   selection = params[:keyword]
  #   @things = Source.where(is_public: true)
  #   @things.sort(selection)
  #   @sources = Kaminari.paginate_array(@things).page(params[:page])
  # end

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