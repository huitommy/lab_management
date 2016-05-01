class DashboardController < PermissionsController
  before_action :authenticate_user!
  def index
    @activities = PublicActivity::Activity.order(created_at: :desc).limit(15)
    @orders = Order.all.order(created_at: :desc).limit(10)
    @protocols = Protocol.all.order(created_at: :desc).limit(10)
  end
end
