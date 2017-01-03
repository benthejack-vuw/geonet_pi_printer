require_relative './USGSLocation'
require_relative '../rubyEarthquakeData/apiParsers/usgsParser'
require_relative '../rubyEarthquakeData/quakeWatcher'

location = USGSLocation.new 70.282923, -151.051501, 2700, 4 #Alaska
location = USGSLocation.new 27.160134, -110.709636, 2700, 5 #North Ameria
location = USGSLocation.new -30.540227, -85.331683, 2700, 6 #South America
location = USGSLocation.new -36.166113, 163.986717, 2700, 7 #New Zealand
location = USGSLocation.new 29.627615,  140.964077, 2700, 8 #Japan 
QuakeWatcher.wait
