class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @customers = Customer.page(params[:page]).per(10)
  end

  def show
    @customer = Customer.find(params[:id])
    @sources = @customer.sources.page(params[:page])
    @comments = @customer.comments.page(params[:page]).per(10)
    
    
    @following_customers = @customer.following_customers
    @follower_customers = @customer.follower_customers
    @reporting_customers = @customer.reporting_customers
    @reporter_customers = @customer.reporter_customers
    
    if params[:sort_draft]
      @sources = Source.where(is_public: false).where(customer_id: @customer.id).page(params[:page])
    elsif params[:sort_post]
      @sources = Source.where(is_public: true).where(customer_id: @customer.id).page(params[:page])
    else
      @sources = Source.where(customer_id: @customer.id).page(params[:page])
    end
    
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    customer = Customer.find(params[:id])
    customer.update(customer_params)
    redirect_to admin_customer_path(customer)
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
    params.require(:customer).permit(:profile_image, :name, :introduction, :is_deleted)
  end
end
