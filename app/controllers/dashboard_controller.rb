class DashboardController < PermissionsController
  before_action :authenticate_user!
  def index
    @activities = PublicActivity::Activity.order(created_at: :desc).limit(15)
  end
end
