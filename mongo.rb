require 'rubygems'
require 'mongo'
require 'uri'
require 'json'
include Mongo

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
  puts db_name
end

puts 'hello'
