class DashboardController < PermissionsController
  before_action :authenticate_user!
end
