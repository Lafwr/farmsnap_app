class EventsController < ApplicationController
  def index
    if params[:query].present?
      @events = @events.search_by_name_and_category(params[:query])
    else
      @events = Event.all
    end
    @markers = @events.geocoded.map do |event|
      {
        lat: event.latitude,
        lng: event.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { event: event }),
        marker_html: render_to_string(partial: "marker")
      }
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
  end

  def update
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to events_path, notice: "Event Created 🥳."
      # update to dashboard/my-events
    else
      render :new, status: unprocessable_entity, alert: "ERROR: Event Not Created"
    end
  end

  def destroy
  end

  def seafood
    @events = events.where(category: “seafood”)
  end

  def dairy
    @events = events.where(category: “dairy”)
  end

  def meat
    @events = events.where(category: “meat”)
  end

  def organic
    @events = events.where(category: “organic”)
  end

  def halal
    @events = events.where(category: “halal”)
  end

  def fruit_and_veg
    @events = events.where(category: “fruit_and_veg”)
  end

  def baked_goods
    @events = events.where(category: “baked_goods”)
  end

  def alcohol
    @events = events.where(category: “alcohol”)
  end

  private

  def event_params
    params.require(:event).permit(:name, :location, :start_time, :end_time, :category)
  end
end
