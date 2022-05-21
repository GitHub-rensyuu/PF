class Public::SearchesController < ApplicationController
  before_action :authenticate_customer!
  
  def search
    @search = Source.ransack(params[:q])
    @sources = @search.result.page(params[:page]).per(10)
  end
  
  
  
  # def search
  #   @model = params["model"]
  #   # 選択した検索方法の値を@methodに代入。
  #   @method = params["method"]
  #   # 検索ワードを@contentに代入。
  #   @content = params["content"]
  #   # @model, @content, @methodを代入した、
  #   # search_forを@recordsに代入。
  #   @records = search_for(@model, @content, @method)
    
  # end

  # private
  # def search_for(model, content, method)
  #   # 選択したモデルがcustomerだったら
  #   if model == 'customer'
  #       Customer.where('nickname LIKE ?', "%#{content}%").where(is_deleted: false).where(is_deleted: false).page(params[:page]).per(2)
  #   # 選択したモデルsourceだったら
    
  #   elsif model == 'source'
  #     if method == 'beginner_match'
  #       Source.where(is_public: true).where('purpose LIKE ?', "%#{content}%").where(is_public: true).where(recommended_rank: 0).page(params[:page]).per(2)
  #     elsif method == "intermediate_match"
  #       Source.where(is_public: true).where('purpose LIKE ?', "%#{content}%").where(is_public: true).where(recommended_rank: 1).page(params[:page]).per(2)
  #     elsif method == "senior_match"
  #       Source.where(is_public: true).where('purpose LIKE ?', "%#{content}%").where(is_public: true).where(recommended_rank: 2).page(params[:page]).per(2)
  #     end
  #   end
  # end
end
