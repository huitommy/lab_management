class OrdersController < PermissionsController
  before_action :set_order, only: [:show, :edit, :update, :destroy, :complete]
  before_action :require_permission, only: [:edit, :destroy]
  before_action :authenticate_user!

  def index
    @orders = Order.all.order(ordered: :asc, created_at: :desc)
    @user = current_user
  end

  def show
    @item = Item.new
    @items = @order.items
    @user = @order.user
    @current_user = current_user
    @access = @current_user == @user || @current_user.admin
  end

  def new
    @order = Order.new
  end

  def create
    @order = current_user.orders.build(order_params)
    @current_user = current_user
    if @order.save
      @order.create_activity :create, owner: current_user
      flash[:notice] = "You have created the order request successfully"
      redirect_to order_path(@order)
    else
      flash[:alert] = @order.errors.full_messages.join(". ")
      render new_order_path
    end
  end

  def edit
    @items = @order.items
    @user = @order.user
    @current_user = current_user
  end

  def update
    @current_user = current_user
    if @order.update(order_params)
        @order.create_activity :update, owner: current_user
      flash[:notice] = "You updated the order request successfully"
      redirect_to order_path(@order)
    else
      flash[:alert] = @order.errors.full_messages.join(". ")
      render :edit
    end
  end

  def destroy
    @user = @order.user
    @current_user = current_user
    @order.create_activity :destroy, owner: current_user
    @order.destroy
    flash[:notice] = "You have deleted the order request successfully"
    redirect_to orders_path
  end

  def search
    @current_user = current_user
    @orders = Order.search(params[:query])
    if @orders.empty?
      flash[:alert] = "Sorry, but we couldn't find any orders matching '#{params[:query]}'"
    end
    render :index
  end

  def complete
    if params[:order][:po_number] == ""
      flash[:alert] = "PO number can't be blank"
      redirect_to order_path(@order)
    elsif @order.update(order_params)
      @order.update_attribute(:ordered, true)
      @order.create_activity :complete, owner: current_user
      flash[:notice] = "You updated the order request successfully"
      redirect_to orders_path
    else

    end
  end

  private

  def order_params
    params.require(:order).permit(:vendor_id, :user_id, :po_number, :ordered, :total_price)
  end

  def set_order
    @order = Order.find(params[:id])
  end
end
