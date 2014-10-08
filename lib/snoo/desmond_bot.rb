
module Snoo

	module DesmondBot

		def kobe_title_search
			most_recent_posts = get_new_listings(subreddit:'nba', limit:10)
			relevant_listings = most_recent_posts['data']['children']
			relevant_listings.each do |listing|
				if listing['data']['title'].downcase.include?("kobe") || listing['data']['selftext'].downcase.include?("kobe")
					if @notified.include?(listing['data']['id'])
						return "No new posts were found"
					else
						message_body = "Title: #{listing['data']['title']}, Link: http://www.reddit.com#{listing['data']['permalink']}"
						self.send_pm(@owner, "New Kobe Post", message_body)
						@notified << listing['data']['id']
						return "New listings! Message(s) sent"
					end #end nested if
				else
					return "No matching posts found"
				end #end if statement
			end #end each block
			
		end #end kobe_title_search method

		#options that can be passed are subreddit name and limit for number of listings returned
		def get_new_listings opts = {}
		  # Build the basic url
		  if opts[:subreddit]
		  	url = '/r/' + opts[:subreddit] + '/new/.json'
		  else
		  	url = "/new/.json"
		  end
		  #limit option passed? if not just send empty hash
		  opts[:limit] ? query = {limit:opts[:limit]} : query = {}
		  get(url, query: query)
		end

		def subscribe(subreddit)
			logged_in?

			#see the subreddit_info method in subreddits.rb
			subreddit_json = self.subreddit_info(subreddit)
			subreddit_id = subreddit_json['kind'] + "_" + subreddit_json['data']['id']
			
			server_response = self.class.post('/api/subscribe.json',
				body:{uh:@modhash, action:'sub', sr: subreddit_id, api_type:'json'})
			return "Successfully subscribed to r/#{subreddit}" if server_response.code == 200
			return "Error code: #{server_response.code}" unless server_response == 200
		end

		def unsubscribe(subreddit)
			logged_in?

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