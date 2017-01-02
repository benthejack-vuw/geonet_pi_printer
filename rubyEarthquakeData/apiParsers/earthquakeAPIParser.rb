class EarthquakeAPIParser
  include Comparable

  attr_accessor :date_time

  @@required_paths = ["id", "date", "magnitude", "latitude", "longitude"]

  def initialize
  end

  def <=>(another)
    @date_time <=> another.date_time
  end

  def update json_data
    @data = json_data
  	validate_data
    @date_time = convert_time(date)
  end

  #override this if necessary
  def convert_time(date_string)
    DateTime.parse(date_string)
  end

  #will raise an exception if the data is incorrectly formatted
  def validate_data
  		@@data_accessor_methods.each {|method| send method}
  end

  #The following method is horrible, need to find tidier ruby way to do this
  def self.set_paths args
  	@@data_accessor_methods = args.keys
	  args.each do |key, path_to_data|
	  	define_method(key) do
	  		obj = @data
	  		path_to_data.each do |location|
  				 raise "either the data is invalid or the incorrect path
                  to '#{key}' has been given : #{@data}" unless obj
           obj = obj[location];
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

  def time
	   @date_time.strftime("%d/%m/%Y at %H:%M")
  end

  def selective_print *args
    output = ""
		args.each do |param|
	  		output << "#{param}: #{self.send param}\n" if self.respond_to? param
		end
	output
  end

end