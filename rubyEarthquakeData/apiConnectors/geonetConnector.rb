require_relative './earthquakeAPIConnector'

class GeonetConnector < EarthquakeAPIConnector
	set_paths :id        => "properties.publicID",
			  :time      => "properties.time",
			  :magnitude => "properties.magnitude",
	 		  :latitude  => "geometry.coordinates.0",
	 		  :longitude => "geometry.coordinates.1",
	 		  :depth     => "properties.depth",
	 		  :location  => "properties.locality",
	 		  :mmi		 => "properties.mmi",
	 		  :quality   => "properties.quality"
end