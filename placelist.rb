require 'rest-client'
require 'json'
require 'open-uri'

class List
  attr_reader :places, :contents

  def initialize(array)

    @places = []
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
          @places<<value
        end
      end
    end
    puts "places found!"
    @places
  end

  def get_info
    @places.each do |place|
      @call = URI::encode("http://en.wikipedia.org/w/api.php?action=query&prop=extracts&titles=#{place}&redirects&format=json")
      @content =JSON.parse(RestClient.get(@call))
      @content = pull_from_hash(@content, "extract")
      puts "found some content for #{place}"
      @contents["#{place}"] = @content
    end
  end
end



def pull_from_hash(hash, key)
  @hash = hash
  @key = key
  puts "in the loop"

  if @hash.include?(@key)
    @result = @hash[@key]
  else
    @hash.each_pair do |k, v|
      if v.class == Hash
        pull_from_hash(v, @key)
      end
    end
    @result
  end
end
