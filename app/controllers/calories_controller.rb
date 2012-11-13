class CaloriesController < ApplicationController

  def index
    # retrieve all data for a particular user
    activities = Fetch::Activity.new
    @activities = activities.where(:aus_id => '111')
    binding.pry

    

  end

end
