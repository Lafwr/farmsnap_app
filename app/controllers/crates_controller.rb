class CratesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ] #Jesse

  before_action :set_farmer, only: [:new, :create]
  before_action :set_crate, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new_my_crate, :my_crates, :create_my_crate]
  before_action :ensure_farmer, only: [:new_my_crate, :create_my_crate, :my_crates]

  def all
    @crates = Crate.all

    # 1️⃣ If latitude and longitude are provided (clicked from map button), use them directly
    if params[:latitude].present? && params[:longitude].present?
      latitude = params[:latitude].to_f
      longitude = params[:longitude].to_f
      @crates = Crate.near([latitude, longitude], 10).order("distance ASC")

    # 2️⃣ If a text query is provided (search bar), use Geocoder to find location
    elsif params[:query].present?
      search_location = Geocoder.search(params[:query]).first

      if search_location
        latitude = search_location.latitude
        longitude = search_location.longitude
        @crates = Crate.near([latitude, longitude], 10).order("distance ASC") # Orders by proximity
      else
        # 3️⃣ If Geocoder fails, fallback to a fuzzy name and location search in the database
        @crates = @crates.search_by_name_and_location(params[:query])
      end
    end

    @markers = @crates.geocoded.map do |crate|
      {
        lat: crate.latitude,
        lng: crate.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { crate: crate }),
        marker_html: render_to_string(partial: "marker", locals: { crate: crate })
      }
    end

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def super_sales
    @crates = Crate.where(flash_sale: true)
  end

  def my_crates
    if current_user.farmer
      @my_crates = current_user.farmer.crates
    else
      @my_crates = []
      flash[:alert] = "You are not associated with a farmer account."
    end
  end

  def new_my_crate
    if current_user.farmer
      @crate = current_user.farmer.crates.build
    else
      redirect_to root_path, alert: "You must be a farmer to create a crate."
    end
  end

  def create_my_crate
    @crate = current_user.farmer.crates.build(crate_params)
    if @crate.save
      redirect_to my_crates_path, notice: "Crate successfully created."
    else
      flash[:alert] = "Failed to create crate."
      render :new_my_crate
    end
  end

  def index
    @farmer = Farmer.find(params[:farmer_id])
    @crates = Crate.where(farmer: @farmer)
    # @crates = Crate.all All crates specific farmer
  end

  def show
    # @name = @farmer.user.first_name
    @products = Product.where(crate: @crate)
  end

  # Not needed: This would create the redundant /farmers/1/crate/new url
  # def new
  #   @crate = @farmer.Farmer.find(params[:farmer_id])
  # end


  def create
    @crate = @farmer.crates.build(crate_params)
    if @crate.save
      redirect_to farmer_crate_path(@farmer, @crate), notice: 'Crate was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @crate.update(crate_params)
      redirect_to farmer_crate_path(@crate.farmer, @crate), notice: 'Crate was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @crate.destroy
    redirect_to farmer_crates_path(@crate.farmer), notice: 'Crate was successfully deleted.'
  end

  private

  def set_farmer
    @farmer = Farmer.find(params[:farmer_id])
  end

  def set_crate
    @crate = Crate.find(params[:id])
  end

  def ensure_farmer
    unless current_user.farmer
      redirect_to root_path, alert: "You must be a farmer to create a crate."
    end
  end

  def crate_params
    params.require(:crate).permit(:flash_sale,
      :price,
      :name,
      :description,
      :event_id,
      products_attributes: [:id, :name, :quantity, :category, :_destroy])
  end
end
