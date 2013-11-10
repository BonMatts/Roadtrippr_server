require 'json'
require 'rest-client'
require 'wikiwhat'


class Location
  attr_reader :title, :content, :image
  
  def initialize(title)
    @title = title
    @content
    @image
  end


  def get_content 
    @extract = Wikiwhat::Page.new(title, :num_paragraphs => 100)
    @content = @extract.
    @content = @content.gsub(/<h2.*>|\\n/, "")
  end
  
  def get_image 
    img_url = Wikiwhat::Page.new(self.title, :sidebar_img => true)
    @image = img_url.sidebar_image
  end



