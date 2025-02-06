class OrdersController < ApplicationController
  before_action :authenticate_user!, except: [:new]

  def new
    @crate = Crate.find(params[:crate_id])
    if @crate.event.nil?
      flash[:alert] = "Farmer unavailable"
    else
      @order = Order.new
    end
  end

  def create
    @crate = Crate.find(params[:crate_id])
    @order = @crate.orders.new(order_params)
    @order.event = @crate.event
    if @order.save
      redirect_to order_confirmation_path(@order)
    else
      render :new, alert: "ERROR: Order Not Created"
    end
  end

  def confirmation
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:name, :email, :event_id, :crate_id)
  end
end
