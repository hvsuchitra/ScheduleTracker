class SchedulesController < ApplicationController
  
  
  def show
   @schedule=set_schedule
  end
  
  def index
    @schedules =Schedule.all
  end
  
  def new
    @schedule = Schedule.new
  end
  
  
   def create
    @schedule = Schedule.create!(schedule_params)
    flash[:notice] = "Slot was successfully created."
    redirect_to schedules_path
  end
  
  def edit
    @schedule=set_schedule
  end
  
  def update
    @schedule=set_schedule
    @schedule.update_attributes!(schedule_params)
    flash[:notice] = "#{@schedule.name} was successfully updated."
    redirect_to schedule_path(@schedule)
  end
  
  def destroy
    @schedule=set_schedule
    @schedule.destroy
    flash[:notice] = "Slot '#{@schedule.name}' deleted."
    redirect_to schedules_path
  end
  
  private
  
 def set_schedule
   @schedule = Schedule.find params[:id]
 end
  
  
  def schedule_params
    params.require(:schedule).permit(:name, :date, :start_time, :end_time, :availability)
  end
  
  
end