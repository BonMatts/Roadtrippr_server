require 'rubygems'
require 'mongo'
require 'uri'
require 'json'
require 'dotenv'
Dotenv.load

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

# Return an array of hashes. Each hash is a record in the Mongo DB, daytrippr
def return_collection
  trippr_array = []
  db = get_connection()
  collections = db.collection_names()
  last_collection = collections[-1]
  coll = db.collection(last_collection)

  # return each collection and add it to docs
  docs = coll.find()  

  # add each collection to the trippr_array
  docs.each{ |doc| trippr_array << doc.to_json }

  # once all collections are added return the trippr_array
  return trippr_array
end

# Based on a location, return the entire record a location is contained within
def db_search_collection(location)
   db = return_collection()

  db.each do |record| 
    if record.include?(location)
      true
    else
      false
    end
  end
end


db_search_collection("Lake Charles, LA")

# Below is an example value to search for in db_search_collection
# {"_id":{"$oid": "527f06d6584b2141453d2197"},"Name of Town/Location":"Lake Charles, LA","Coordinates":"30.235341,-93.190956"}

def add_to_collection(new_record = {})
  #new_record.each |key, value|
  id = @daytrippr.insert('#{new_record}')
  
end

