class PicturesController < ApplicationController
 

  

  def index

#https://api.500px.com/v1/photos?feature=user&user_id=1649557&sort=rating&rpp=100&image_size=1&include_store=store_download&include_states=voted&user=1649557

	response = F00px.get('photos?page=1&feature=user&user_id=1649557&sort=highest_rating&rpp=100&image_size=1&include_store=store_download&include_states=voted&user=1649557')
  	@p1 = ActiveSupport::JSON.decode(response.body)

	response = F00px.get('photos?page=2&feature=user&user_id=1649557&sort=highest_rating&rpp=100&image_size=1&include_store=store_download&include_states=voted&user=1649557')
  	@p2 = ActiveSupport::JSON.decode(response.body)
  	
  response = F00px.get('photos?page=3&feature=user&user_id=1649557&sort=highest_rating&rpp=100&image_size=1&include_store=store_download&include_states=voted&user=1649557')
    @p3 = ActiveSupport::JSON.decode(response.body)

    @p = @p1['photos']+@p2['photos']+@p3['photos']
  	@total = 0
    i =1
  	@p.each do |photo|
      puts photo['name']
      photo['nb'] = i
      created_at =  DateTime.parse(photo['created_at']).in_time_zone('Paris')
      puts created_at
  		@total = @total+photo['highest_rating']
      photo['day']=created_at.strftime("%A")
      puts photo['day']
      photo['hour']=created_at.strftime("%H")
      #puts photo['created_at']
      #puts "hour"
      puts photo['hour']

      puts "----"
      photo['perso_rating'] = i 
      i = i+1
      puts photo.inspect
  	end

  	@avg_rating = @total / @p.count
    @pdays = @p.group_by{ |p| p['day'] }

    days = @pdays.keys 

    @days = Array.new

    days.each do |day|
      total = 0
      @pdays[day].each do |photo|
        total = total + photo['highest_rating']
        photo['day']=Date.parse(photo['created_at']).strftime("%A")
      end
      avg_rating = total / @pdays[day].count

      thisday = Hash.new
      thisday["day"] = day
      thisday["count"] = @pdays[day].count
      thisday["avg_rating"] = avg_rating
      @days << thisday
    end
    #@days.sort_by { |hsh| hsh["avg_rating"] }

    @new_days = @days.sort! { |x, y| x["avg_rating"] <=> y["avg_rating"] }

    @days = @new_days

    #puts @days.inspect    

    @phours = @p.group_by{ |p| p['hour'] }

    hours = @phours.keys 

    @hours = Array.new

    hours.each do |hour|
      total = 0
      @phours[hour].each do |photo|
        total = total + photo['highest_rating']
        photo['hour']=Date.parse(photo['created_at']).strftime("%A")
      end
      avg_rating = total / @phours[hour].count

      thishour = Hash.new
      thishour["hour"] = hour
      thishour["count"] = @phours[hour].count
      thishour["avg_rating"] = avg_rating
      @hours << thishour
    end
    #@days.sort_by { |hsh| hsh["avg_rating"] }

    @new_hours = @hours.sort! { |x, y| x["avg_rating"] <=> y["avg_rating"] }

    @hours = @new_hours


  end

end
