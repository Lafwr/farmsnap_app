module ApplicationHelper

  # METHOD USED TO SHOW POST DATE AND TIME
  def post_timer(timestamp)

    now = Time.zone.now

    if (now - timestamp) < 24.hours
      timestamp.strftime('%H:%M') # Show only time if less than 24 hours
    else
      timestamp.strftime('%d-%Y-%m %H:%M') # Show full date and time
    end
  end
end
