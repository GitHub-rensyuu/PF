class Public::CustomersController < ApplicationController
  before_action :ensure_guest_customer, only: [:edit]
  before_action :ensure_correct_customer, only: [:edit, :update]

  def index
    @customers = Customer.all
    @customer = Customer.new
    unless params[:customer].blank?
      case params[:customer][:keyword]
       when 'source' then

       @customers =  Customer.includes(:sources).sort {|a,b| b.sources.size <=> a.sources.size}
       when 'comment' then
       @customers =  Customer.includes(:comments).sort {|a,b| b.comments.size <=> a.comments.size}
       when 'follow' then
        @customers =  Customer.includes(:followers).sort {|a,b| b.follower_customers.size <=> a.follower_customers.size}
       when 'report' then
        @customers = Customer.includes(:reporters).sort {|a,b| b.reporter_customers.size <=> a.reporter_customers.size}
       when 'like' then
        @customers = Customer.includes(:likes).sort {|a,b| Like.where(source_id: b.sources.pluck(:id)).size <=> Like.where(source_id: a.sources.pluck(:id)).size } 
       when 'useful' then
        @customers = Customer.includes(:usefuls).sort {|a,b| Useful.where(comment_id: b.comments.pluck(:id)).size <=> Useful.where(comment_id: a.comments.pluck(:id)).size } 
      end
    end
  end

  def show
    @customer = Customer.find(params[:id])
    @source = Source.new
    @sources = Source.where(customer_id: @customer.id)
    @following_customers = @customer.following_customers
    @follower_customers = @customer.follower_customers
    @reporting_customers = @customer.reporting_customers
    @reporter_customers = @customer.reporter_customers
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
    customer = Customer.find(params[:id])
    @customers = customer.following_customer
    # @customers = customer.following_customer.page(params[:page]).per(3).reverse_order
  end
  def followers
    customer = Customer.find(params[:id])
    @customers = customer.follower_customer
    # @customers = customer.follower_customer.page(params[:page]).per(3).reverse_order
  end
  
  # 会員に通報された人、会員を通報した人一覧表示
  def reporteds
    customer = Customer.find(params[:id])
    @customers = customer.reporting_customer
    # @customers = customer.reporting_customer.page(params[:page]).per(3).reverse_order
  end
  def reporters
    customer = Customer.find(params[:id])
    @customers = customer.reporter_customer
    # @customers = customer.reporter_customer.page(params[:page]).per(3).reverse_order
  end
  def likes
    customer = Customer.find(params[:id])
    @sources = customer.likes.map{|like| like.source}
    # @customers = customer.reporter_customer.page(params[:page]).per(3).reverse_order
  end
  

  private

  def customer_params
    params.require(:customer).permit(:nickname, :birthday, :introduction,:telephone_number, :sex)
  end

  def ensure_correct_customer
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


