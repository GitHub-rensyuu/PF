class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!, except: [:guest_sign_in]
  before_action :ensure_guest_customer, only: [:edit]
  before_action :ensure_customer, only: [:edit, :update]

  def index
    @customers = Customer.all.page(params[:page])
    @customer = Customer.new
    unless params[:customer].blank?
      case params[:customer][:keyword]
       when 'source' then
         @things =  Customer.includes(:sources).sort {|a,b| b.sources.size <=> a.sources.size}
         @customers = Kaminari.paginate_array(@things).page(params[:page])
       when 'comment' then
         @things =  Customer.includes(:comments).sort {|a,b| b.comments.size <=> a.comments.size}
         @customers = Kaminari.paginate_array(@things).page(params[:page])
       when 'follow' then
        @things =  Customer.includes(:followers).sort {|a,b| b.follower_customers.size <=> a.follower_customers.size}
        @customers = Kaminari.paginate_array(@things).page(params[:page])
       when 'report' then
        @things = Customer.includes(:reporters).sort {|a,b| b.reporter_customers.size <=> a.reporter_customers.size}
        @customers = Kaminari.paginate_array(@things).page(params[:page])
       when 'like' then
        @things = Customer.includes(:likes).sort {|a,b| Like.where(source_id: b.sources.pluck(:id)).size <=> Like.where(source_id: a.sources.pluck(:id)).size } 
        @customers = Kaminari.paginate_array(@things).page(params[:page])
       when 'useful' then
        @things = Customer.includes(:usefuls).sort {|a,b| Useful.where(comment_id: b.comments.pluck(:id)).size <=> Useful.where(comment_id: a.comments.pluck(:id)).size } 
        @customers = Kaminari.paginate_array(@things).page(params[:page])
      end
    end
  end

  def show
    @customer = Customer.find(params[:id])
    @source = Source.new
    
    @following_customers = @customer.following_customers
    @follower_customers = @customer.follower_customers
    @reporting_customers = @customer.reporting_customers
    @reporter_customers = @customer.reporter_customers
    
    if params[:sort_draft]
      @sources = Source.where(is_public: false).where(customer_id: @customer.id).page(params[:page])
    elsif params[:sort_post]
      @sources = Source.where(is_public: true).where(customer_id: @customer.id).page(params[:page])
    elsif params[:sort_like]
      customer = Customer.find(params[:id])
      @things = @customer.likes.map{|like| like.source}
      @sources = Kaminari.paginate_array(@things).page(params[:page])
    else
      @sources = Source.where(customer_id: @customer.id).page(params[:page])
    end
  end
  
  def chart
    @customer = Customer.find(params[:id])
    @sources = Source.where(customer_id: @customer.id)
    @today_source =  @sources.created_today
    @this_week_source = @sources.created_this_week
    @last_week_source = @sources.created_last_week
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to customer_path(current_customer), notice: "会員情報を変更しました"
    else
      render "edit"
    end
  end

  def withdraw
    @customer = Customer.find(params[:id])
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  # フォロー、フォロワー一覧表示
  def follows
    @customer = Customer.find(params[:id])
    @customers = @customer.following_customers.page(params[:page])
  end
  def followers
    @customer = Customer.find(params[:id])
    @customers = @customer.follower_customers.page(params[:page])
  end
  
  # 会員に通報された人、会員を通報した人一覧表示
  def reporteds
    @customer = Customer.find(params[:id])
    @customers = @customer.reporting_customers.page(params[:page])
  end
  def reporters
    @customer = Customer.find(params[:id])
    @customers = @customer.reporter_customers.page(params[:page])
  end
  
  private

  def customer_params
    params.require(:customer).permit(:nickname, :birthday, :introduction,:telephone_number, :sex,:email, :is_deleted, :profile_image)
  end

  def ensure_customer
    @customer = Customer.find(params[:id])
    unless @customer == current_customer
      redirect_to customer_path(current_customer)
    end
  end
  
  def ensure_guest_customer
    @customer = Customer.find(params[:id])
    if @customer.nickname == "guestcustomer"
      redirect_to customer_path(current_customer) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end
  
end


