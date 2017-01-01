class EarthquakeAPIConnector

  @@required_paths = ["id", "time", "magnitude", "latitude", "longitude"]

  def initialize
  end

  def update json_data
  	data_valid? json_data
  	@data = json_data
  end

  def data_valid? data
  		@@data_accessor_methods.each {|method| send method}
  end

  #The following method is horrible, need to find tidier ruby way to do this
  def self.set_paths args
  	@@data_accessor_methods = args.keys
	  args.each do |key, path_to_data|
	  	define_method(key) do
	  		obj = @data
	  		path_to_data.split('.').each do |location|
	  			if /\A[-+]?\d+\z/ === location #is the location an integer? (in an array)
	  				obj = obj[location.to_i]
	  			elsif obj.has_key? location.to_sym #does the object contain this particular path?
	  				obj = obj[location.to_sym];
	  			else
	  				raise "either the data is invalid or the incorrect path to '#{key}' has been given"
	  			end
	  		end
	  		return obj
	  	end

	  end

	  #bungy little baked in test, how to do this nicely?
	  testObject = Object.const_get(to_s).new
	  testObject.test_compulsory_paths 
  end

  def test_compulsory_paths
  	@@required_paths.each{ |p| assert_path p}
  end

  def assert_path name
  	unless respond_to? name
  		raise "#{self.class.to_s} must implement #{name} (use set_paths class method to do this)" 
  	end
  end

	def time_s
		@time.strftime("%d/%m/%Y at %H:%M")
	end

  def selective_print *args
    output = ""
		args.each do |param|
	  	output << "#{param}: #{self.send param}\n" if self.respond_to? param
		end
		output
  end

end