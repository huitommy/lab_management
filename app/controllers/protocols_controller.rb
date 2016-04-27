class ProtocolsController < PermissionsController
  before_action :authenticate_user!

  def index
    @protocols = Protocol.all.order(created_at: :desc)
  end

  def show
    @protocol = Protocol.find(params[:id])
  end

  def new
    @protocol = Protocol.new
  end

  def create
    @protocol = current_user.protocols.build(protocol_params)
    if @protocol.save
      flash[:notice] = "You have added the protocol successfully"
      redirect_to protocol_path(@protocol)
    else
      flash[:alert] = @protocol.errors.full_messages.join(". ")
      render new_protocol_path
    end
  end

  def edit
    @protocol = Protocol.find(params[:id])
  end

  def update
    @protocol = Protocol.find(params[:id])
    if @protocol.update(protocol_params)
      flash[:notice] = "You have updated the protocol successfully"
      redirect_to protocol_path(@protocol)
    else
      flash[:alert] = @protocol.errors.full_messages.join(". ")
      render :edit
    end
  end

  def destroy
    @protocol = Protocol.find(params[:id])
    @protocol.destroy
    flash[:notice] = "You have deleted the protocol successfully"
    redirect_to protocols_path
  end

  private

  def protocol_params
    params.require(:protocol).permit(:name, :document, :procedure)
  end
end
