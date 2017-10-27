class VendorsController < ApplicationController
  def index
    @vendors = Vendor.online
  end

  def show
    @vendor = Vendor.find(params[:id])
    
  end

  def edit
    @vendor = Vendor.find(params[:id])
  end

  def update
    vendor = Vendor.find(params[:id])
    vendor.update(vendor_params)
    if vendor.save
      flash[:alert] = "You're awesome! #{vendor.name} updated!"
      redirect_to vendor_path
    else
      flash[:alert] = "That sure didn't work. Try again, please."
      render :edit
    end
  end

  private

  def vendor_params
    params.require(:vendor).permit(:name, :description, :image)
  end
  
  def update
    @vendor = Vendor.find(params[:id])
    @vendor.update(vendor_params)
    redirect_back(fallback_location: root_path)
  end
  
  private
  
    def vendor_params
      params.permit(:status, :id)
    end
end
