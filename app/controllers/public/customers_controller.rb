class Public::CustomersController < ApplicationController
  before_action :ensure_guest_customer, only: [:edit]

  def index
    @customers = Customer.all
    @source = Source.new
  end

  def show
    @customer = Customer.find(params[:id])
    @source = Source.new
    @sources = Source.where(customer_id: @customer.id)
    @following_customers = @customer.following_customer
    @follower_customers = @customer.follower_customer 
    @reporting_customers = @customer.reporting_customer
    @reporter_customers = @customer.reporter_customer
  end
  
  def chart
    @customer = Customer.find(params[:id])
    @sources = Source.where(customer_id: @customer.id)
    @today_source =  @sources.created_today
    @this_week_source = @sources.created_this_week
    @last_week_source = @sources.created_last_week
  end

  def edit
    @customer = Customer.find(params[:id])
    unless @customer == current_customer
      redirect_to customer_path(current_customer)
    end
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to customer_path(current_customer), notice: "You have updated customer successfully."
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


