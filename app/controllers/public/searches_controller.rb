class Public::SearchesController < ApplicationController
  before_action :authenticate_customer!
  
  def search
    @model = params["model"]
    # 選択した検索方法の値を@methodに代入。
    @method = params["method"]
    # 検索ワードを@keywordに代入。
    @keyword = params["keyword"]
    # @model, @keyword, @methodを代入した、
    # search_forを@recordsに代入。
    @records = search_for(@model, @keyword, @method)

    if @model == 'source'
      unless params["sort"].blank?
        case params["sort"]
        when 'default','new' then
          @sources = @records.order(created_at: :desc).page(params[:page])
        when 'rate' then
          @sources = @records.order(rate: :desc).page(params[:page])
        when 'like' then
          @things = @records.includes(:likes).sort{|a,b| b.likes.size <=> a.likes.size}
          @sources = Kaminari.paginate_array(@things).page(params[:page])
        when 'comment' then
          @things =  @records.includes(:comments).sort {|a,b| b.comments.size <=> a.comments.size}
          @sources = Kaminari.paginate_array(@things).page(params[:page])
        when 'watch' then
          @things = @records.includes(:view_counts).sort {|a,b| b.view_counts.size <=> a.view_counts.size}
          @sources = Kaminari.paginate_array(@things).page(params[:page])
        end
      end
    else
      unless params["sort"].blank?
      case params["sort"]
      when "default",'source' then
        @things =  @records.includes(:sources).sort {|a,b| b.sources.size <=> a.sources.size}
        @customers = Kaminari.paginate_array(@things).page(params[:page])
      when 'comment' then
        @things =  @records.includes(:comments).sort {|a,b| b.comments.size <=> a.comments.size}
        @customers = Kaminari.paginate_array(@things).page(params[:page])
      when 'follow' then
        @things =  @records.includes(:followers).sort {|a,b| b.follower_customers.size <=> a.follower_customers.size}
        @customers = Kaminari.paginate_array(@things).page(params[:page])
      when 'report' then
        @things = @records.includes(:reporters).sort {|a,b| b.reporter_customers.size <=> a.reporter_customers.size}
        @customers = Kaminari.paginate_array(@things).page(params[:page])
      when 'like' then
        @things = @records.includes(:likes).sort {|a,b| Like.where(source_id: b.sources.pluck(:id)).size <=> Like.where(source_id: a.sources.pluck(:id)).size } 
        @customers = Kaminari.paginate_array(@things).page(params[:page])
      when 'useful' then
        @things = @records.includes(:usefuls).sort {|a,b| Useful.where(comment_id: b.comments.pluck(:id)).size <=> Useful.where(comment_id: a.comments.pluck(:id)).size } 
        @customers = Kaminari.paginate_array(@things).page(params[:page])
      end
      end
    end
  end  

  private
  
  def search_for(model, keyword, method)
    # 選択したモデルcustomerだったら
    if model == 'customer'
        Customer.where('nickname LIKE ?', "%#{keyword}%")
    
    # 選択したモデルsourceだったら
    elsif model == 'source'
      if method == 'beginner_match'
        Source.where(is_public: true).where('purpose LIKE ?', "%#{keyword}%").where(is_public: true).where(recommended_rank: 0)
      elsif method == "intermediate_match"
        Source.where(is_public: true).where('purpose LIKE ?', "%#{keyword}%").where(is_public: true).where(recommended_rank: 1)
      elsif method == "senior_match"
        Source.where(is_public: true).where('purpose LIKE ?', "%#{keyword}%").where(is_public: true).where(recommended_rank: 2)
        
      elsif method == "all"
        Source.where(is_public: true).where('purpose LIKE ?', "%#{keyword}%").where(is_public: true)
      end
    end
  end
  
end











# ransackで検索を高速化予定
#   def search
    
# # if params[:q].present?
# # # 検索フォームからアクセスした時の処理
# #   @keyword = params[:q][:purpose_cont]
# #   @search = Source.ransack(search_params)
# #   @sources = @search.result.page(params[:page]).per(5)
# #   @count = @sources.count
# #   @counts = @search.result.count
# # else
# # # 検索フォーム以外からアクセスした時の処理
# #   params[:q] = { sorts: 'id desc' }
# #   @search = Source.ransack()
# #   @sources = Source.all.where(is_public: true).page(params[:page]).per(5)
# # end
    
    
#     # unless params[:source].blank?
#     #   case params[:source][:sort]
#     #   when 'new' then
#     #     @sources =Source.where(is_public: true).order(created_at: :desc).page(params[:page])
#     #   when 'rate' then
#     #     @sources = Source.where(is_public: true).order(rate: :desc).page(params[:page])
#     #   when 'like' then
#     #     @things = Source.where(is_public: true).includes(:likes).sort{|a,b| b.likes.size <=> a.likes.size}
#     #     @sources = Kaminari.paginate_array(@things).page(params[:page])
#     #   when 'comment' then
#     #     @things =  Source.where(is_public: true).includes(:comments).sort {|a,b| b.comments.size <=> a.comments.size}
#     #     @sources = Kaminari.paginate_array(@things).page(params[:page])
#     #   when 'watch' then
#     #     @things = Source.where(is_public: true).includes(:view_counts).sort {|a,b| b.view_counts.size <=> a.view_counts.size}
#     #     @sources = Kaminari.paginate_array(@things).page(params[:page])
#     #   end
#     # end