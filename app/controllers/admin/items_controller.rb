class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!

  def index
   @items = Items.page(params[:page]).per(10)
  end

  def show
    @items = Items.find(params[:id])
  end

  def new
   @items = Items.new
   @genres = Genre.where(is_active: true)
  end

  def create
    @items = Items.new(item_params)
    if @items.save
      redirect_to admins_items_path
    else
      @genres = Genre.where(is_active: true)
      render :new
    end
  end

  def edit
   @items = Items.find(params[:id])
   @genres = Genre.where(is_active: true)
  end

  def update
    @items = Items.find(params[:id])
    if @items.update(item_params)
    redirect_to admins_items_path(@item)
    end
  end

    private
  def item_params
    params.require(:item).permit(:name, :introduction, :price, :genre_id, :image, :is_active)
  end

end