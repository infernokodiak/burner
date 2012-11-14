class CaloriesController < ApplicationController

  def index
    
    user_entry = Fetch::Activity.where(:aus_id => 'rocky',:activity_type => 'user').all
    user_weight = 180
    user_entry.each do |entry|
      user_weight = entry.weight if entry.weight.present?
    end
    weight_group = calculate_weight_grouping(user_weight.to_i)

    @activities = Fetch::Activity.where(:aus_id => 'rocky').all
    @rocky_data = []
    @activities.each do |act|
      # how to de-uglify
      if act.intensity.present?
        intensity = act.intensity
      else
        intensity = 'punching-bag'
      end
      # find related exercise
      e = Exercise.where(:activity_type => "#{act.type}", :weight => "#{weight_group}", :intensity => "#{intensity}").first
      # create hash
      entry = {}
      if e.try(:calories)
        if act.duration > 0
          calc_calories = (act.duration / 60.0) * e.try(:calories)
        else
          calc_calories = 0
        end        
        entry = entry.merge({:calories => calc_calories})
        if act.date.present?
          entry = entry.merge({:date => "'#{act.date}'"})
          @rocky_data << entry
        end
      end
    end

    @activities = Fetch::Activity.where(:aus_id => 'apollo').all
    @apollo_data = []
    @activities.each do |act|
      # how to de-uglify
      if act.intensity.present?
        intensity = act.intensity
      else
        intensity = 'punching-bag'
      end
      # find related exercise
      e = Exercise.where(:activity_type => "#{act.type}", :weight => "#{weight_group}", :intensity => "#{intensity}").first
      # create an entry as a hash

      entry = {}
      if e.try(:calories)
        if act.duration > 0
          calc_calories = (act.duration / 60.0) * e.try(:calories)
        else
          calc_calories = 0
        end

        entry = entry.merge({:calories => calc_calories})
        if act.date.present?
          entry = entry.merge({:date => "'#{act.date}'"})
          @apollo_data << entry
        end
      end

    end

    # for now grab all dates from apollo
    @dates = @apollo_data.collect {|e| e[:date]}
    
    @apollo = []
    @rocky = []
    
    # grab calories for each date
    @dates.each do |date|
      @apollo_data.each do |hsh|
        if hsh[:date] == date
          @apollo << hsh[:calories].to_i
          break
        end
      end
      @rocky_data.each do |hsh|
        if hsh[:date] == date
          @rocky << hsh[:calories].to_i
          break
        end
      end
    end

    @dates = @dates.join(",")

    # put the calories / update to your-active

    # sample data
    # @rocky_balboa = "7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6"
    # @apollo_creed = "-0.2, 0.8, 5.7, 11.3, 17.0, 22.0, 24.8, 24.1, 20.1, 14.1, 8.6, 2.5"
    @apollo_data = @apollo.join(",")
    @rocky_data = @rocky.join(",")

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
