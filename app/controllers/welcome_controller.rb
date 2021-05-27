class WelcomeController < ApplicationController
  skip_before_action :keep_out_unless_logged_in
  def landing_page
    @action = 'login'
  end
  
end