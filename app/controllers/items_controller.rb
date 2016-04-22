class ItemsController < PermissionsController
  before_action :authenticate_user!

  def create
    @order = Order.find(params[:order_id])
    @item = Item.new(item_params)
    @items = @order.items
    @item.order = @order

    if @item.save
      flash[:notice] = 'Item Added!'
      redirect_to order_path(@order)
    else
      flash[:error] = @item.errors.full_messages.join(', ')
      render 'orders/show'
    end
  end

  def edit
    @item = Item.find(params[:id])
    @order = @item.order
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = 'Item was updated successfully!'
      redirect_to order_path(@item.order)
    else
      flash[:error] = @item.errors.full_messages.join('. ')
      render :edit
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @order = @item.order
    @item.destroy
    flash[:notice] = "Item was removed!"
    redirect_to @order
  end

  private

  def item_params
    params.require(:item).permit(:order_id, :quantity, :cat_number, :url, :price, :product_name)
  end
end
