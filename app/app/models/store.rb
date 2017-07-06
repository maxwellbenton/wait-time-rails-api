class Store < ApplicationRecord
  belongs_to :company
  has_many :wait_times
  has_many :store_comments
  has_many :comments, through: :store_comments

  geocoded_by :address 
  after_validation :geocode  

  def total_wait_time
      self.wait_times.map{|wt| wt.wait_time}.reduce(:+)
  end

  def average_wait_time
      if total_wait_time != nil then
        return total_wait_time/self.wait_times.length
      else
        return 0
      end
      
  end

  def estimated_wait_time
      curHour = (Time.now+(4*60*60)).to_s.split(" ")[1].split(":")[0]
      
      nearby_times = self.wait_times.select{|wt| wt.created_at.to_s.split(" ")[1].split(":")[0].include?(curHour)}
      if nearby_times.length > 0 then
        output = (nearby_times.map{|wt| wt.wait_time}.reduce(:+))/nearby_times.length
      else
        output = "?"
      end
      return nearby_times
  end
    
  def convert_wait_times
      self.wait_times.map{|wt| {wait_time: wt.wait_time/1000.to_f, year: wt.created_at.year, month: wt.created_at.month, weekday: wt.created_at.wday, hour: wt.created_at.hour}}
  end
  
  def wait_times_by_hour
      hours = Hash.new(0)
      total = Hash.new(0)
      hours_average = Hash.new(0)
      cwt = self.convert_wait_times.each{|cwt| 
        hours[cwt[:hour]] += 1
        total[cwt[:hour]] += cwt[:wait_time]
        }
      total.keys.map{|k| hours_average[k] = total[k]/hours[k]}

      return hours_average
  end
  

end
