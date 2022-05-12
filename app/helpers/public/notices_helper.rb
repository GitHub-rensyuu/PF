module Public::NoticesHelper
  def unchecked_notices
    @notices = current_customer.passive_notices.where(checked: false)
  end
end
