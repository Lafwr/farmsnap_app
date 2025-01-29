class CratesController < ApplicationController
  before_action :set_farmer, only: [:index, :new, :create]
  before_action :set_crate, only: [:show, :edit, :update, :destroy]

  def all
    @crates = Crate.all
  end

  def index
    @crates = @farmer.crates
  end

  def show
    # @name = @farmer.user.first_name
  end

  def new
    @crate = @farmer.crates.build
  end

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

  def crate_params
    params.require(:crate).permit(:flash_sale, :price, :name, :description)
  end
end
