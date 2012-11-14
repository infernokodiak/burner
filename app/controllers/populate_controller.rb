class PopulateController < ApplicationController

  ROCKY_DUR = [20,20,21,21,22,23,24,25]
  ROCKY_INT = ['sparring','sparring','sparring','in-ring']
  ROCKY = 'rocky'

  APOLLO_DUR = [30,30,25,26,27,28,29]
  APOLLO_INT = ['punching-bag','punching-bag','punching-bag','sparring','sparring','in-ring']
  APOLLO = 'apollo'

  JOHN_DUR = [60,60,60,60,61,62,63,64,65,70,70,80,90]
  JOHN_INT = ['puching-bag','puching-bag','puching-bag','sparring']
  JOHN = 'john'

  MANNY_DUR = [60,60,60,60,61,62,63,64,65,70,70,80,90]
  MANNY_INT = ['sparring','sparring','in-ring','in-ring']
  MANNY = 'manny'

  def method_missing(method, *args)
    dates = get_dates()
    @data = []
    user = method.to_s
    dates.each do |date|
      dur = eval("#{method.to_s.upcase}_DUR").send(:sample)
      int = eval("#{method.to_s.upcase}_INT").send(:sample)
      a = Fetch::Activity.new({:aus_id => user, :type => int, :duration => dur, :date => "#{date}"})
      ary = a.save
      @data << ary.first
    end

    render :populated
  end


  # def rocky
  #   @data = []
  #   dates = get_dates()
  #   dates.each do |date|
  #     dur = ROCKY_DUR.sample
  #     int = ROCKY_INT.sample
  #     a = Fetch::Activity.new({:aus_id => ROCKY, :type => int, :duration => dur, :date => "#{date}"})
  #     ary = a.save
  #     @data << ary.first
  #   end

  #   render :populated    
  # end

  def get_dates
    dates = []
    (1..3).each do |n|
      this_date = Time.now + n.day
      dates << this_date.strftime("%Y-%m-%d")
    end
    dates
  end

end
