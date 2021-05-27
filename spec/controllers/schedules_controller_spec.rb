require 'rails_helper'

RSpec.describe SchedulesController, type: :controller do
  
  
  before(:each) do
    #byebug
		@user = User.create!(name: 'SUNY Tester', email: 'stester@binghamton.edu')
		@auth = Authorization.create!(provider: "github", uid: "123456", user_id: @user.id)
    session[:user_id] = @user.id
    @current_user= @user
    #simulates invocation of set schedule in filter
    @schedule = Schedule.create!(name: 'Subbu', date: '2021-06-29', start_time:'6:00',end_time:'10:00',availability:'Available') 
  end
  
  describe '#index' do 
    let(:schedule1) {instance_double('Schedule', name: 'Subbu', date: '2021-06-29', start_time:'6:00', end_time:'10:00', availability:'Available')}
    #let(:schedule2) {instance_double('Schedule', name: 'Subbu', date: '2021-06-29', start_time:'6:00', end_time:'10:00', availability:'Not Available')}
    let(:schedules) { [schedule1] }
		it 'Retrieves all the schedules' do
      #allow(Schedule).to receive(:all).and_return([schedule1, schedule2])
      allow(Schedule).to receive(:all).and_return([@schedule])
      get :index
        #expect(assigns(schedule1, schedule2)).to eq([:schedules])     
        expect(assigns(:schedules)).to eq(Schedule.all)
    end
   end

   describe '#new' do
    it 'selects the new template for rendering' do
      get :new
      expect(response).to render_template('new')
    end
  end

  
  
  describe '#create' do
    let(:params) { {name: 'Akhil', date: '2021-08-29', start_time:'8:00',end_time:'10:00',availability:'Available'} }
    let(:schedule) { instance_double('Schedule', params)}
    it 'Creates a new schedule' do
      expect(Schedule).to receive(:create!).with(params).and_return(schedule)
      post :create, schedule: params
    end
    it 'Makes the schedule Available to the template' do
      allow(Schedule).to receive(:create!).with(params).and_return(schedule)
      post :create, schedule: params
      expect(assigns(:schedule)).to eq(schedule)
    end
    it 'Sets a flash message' do
      allow(Schedule).to receive(:create!).with(params).and_return(schedule)
      post :create, schedule: params
      expect(flash[:notice]).to match(/^.* was successfully created.$/)  
    end
    it 'Redirects to the schedule page' do
      allow(Schedule).to receive(:create!).with(params).and_return(schedule)
      post :create, schedule: params
      expect(response).to redirect_to(schedules_path)
    end
  end
  
  
  describe '#show' do
		let(:id1)  {1}
    let(:params) { {name: 'Subbu', date: '2021-06-29', start_time:'6:00',end_time:'10:00',availability:'Available'} }
    let(:schedule) { instance_double('Schedule', params)}
    it 'Makes the Schedule Available to the Template' do
      get :show, id: id1
      expect(assigns(:schedule)).to eq(@schedule)
    end
    it 'selects the show template for rendering' do
      get :show, id: id1 
      expect(response).to render_template('show') 
    end
  end
  
  describe '#edit' do
		let(:id1) {'1'}
    #let(:params) { {name: 'Subbu', date: '2021-06-29', start_time:'6:00',end_time:'10:00',availability:'Available'} }
    let(:schedule) { instance_double('Schedule',name: 'Subbu', date: '2021-06-29', start_time:'6:00',end_time:'10:00',availability:'Available' )}
    it 'Makes the schedule Available to the template' do
       get :edit, id: id1 
      expect(assigns(:schedule)).to eq(@schedule)
    end
    it 'selects the edit template for rendering' do
      get :edit, id: id1 
      expect(response).to render_template('edit') 
    end
  end
  
  describe '#update' do
    let(:id1) {'1'}
    #let(:params)  { {name: 'Subbu', date: '2021-06-29', start_time:'6:00',end_time:'10:00',availability:'Available'} }
    let(:params1) { {name: 'Subbu', date: '2021-06-29', start_time:'6:00', end_time:'10:00', availability:'Not Available'} }
    let(:schedule) { instance_double('Schedule', params1)}
    #let(:params1)  {{"name"=>"Subbu", "date"=>"2021-06-29", "start_time"=>"8:00", "end_time"=>"10:00", "availability"=>"Not Available"} }
    #let(:schedule){ double( name: 'Subbu', date: '2021-06-29', start_time:'6:00', end_time:'10:00', availability:'Available')} 
    let(:updated) { instance_double('Schedule', start_time:'8:00', end_time:'12:00')}
    
    # <Schedule id: 1, name: "Subbu", date: "2021-06-29", start_time: "6:00", end_time: "10:00", availability: "Available">
    # <Schedule id: 1, name: "Subbu", date: "2021-06-29", start_time: "8:00", end_time: "10:00", availability: "Not Available">
    #   {"schedule"=>{"name"=>"Subbu", "date"=>"2021-06-29", "start_time"=>"8:00", "end_time"=>"10:00", "availability"=>"Not Available"}, "id"=>"1", "controller"=>"schedules", "action"=>"update"}
    
    it 'Updates the schedule attributes' do
      allow(controller).to receive(:set_schedule).and_return(schedule)
      expect(schedule).to receive(:update_attributes!).with(params1)
      put :update, id: id1, schedule: params1
    end
    #it 'Makes the schedule available to the template' do
     # allow(schedule).to receive(:update_attributes!).with(params1).and_return(updated)
      #put :update, id: id1, schedule: params1
      #expect(assigns(:schedule)).to eq(updated)
    #end
     it 'Sets a flash message' do
      allow(schedule).to receive(:update_attributes!).with(params1).and_return(updated)
      put :update, id: id1, schedule: params1
      expect(flash[:notice]).to match(/^.* was successfully updated.$/) 
    end
    it 'Redirects to the detail schedule page' do
      allow(controller).to receive(:set_schedule).and_return(schedule)
      allow(schedule).to receive(:update_attributes!).with(params1).and_return(updated)
      put :update, id: id1, schedule: params1
      expect(response).to redirect_to(schedule_path(schedule))
    end
  end
  
  
  describe '#destroy' do
		let(:id1) {'1'}
		let(:schedule) {instance_double('Schedule', name: 'Subbu', date: '2021-06-29', start_time:'6:00', end_time:'10:00', availability:'Not Available')}   
    it 'Calls the destroy method to delete the schedule' do
      expect(controller).to receive(:set_schedule).and_return(schedule)
      allow(schedule).to receive(:destroy)
	   	delete :destroy, :id => id1
	  end
    it 'Sets the flash message' do
      allow(schedule).to receive(:destroy)
      delete :destroy, :id => id1
      expect(flash[:notice]).to match(/^Slot \'[^']*\' deleted.$/)  
    end
    it 'Redirects to the schedules page' do
      allow(schedule).to receive(:destroy)
      delete :destroy, :id => id1
      expect(response).to redirect_to(schedules_path)
    end
  end

end