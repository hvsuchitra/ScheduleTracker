require 'rails_helper'

RSpec.describe Schedule, type: :model do
  it "is valid with valid attributes" do
		schedule = Schedule.new(name: "Subbu",
												date: "2021-06-29", 
												start_time: "6:00", 
                        end_time: "10:00", 
												availability: "Available")
		expect(schedule).to be_valid
	end
end