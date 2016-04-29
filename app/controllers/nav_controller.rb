class NavController < PermissionsController
  def index
    @notification = Order.where(ordered: false)
    render :index
  end
end
