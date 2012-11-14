class PopulateController < ApplicationController

  ROCKY_DUR = [20,30,60,90,120,240,300]
  ROCKY_INT = ['sparring','sparring','sparring','in-ring']
  ROCKY = 'rocky'

  APOLLO_DUR = [30,40,50,60,70,80,90,100]
  APOLLO_INT = ['punching-bag','punching-bag','punching-bag','sparring','sparring','in-ring']
  APOLLO = 'apollo'

  JOHN_DUR = [240,200,120,240,200,120,240,200]
  JOHN_INT = ['puching-bag','puching-bag','puching-bag','sparring']
  JOHN = 'john'

  MANNY_DUR = [60,70,80,90,100,110,120,150]
  MANNY_INT = ['sparring','sparring','in-ring','in-ring']
  MANNY = 'manny'

  def method_missing(method, *args)
    dates = get_dates()
    @data = []
    user = method.to_s
    dates.each do |date|
      dur = eval("#{method.to_s.upcase}_DUR").send(:sample, random:(1..8))
      int = eval("#{method.to_s.upcase}_INT").send(:sample, random:(1..4))
      a = Fetch::Activity.new({:aus_id => user, :type => 'boxing', :intensity => int, :duration => dur, :date => "#{date}"})
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
    (1..12).each do |n|
      this_date = Time.now + n.day
      dates << this_date.strftime("%Y-%m-%d")
    end
    dates
  end

end
