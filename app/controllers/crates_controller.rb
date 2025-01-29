class CratesController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def all

  end

  def seafood
    @crates = crates.where(category: “seafood”)
  end

  def dairy
    @crates = crates.where(category: “dairy”)
  end

  def meat
    @crates = crates.where(category: “meat”)
  end

  def organic
    @crates = crates.where(category: “organic”)
  end

  def halal
    @crates = crates.where(category: “halal”)
  end

  def fruit_and_veg
    @crates = crates.where(category: “fruit_and_veg”)
  end

  def baked_goods
    @crates = crates.where(category: “baked_goods”)
  end

  def alcohol
    @crates = crates.where(category: “alcohol”)
  end
end
