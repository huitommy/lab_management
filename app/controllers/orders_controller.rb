class OrdersController < PermissionsController
  before_action :authenticate_user!
  before_filter :require_permission, only: [:edit, :destroy]

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    @access = current_user = @user || current_user.admin?
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
      render 'order/show'
    end
  end

  def edit
    @order = Order.find(params[:id])
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
    @order.destroy
    flash[:notice] = "You have added the order successfully"
    redirect_to orders_path
  end

  private

  def order_params
    params.require(:order).permit(:vendor_id, :user_id, :quantity, :cat_number, :url, :product_name, :webpage)
  end
end
