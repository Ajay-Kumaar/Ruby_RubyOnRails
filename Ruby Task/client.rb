#Importing the required modules

#RestClient - To send API Calls/Requests to the API Endpoints in the Server
require 'rest-client'


#Method to send API Call/Request to populate jids in the jid_pools table
def populate_jids count
	#API Call/Request with post method and count parameter
  RestClient.post "http://localhost:4567/populate_jids", { count: count }
end


#Method to send API Call/Request to populate users in the users table
def populate_users count
	#API Call/Request with post method and count parameter
  RestClient.post "http://localhost:4567/populate_users", { count: count }
end


#Loop to invoke the above defined methods to send API Calls/Requests to the API Endpoints in the Server
loop do
	print "\nEnter 1 to populate jids and 2 to populate users: "
	user_choice = gets
	if user_choice.chomp == "1"
		print "\nEnter the required count to populate jids: "
		jids_count = gets.chomp
		#Method call to invoke API Call/Request
		puts populate_jids jids_count
	else
		print "\nEnter the required count to populate users: "
		users_count = gets.chomp
		#Method call to invoke API Call/Request
		puts populate_users users_count
	end
	print "\n\nDo you want to continue with the API Calls/Requests? (y/n): "
	wantToContinue = gets
	break if wantToContinue == "n"
	print "\n"
end
