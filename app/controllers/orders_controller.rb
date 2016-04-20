class OrdersController < PermissionsController
  before_action :require_permission, only: [:edit, :destroy]
  before_action :authenticate_user!

  def index
    @orders = Order.all
  end

  def show
    current_user
    @order = Order.find(params[:id])
    @user = @order.user
    @access = current_user == @user || current_user.admin
  end

  def new
    @order = Order.new
  end

  def create
    @order = current_user.orders.build(order_params)
    if @order.save
      flash[:notice] = "You have added the order successfully"
      redirect_to order_path(@order)
    else
      flash[:alert] = @order.errors.full_messages.join(". ")
      render new_order_path
    end
  end

  def edit
    @order = Order.find(params[:id])
    @user = @order.user
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      flash[:notice] = "You have added the order successfully"
      redirect_to order_path(@order)
    else
      flash[:alert] = @order.errors.full_messages.join(". ")
      render :edit
    end
  end

  def destroy
    @order = Order.find(params[:id])
    @user = @order.user
    @order.destroy
    flash[:notice] = "You have added the order successfully"
    redirect_to orders_path
  end

  private

  def order_params
    params.require(:order).permit(:vendor_id, :user_id, :quantity, :cat_number, :url, :product_name, :webpage, :price)
  end
end
