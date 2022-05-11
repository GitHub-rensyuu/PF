class Public::SearchesController < ApplicationController
  def search
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
        Customer.where('nickname LIKE ?', "%#{content}%")
    # 選択したモデルsourceだったら
    elsif model == 'source'
        Source.where('purpose LIKE ?', "%#{content}%")
    end
  end
  
  # def search_params
  #   params.require(:source).permit(:search,:search_radio)
  #   params.require(:custmer).permit(:search,:search_radio)
  # end
end
