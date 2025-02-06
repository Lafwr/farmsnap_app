class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ] #Jesse


  def index
    @events = Event.all # ✅ Ensure @events is always defined first

    if params[:query].present?
      search_location = Geocoder.search(params[:query]).first

      if search_location
        latitude = search_location.latitude
        longitude = search_location.longitude
        @events = Event.near([latitude, longitude], 10)
      else
        @events = @events.search_by_name_and_category(params[:query])
      end
    end

    @markers = @events.geocoded.map do |event|
      {
        lat: event.latitude,
        lng: event.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { event: event }),
        marker_html: render_to_string(partial: "marker")
      }
    end

    respond_to do |format|
      format.html # Normal page load
      format.turbo_stream # Turbo update
    end

  end

  def show
    @event = Event.find(params[:id])
    @marker = {
      lat: @event.latitude,
      lng: @event.longitude,
      info_window_html: render_to_string(partial: "info_window", locals: { event: @event }),
      marker_html: render_to_string(partial: "marker")
    }
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

  def by_category
    category = Category.find_by(name: params[:category_name].capitalize)

    if category
      @events = category.events
    else
      @events = Event.none # No events found for this category
    end

    render :index
  end

  def my_events
    if current_user.farmer
      @my_events = current_user.farmer.events
    else
      @my_events = []
      flash[:alert] = "You are not associated with a farmer account."
    end
  end

  def new_my_event
    if current_user.farmer
      @farmer = current_user.farmer
      @event = current_user.farmer.event.build
    else
      redirect_to root_path, alert: "You must be a farmer to create an event."
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :location, :start_time, :end_time, category_ids: [])
  end
end

def set_farmer
  @farmer = Farmer.find(params[:farmer_id])
end

def set_crate
  @event = Event.find(params[:id])
end
