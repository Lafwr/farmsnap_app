class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def favourites
    @farmers = current_user.followed_farmers.includes(:posts)
  end
end
