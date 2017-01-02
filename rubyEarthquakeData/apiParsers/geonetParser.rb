require_relative './earthquakeAPIParser'

class GeonetParser < EarthquakeAPIParser
  set_paths :id        => ["properties", "publicID"],
            :date      => ["properties","time"],
            :magnitude => ["properties","magnitude"],
            :latitude  => ["geometry","coordinates",0],
            :longitude => ["geometry","coordinates",1],
            :depth     => ["properties","depth"],
            :location  => ["properties","locality"],
            :mmi       => ["properties","mmi"],
            :quality   => ["properties","quality"]

  def convert_time date_string
    utc_time = Time.parse(date_string).localtime
  end
end