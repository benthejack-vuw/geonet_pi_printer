require_relative './store'
require 'json'
require 'net/http'
require 'open-uri'

class QuakeWatcher

	def initialize 
		@quake_history = Store.new("./earthquake_history.yaml");
	end

	def watch api_url, delay, parser_class, &callback
		1.upto(Float::INFINITY) do |n|
		  sleep delay
		  quake = newest_unseen_quake(api_url, parser_class)
		  callback.call(quake) if quake
		end
	end

	def load_quakes api_url, parser_class
		begin
			uri = URI(api_url)
			response = Net::HTTP.get(uri) 
			results = JSON.parse(response)
			quakes = results["features"].map do|obj|
				 parser = parser_class.new
				 parser.update obj
				 parser
			end
			quakes.sort!
			quakes.reverse!
			return quakes
		rescue Exception => e
			puts "#{e.message}\n"
			return nil
		end
	end

	def most_recent_quake api_url, parser_class
		load_quakes(api_url, parser_class).first
	end

	def newest_unseen_quake api_url, parser_class
		most_recent = most_recent_quake(api_url, parser_class)

		unless @quake_history.contains? most_recent
			@quake_history.add_item most_recent
			@quake_history.save
			return most_recent
		else
			return nil
		end
			
	end

	

end
