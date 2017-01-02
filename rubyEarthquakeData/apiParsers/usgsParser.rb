require_relative './earthquakeAPIParser'

class USGSParser < EarthquakeAPIParser
	set_paths :id        => ["id"],
			  :date      => ["properties","time"],
			  :magnitude => ["properties","mag"],
			  :longitude => ["geometry","coordinates",0],
	 		  :latitude  => ["geometry","coordinates",1],
	 		  :depth     => ["geometry","coordinates",2],
	 		  :location  => ["properties","place"],
	 		  :mmi		 => ["properties","mmi"]

	def convert_time date_string
		Time.at(date_string.to_i / 1000).to_datetime
	end
end