class EarthquakeData
	
	attr_accessor :coordinates, :public_id, :time, :depth, :magnitude, :location, :mmi, :quality
	
	def initialize data
		@coordinates = {x: data["geometry"]["coordinates"][0], y: data["geometry"]["coordinates"][1]}
		@public_id = data["properties"]["publicID"]
		@time = DateTime.parse(data["properties"]["time"])
		@depth = data["properties"]["depth"]
		@magnitude = data["properties"]["magnitude"]
		@location = data["properties"]["locality"]
		@mmi = data["properties"]["mmi"]
		@quality = data["properties"]["quality"]
	end

	def time
		@time.strftime("%d/%m/%Y at %H:%M")
	end

	def to_str *args
		output = ""
		args.each do |param|
			output << "#{param}: #{self.send param}\n" if self.respond_to? param
		end

		output
	end

end