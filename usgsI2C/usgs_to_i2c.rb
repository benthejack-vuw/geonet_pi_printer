require_relative './USGSLocation'
require_relative '../rubyEarthquakeData/apiParsers/usgsParser'
require_relative '../rubyEarthquakeData/quakeWatcher'

location = USGSLocation.new -41.298734, 174.771194, 2000, 4
location = USGSLocation.new 35.0, 136.0, 3000, 5

