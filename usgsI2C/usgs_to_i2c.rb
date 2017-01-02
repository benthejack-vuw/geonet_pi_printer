require_relative './USGSLocation'
require_relative '../rubyEarthquakeData/apiParsers/usgsParser'
require_relative '../rubyEarthquakeData/quakeWatcher'

location = USGSLocation.new -41.298734, 174.771194, 2000, 0

# watcher = QuakeWatcher.new
# watcher.watch(usgs_url, delay, USGSParser) do |quake|
#  	puts "#{quake.selective_print :time, :location, :magnitude, :mmi}\n"
# end