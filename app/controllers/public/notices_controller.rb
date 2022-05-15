class Public::NoticesController < ApplicationController
  # def index
  #   # @notices = current_customer.passive_notices.(params[:page]).per(20)
  #   @notices = current_customer.passive_notices
  #   @notices.where(checked: false).each do |notice|
  #     notice.update_attributes(checked: true)
  #   end
  # end
  
  def index
    @notices = current_customer.passive_notices.page(params[:page]).per(20)
    @notices.where(checked: false).each do |notice|
      notice.checked = true
      notice.save
    end
  end
  
  def destroy
    # 通知を全削除
    @notices = current_customer.passive_notices.destroy_all
    redirect_to notices_path
  end

  def show
  end
end

