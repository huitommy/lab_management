class OrdersController < PermissionsController
  before_action :require_permission, only: [:edit, :destroy]
  before_action :authenticate_user!

  def index
    @orders = Order.all.order(created_at: :desc)
  end

  def show
    current_user
    @order = Order.find(params[:id])
    @item = Item.new
    @items = @order.items
    @user = @order.user
    @access = current_user == @user || current_user.admin
  end

  def new
    @order = Order.new
  end

  def create
    @order = current_user.orders.build(order_params)
    if @order.save
      flash[:notice] = "You have created the order request successfully"
      redirect_to order_path(@order)
    else
      flash[:alert] = @order.errors.full_messages.join(". ")
      render new_order_path
    end
  end

  def edit
    @order = Order.find(params[:id])
    @items = @order.items
    @user = @order.user
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      flash[:notice] = "You updated the order request successfully"
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
    flash[:notice] = "You have deleted the order request successfully"
    redirect_to orders_path
  end

  def search
    @orders =  Order.search(params[:query])
    if @orders.empty?
      flash[:alert] = "Sorry, but we couldn't find any orders matching '#{params[:query]}'"
    end
    render :index
  end

  private

  def order_params
    params.require(:order).permit(:vendor_id, :user_id, :po_number, :ordered, :total_price)
  end
end
