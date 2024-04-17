#Importing the required modules

#Sinatra - To handle API Calls/Requests
require 'sinatra'
#MySQL - To work with MySQL Database
require 'mysql2'
#SecureRandom - To generate random strings
require 'securerandom'

#Initializing MySQL database. The output of the API Calls/Requests from the Client will be stored in the database - 'population'
DB = Mysql2::Client.new(host: 'localhost', username: 'root', password: 'Mysql@2024', database: 'data_population')


#Creating table jid_pools in the 'population' database
DB.query("CREATE TABLE IF NOT EXISTS jid_pools (
           id INT AUTO_INCREMENT PRIMARY KEY,
           jid VARCHAR(8),
           is_used BOOLEAN DEFAULT 0
         )"
)
#Creating table users in the 'population' database
DB.query("CREATE TABLE IF NOT EXISTS users (
           id INT AUTO_INCREMENT PRIMARY KEY,
           email VARCHAR(18),
           jid VARCHAR(8)
         )"
)


#Method to populate jids in the jid_pools table
def populate_jids count
  existing_unused_jids_hash = DB.query("SELECT COUNT(jid) AS count_of_unused_jids FROM jid_pools WHERE is_used = 0").first
  if (existing_unused_jids_hash['count_of_unused_jids']) == 0
  	count.times do
  		jid = SecureRandom.hex(4)
      DB.query("INSERT INTO jid_pools (jid) VALUES ('#{jid}')")
  	end
  	puts "\n\nInserted sufficient no. of jids.\n\n"
  elsif (existing_unused_jids_hash['count_of_unused_jids'] - count) < 50
    (50-(existing_unused_jids_hash['count_of_unused_jids'] - count)).times do
      jid = SecureRandom.hex(4)
      DB.query("INSERT INTO jid_pools (jid) VALUES ('#{jid}')")
    end
    puts "\n\nInserted sufficient no. of jids.\n\n"
  else
  	puts "\n\nSufficient no. of jids already available.\n\n"
  end
end


# API Endpoint (/populate_jids) along with the API Endpoint handler code (do...end block) to populate jids
post '/populate_jids' do
  count = params[:count].to_i
  populate_jids count
 	count.to_s + " jids successfully created."
end


# API Endpoint (/populate_users) along with the API Endpoint handler code (do...end block) to populate users
post '/populate_users' do
  count = params[:count].to_i
  populate_jids count # If /populate_users API Endpoint is directly called in the first time itself	 <---------\
  populate_jids count # To fill the required no. of jids -> eg. Start with /populate_users with a count of 100 |
  count.times do
    email = SecureRandom.hex(4) + "@gmail.com"
    jid = DB.query("SELECT jid FROM jid_pools WHERE is_used = 0 LIMIT 1").first['jid']
    DB.query("INSERT INTO users (email, jid) VALUES ('#{email}', '#{jid}')")
    DB.query("UPDATE jid_pools SET is_used = 1 WHERE jid = '#{jid}'")
  end
  count.to_s + " users successfully assigned with jids."
end
