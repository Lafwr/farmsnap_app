class OrdersController < ApplicationController
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
    @order = Order.new
    if @order.save
      redirect_to order_confirmation_path(@order)
    else
      @crate.event
      render :new, status: unprocessable_entity, alert: "ERROR: Order Not Created"
    end
  end

  def confirmation
    @order = Order.find(params[:id])
    qr_code = RQRCode::QRCode.new(order_url(@order))
    @qr_code_svg = qr_code.as_svg(module_size: 4)
  end

  private

  def order_params
    params.require(:order).permit(:name, :email, :event_id)
  end
end
