# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  
  def guest_sign_in
    customer = Customer.guest
    sign_in customer
    redirect_to customer_path(customer), notice: 'guestcustomerでログインしました。'
  end

  def after_sign_in_path_for(resource)
    customer_path(current_customer)
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  protected

  def customer_state
    @customer = Customer.find_by(email: params[:customer][:email])
    return if !@customer
      if @customer.valid_password?(params[:customer][:password]) && (@customer.is_deleted == false)
        redirect_to new_customer_registration_path
      end
  end
end
