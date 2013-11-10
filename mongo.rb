require 'rubygems'
require 'mongo'
require 'uri'
require 'json'
#require 'info'



# db = mongo_client.db("app16243887")
# db = MongoClient.new #("paulo.mongohq.com", 10029).db("app16243887")

# puts db

def get_connection
  return @db_connection if @db_connection
  db = URI.parse('mongodb://heroku:qwerty@paulo.mongohq.com:10029/app16243887')
  db_name = db.path.gsub(/^\//, '')
  @db_connection = Mongo::Connection.new(db.host, db.port).db(db_name)
  @db_connection.authenticate(db.user, db.password) unless (db.user.nil? || db.user.nil?)
  @db_connection
end


def return_collection
  trippr_array = []
  db = get_connection
  collections = db.collection_names()
  last_collection = collections[-1]
  coll = db.collection(last_collection)

  # return each collection and add it to docs
  docs = coll.find()  

  # add each collection to the trippr_array
  docs.each{ |doc| trippr_array << doc.to_json }

  # once all collections are added return the trippr_array
  return trippr_array

  # trippr_array.each do |collection|
  #   puts collection
  # end
end

def add_to_collection(new_record = {})
  #new_record.each |key, value|

  id = @daytrippr.insert('#{new_record}')

  #{"_id":
  #{"$oid": "527f06d6584b2141453d21aa"},"Name of Town/Location":"New Orleans, LA","Coordinates":"29.951365,-90.076332"}
end

