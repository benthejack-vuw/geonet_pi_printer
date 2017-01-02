require_relative '../rubyEarthquakeData/quakeWatcher'
require_relative '../rubyEarthquakeData/apiParsers/usgsParser'

class USGSLocation

	USGS_URL = "http://earthquake.usgs.gov/fdsnws/event/1/query"
	SEND =
		Proc.new do |address, data|

		end

	def initialize latitude, longitude, radius, i2cAddress
		url = "#{USGS_URL}?format=geojson&latitude=#{latitude}&longitude=#{longitude}&maxradiuskm=#{radius}"
		watcher = QuakeWatcher.new
		watcher.watch(url, 10, USGSParser) do |quake|
		 	puts "#{quake.selective_print :time, :location, :magnitude, :mmi}\n"
		 	SEND.call(i2cAddress, quake.magnitude)
		end
	end

end