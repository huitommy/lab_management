class VendorsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @vendors = Vendor.all
  end

  def show
    @vendor = Vendor.find(params[:id])
  end

  def new
    @vendor = Vendor.new
  end

  def create
    @vendor = Vendor.new(vendor_params)
    if @vendor.save
      flash[:notice] = "You have added the vendor successfully"
      redirect_to vendor_path(@vendor)
    else
      flash[:alert] = @vendor.errors.full_messages.join(". ")
      render 'vendor/show'
    end
  end

  def edit
    @vendor = Vendor.find(params[:id])
  end

  def update
    @vendor = Vendor.find(params[:id])
    if @vendor.update(vendor_params)
      flash[:notice] = "You have added the vendor successfully"
      redirect_to vendor_path(@vendor)
    else
      flash[:alert] = @vendor.errors.full_messages.join(". ")
      render :edit
    end
  end

  def destroy
    @vendor = Vendor.find(params[:id])
    @vendor.destroy
    flash[:notice] = "You have added the vendor successfully"
    redirect_to vendors_path
  end

  private

  def vendor_params
    params.require(:vendor).permit(:name, :address, :city, :state, :zipcode, :telephone, :webpage)
  end
end
