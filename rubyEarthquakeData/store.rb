require 'yaml'

class Store

	def initialize path
		@file_url = path
		@quake_history = File.exist?(@file_url) ? YAML::load(File.read(@file_url)) : {}
	end

	def add_item item
		@quake_history[item.id] = item
	end

	def contains? item
		@quake_history.key?(item.id)
	end

	def save
		File.open(@file_url, "w") do |f|
			f.write(@quake_history.to_yaml)
		end
	end

end