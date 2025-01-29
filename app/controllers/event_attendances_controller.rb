class EventAttendancesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [:create, :destroy]
  before_action :set_event_attendance, only: [:create, :destroy]

  def create
    @attendance = current_user.farmer.event_attendances.build(event_attendance_params)
    @attendance.event = @event

    if @attendance.save
      redirect_to @event, notice: "Great! You have marked your attendance for this event"
    else
      redirect_to @event, alert: @attendance.errors.full_messages.join(", ")
    end
  end

  def destroy
    if @attendance.destroy
      redirect_to @event, notice: "You have removed your attendance from this event"
    else
      redirect_to @event, alert: "Attendance removal failed"
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_event_attendance
    @attendance = current_user.farmer.event_attendances.find_by(event_id: @event.id)
  end

  def event_attendance_params
    params.require(:event_attendance).permit(:start_time, :end_time)
  end
end
