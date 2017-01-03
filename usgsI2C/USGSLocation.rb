require 'i2c'
require_relative '../rubyEarthquakeData/quakeWatcher'
require_relative '../rubyEarthquakeData/apiParsers/usgsParser'

class USGSLocation
	
	USGS_URL = "http://earthquake.usgs.gov/fdsnws/event/1/query"
	SEND =
		Proc.new do |address, data|
			i2c = I2C::create("/dev/i2c-1")
			i2c.write(address, data.to_s)		
		end

	def initialize latitude, longitude, radius, i2cAddress
		url = "#{USGS_URL}?format=geojson&latitude=#{latitude}&longitude=#{longitude}&maxradiuskm=#{radius}"
		watcher = QuakeWatcher.new i2cAddress, false
		watcher.watch(url, 60, USGSParser) do |quake|
		 	puts "#{quake.selective_print :time, :location, :magnitude, :mmi}\n"
		 	SEND.call(i2cAddress, quake.magnitude)
		end
	end

end
