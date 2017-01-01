require_relative './store'
require_relative './earthquakeData'
require 'json'
require 'net/http'
require 'open-uri'

class GeonetRuby

	def initialize logfile_url
		@logfile_url = logfile_url
		@quake_history = Store.new("./earthquake_history.yaml");
	end

	def load_quakes mmi_cutoff
		begin
			uri = URI("http://api.geonet.org.nz/quake?MMI=#{mmi_cutoff}")
			response = Net::HTTP.get(uri) 
			return JSON.parse(response)
		rescue Exception => e
			%x(echo "#{e.message}\n" >> "#{@logfile_url}") if !!@logfile_url
			return nil
		end
	end

	def most_recent_quake mmi_cutoff
		results = load_quakes(mmi_cutoff)
		EarthquakeData.new(results["features"][0])
	end

	def newest_unseen_quake mmi_cutoff
		most_recent = most_recent_quake mmi_cutoff

		unless @quake_history.contains? most_recent
			@quake_history.add_item most_recent
			@quake_history.save
			return most_recent
		else
			return nil
		end
			
	end

	

end
