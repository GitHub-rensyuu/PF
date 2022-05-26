class Admin::FollowsController < ApplicationController
  before_action :authenticate_customer!
  def create
    if current_customer.nickname == "guestuser"
      flash[:notice] = "ゲストユーザーはこの機能を使えません"
    else
      following = current_customer.follow(params[:customer_id])
      flash[:notice] = if following.save
                          @customer = Customer.find(params[:customer_id])
                          @customer.create_notice_follow!(current_customer)
                         'ユーザーをフォローしました'
                       else
                         'ユーザーのフォローに失敗しました'
                       end
    end
      redirect_to request.referer
  end

  def destroy
      following = current_customer.unfollow(params[:customer_id])
      flash[:notice] = if following.destroy
                         'ユーザーのフォローを解除しました'
                       else
                         'ユーザーのフォロー解除に失敗しました'
                       end
      redirect_to request.referer
  end
end