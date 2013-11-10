require 'json'
require 'rest-client'
require 'wikiwhat'


class Location
  attr_reader :title, :content, :image
  
  def initialize(options={})
    @title = options[:title]
    @coordinates = options[:coordinates]
    #  @content = get_content
    # @image =get_image
  end


  def get_content 
    @extract = Wikiwhat::Page.new(self.title, :num_paragraphs => 100)
    @all_paras = ""
    @extract.paragraphs.each do |x|
      @all_paras += x      
    end
    @all_paras.gsub(/<h2.*>|\\n/, "")
  end
  
  def get_image 
    img_url = Wikiwhat::Page.new(self.title, :sidebar_img => true)
    @image = img_url.sidebar_image
  end
end