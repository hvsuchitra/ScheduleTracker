class SchedulesController < ApplicationController
  before_action :set_schedule, only: [:show, :edit, :update, :destroy]
  
  def index
    @schedules =Schedule.all
  end
  
  def show
     id = params[:id] # retrieve movie ID from URI route
     @schedule = Schedule.find(id) 
  end
  
  def edit
  end
  
  def create
    @schedule = Schedule.create!(schedule_params)
    flash[:notice] = "#{@schedule.fname} was successfully created."
    redirect_to schedules_path
  end
  
  def update
    
  end
  
  def destroy
    
  end
  
  private
  
  def set_schedule
    @schedule = Schedule.find(params[:id])
  end
  
  
  def schedule_params
    params.require(:schedule).permit(:fname, :lname)
  end
  
  
    
  
  
  
end