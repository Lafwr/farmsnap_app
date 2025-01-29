class FarmersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_not_farmer, only: [:new, :create]

  def index
    @farmers = Farmer.all
  end

  def show
    @farmer = Farmer.find(params[:id])
    @upcoming_events = @farmer.event_attendances.where("event_attendances.start_time >= ?", Time.now).order('event_attendances.start_time ASC').includes(:event).map(&:event)
    @attended_events = @farmer.events
  end

  def new
    @farmer = Farmer.new
  end

  def create
    @farmer = Farmer.new(farmer_params)
    @farmer.user = current_user
    if @farmer.save
      current_user.role = "farmer"
      redirect_to profile_path, notice: "Welcome Your Farmer Profile Has Been Created."
    else
      render :new, status: unprocessable_entity, alert: "ERROR: Farmer Profile Not Created"
    end
  end

  def edit
    @farmer = Farmer.find(params[:id])
  end

  def update
    if @farmer.update(farmer_params)
      redirect_to @farmer, notice: "Your Farmer Profile Has Been Updated."
    else
      render :edit, status: unprocessable_entity, alert: "ERROR: Farmer Profile Not Updated"
    end
  end

  def myprofile
    @farmer = current_user.farmer
  end


  private

  def farmer_params
    params.require(:farmer).permit(:bio, :location, :photo)
  end


  def ensure_not_farmer
    # redirect_to root_path, alert: "You already have a farmer profile."
    # if
    #   current_user.farmer.present?
    # end
  end
end
