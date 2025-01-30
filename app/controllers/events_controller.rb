class EventsController < ApplicationController
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

  private

  def event_params
    params.require(:event).permit(:name, :location, :start_time, :end_time, category_ids: [])
  end
end
