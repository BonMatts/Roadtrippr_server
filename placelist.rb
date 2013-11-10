require 'rest-client'
require 'json'
require 'open-uri'

class List
  #todo add distance to place from current location
  attr_reader :locations, :contents

  def initialize(array)

    @locations = []
    @contents ={}

    @locations = ["30.26737,-97.746162"]
  end

  def get_content
    @locations.each do |location|
      @coord =location.split(",")
      @lat = @coord[0]
      @long=@coord[1]
      self.api_call(@lat, @long)
      self.get_info
    end
  end



  def api_call(lat, long)

    @str = URI::encode("http://en.wikipedia.org/w/api.php?action=query&list=geosearch&gsradius=10000&gscoord=#{lat}|#{long}&format=json")
    @nearby = JSON.parse(RestClient.get(@str))
    puts @nearby
   
    @nearby["query"]["geosearch"].each do |x|
      x.each_pair do |key, value|
        if key == "title" && !@places.include?(value)
          @locations<<value
        end
      end
    end
    puts "locations found!"
    @locations
  end

  def get_info
    @locations.each do |place|
      # if place is in db 
      #   pull from db 
      # else 
      #place
      # send to db, 
    end
  end
end





