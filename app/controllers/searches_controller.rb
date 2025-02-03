class SearchesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :search ]

  def search
    query = params[:query]
    category = params[:category]
    if query.blank?
      redirect_to root_path, alert: "Please enter a search term."
      return
    end
    if category == "events"
      redirect_to events_path(query: query)
    elsif category == "crates"
      redirect_to all_crates_path(query: query)
    else
      redirect_to root_path, alert: "Please select a category."
    end
  end
end
