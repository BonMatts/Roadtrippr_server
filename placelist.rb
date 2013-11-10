require 'rest-client'
require 'json'
require 'open-uri'
require "./mongo.rb"
require "./location.rb"

class List
  #todo add distance to place from current location
  attr_reader :locations, :coordinates, :locations

  def initialize(array)

    @input = array
    @coordinates = []
    @locations = []

    # @locations = ["30.26737,-97.746162"]
  end

  def get_content
    @input.each do |coordinate|
      @coord =coordinate.split(",")
      @coordinates << self.api_call(@coord[0], @coord[1])
      self.make_object
    end
  end



  def api_call(lat, long)

    @str = URI::encode("http://en.wikipedia.org/w/api.php?action=query&list=geosearch&gsradius=10000&gscoord=#{lat}|#{long}&format=json")
    puts @str
    @nearby = JSON.parse(RestClient.get(@str))
    puts "nearby things #{@nearby}"
   
    @nearby["query"]["geosearch"].each do |x|
      puts "found the title! #{x['title']}"
      @locations << {:title => "#{(x['title'])}", :coordinates =>"#{x['lat']},#{x['lon']}"}
    end
    puts "places found!#{@locations}"

    @locations
  end

  def make_object
    @coordinates.each do |locations|
      @locations.each do |place|
        # if db_search_collection(place[:title])
        #   puts "in db"
        #   place == db_search_collection(place[:title])
        # else
        puts "place is #{place}"
          @location_obj == Location.new(place)
          puts "created #{@location_obj}"

          # add_to_collection(@location_obj)
          # puts"added #{@location_obj} to db"

          place = @location_obj
        # end
      end 
    end
  end
end





