class EventAttendancesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [:create, :destroy]
  before_action :set_event_attendance, only: [:create, :destroy]

  def create
    @attendance = EventAttendance.new(event_attendance_params)
    @attendance.farmer = current_user.farmer
    @attendance.event = @event
    if @attendance.save
      redirect_to profile_path, notice: "Great! You have marked your attendance for this event"
    else
      redirect_to event_path(@event), alert: @attendance.errors.full_messages.join(", ")
    end
  end

  def destroy
    @attendance = EventAttendance.find(params[:id])
    if @attendance.destroy
      redirect_to farmer_path(current_user.farmer), notice: "You have removed your attendance from this event"
    else
      redirect_to @event, alert: "Attendance removal failed"
    end
  end

  def by_category
    category = Category.find_by(name: params[:category_name].capitalize)

    if category
      @event_attendances = category.event_attendances
    else
      @event_attendances = EventAttendance.none # No attendances found for this category
    end

    render :index
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_event_attendance
    @attendance = current_user.farmer.event_attendances.find_by(event_id: @event.id)
  end

  def event_attendance_params
    params.require(:event_attendance).permit(:start_time, :end_time, :month, :day, category_ids: [])
  end
end
