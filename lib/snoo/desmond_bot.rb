#First steps
#login as bot to reddit -DONE
#subscribe to r/nba - DONE
#get targeted posts
##send that post via PM to my account

#Things to Add
#Hook this up to a SQLite database to save the post id to avoid sending duplicates in case of program termination
#setup a cron job to run the script every X minutes
#setup a cron job to open the terminal and execute script when computer starts

# *Can we login? YES
# *Can we subscribe to r/nba? YES
# *Can we send a PM? If so, why not? Do we need flair? Do we get a captcha warning? NO, KARMA, YES
# *How do I execute my script within the boundaries of this program?
module Snoo

	module DesmondBot

		def subscribe(subreddit)
			logged_in?
			subreddit = subreddit.downcase

			#see the subreddit_info method in subreddits.rb
			subreddit_json = self.subreddit_info(subreddit)
			subreddit_id = "#{subreddit_json['kind']}_#{subreddit_json['data']['id']}"
			
			server_response = self.class.post('/api/subscribe.json',
				body:{uh:@modhash, action:'sub', sr: subreddit_id, api_type:'json'})
			return "Successfully subscribed to r/#{subreddit}" if server_response.code == 200
			return "Error code: #{server_response.code}" unless server_response == 200
		end

		def unsubscribe(subreddit)
			logged_in?
			subreddit = subreddit.downcase

			#see the subreddit_info method in subreddits.rb
			subreddit_json = self.subreddit_info(subreddit)
			subreddit_id = "#{subreddit_json['kind']}_#{subreddit_json['data']['id']}"

			server_response = self.class.post('/api/subscribe.json',
				body:{uh:@modhash, action:'unsub', sr: subreddit_id, api_type:'json'})
			return "Successfully unsubscribed from r/#{subreddit}" if server_response.code == 200
			return "Error code: #{server_response.code}" unless server_response == 200
		end

	end #end DesmondBot module
end #end Snoo module