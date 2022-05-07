class Public::SearchesController < ApplicationController
  def search
    # viewのform_tagにて
    # 選択したmodelの値を@modelに代入。
    @model = params["model"]
    # 選択した検索方法の値を@methodに代入。
    @method = params["method"]
    # 検索ワードを@contentに代入。
    @content = params["content"]
    # @model, @content, @methodを代入した、
    # search_forを@recordsに代入。
    @records = search_for(@model, @content, @method)
  end

  private
  def search_for(model, content, method)
    # 選択したモデルがcustomerだったら
    if model == 'customer'
      # 選択した検索方法がが完全一致だったら
      if method == 'perfect_match'
        Customer.where(nickname: content)
      # 選択した検索方法がが前方一致だったら
      elsif method == "forward_match"
        Customer.where("nickname LIKE?", "#{content}%")
      # 選択した検索方法がが後方一致だったら
      elsif method == "backward_match"
        Customer.where("nickname LIKE?", "%#{content}")
      # 選択した検索方法がが部分一致だったら
      elsif method == "partial_match"
        Customer.where('nickname LIKE ?', "%#{content}%")
      end

    # 選択したモデルsourceだったら
    elsif model == 'source'
      if method == 'perfect_match'
        Source.where(purpose: content)
      elsif method == "forward_match"
        Source.where("purpose LIKE?", "#{content}%")
      elsif method == "backward_match"
        Source.where("purpose LIKE?", "%#{content}")
      elsif method == "partial_match"
        Source.where('purpose LIKE ?', "%#{content}%")
      end
    end
  end
end
