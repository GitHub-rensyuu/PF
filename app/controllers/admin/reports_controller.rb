class Admin::ReportsController < ApplicationController
  
  def destroy
    reporting = current_customer.unreport(params[:customer_id])
    flash[:notice] = if reporting.destroy
                       'ユーザーの通報を解除しました'
                     else
                       'ユーザーの通報解除に失敗しました'
                     end
    redirect_to request.referer
  end

end
