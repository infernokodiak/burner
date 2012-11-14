class CaloriesController < ApplicationController

  def index
    
    user_entry = Fetch::Activity.where(:aus_id => '11a',:type => 'user').all
    user_weight = 150
    user_entry.each do |entry|
      user_weight = entry.weight if entry.weight.present?
    end
    weight_group = calculate_weight_grouping(user_weight.to_i)

    @activities = Fetch::Activity.where(:aus_id => '11a').all
    @graph_data = []
    @activities.each do |act|

      # how to de-uglify
      if act.intensity.present?
        intensity = act.intensity
      else
        intensity = 'punching-bag'
      end

      e = Exercise.where(:name => "#{act.type}", :weight => "#{weight_group}", :intensity => "#{intensity}").first

      entry = {}
binding.pry      
      if e.try(:calories)
        entry.merge({:calories => e.calories})
binding.pry
        if act.date.present?
          entry.merge({:date => act.date})
          @graph_data << entry
        end
      end

    end

    # put the calories / update in the future

    binding.pry
    @graph_data

    @dates = "'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'"

    @rocky_balboa = "7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6"
    @apollo_creed = "-0.2, 0.8, 5.7, 11.3, 17.0, 22.0, 24.8, 24.1, 20.1, 14.1, 8.6, 2.5"

  end

  def calculate_weight_grouping(weight)
    case weight
    when 1..142
      return 130
    when 143..177
      return 155
    when 178..192
      return 180
    when 193..1000
      return 205
    else
      raise 'An error occurred.'
    end
  end

end
