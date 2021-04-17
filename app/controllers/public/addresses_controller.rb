class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!

  def index
    @addresse = Addresse.new
    @addresses = Addresse.all
  end

  def create
    @addresse = current_customer.addresses.new(addresse_params)
    if @addresse.save(addresse_params)
      redirect_to public_addresses_path
    else
      @addresses = Addresse.all
      render :index
    end
  end

  def edit
    @addresse = Addresse.find(params[:id])
  end

  def update
    @addresse = Addresse.find(params[:id])
    if @addresse.update(addresse_params)
      redirect_to public_addresses_path
    else
      render :edit
    end
  end

  def destroy
    @addresse = Addresse.find(params[:id])
    @addresse.destroy
    redirect_to public_addresses_path
  end

  private

  def addresse_params
    params.require(:addresse).permit(:postal_code, :address, :name)
  end
end
