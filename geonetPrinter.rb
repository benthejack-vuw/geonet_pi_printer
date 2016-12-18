require_relative './geonetRuby/geonetRuby'
require 'prawn'
require 'prawn-svg'

TIMEOUT = 30

NZ_BOUNDS = [{x: 166.4, y:-47.31}, {x:178.57, y:-34.36}]
PDF_SCALE = 5
PDF_SIZE = {x: 300*PDF_SCALE, y: 441*PDF_SCALE}
PDF_MARGIN = 80
PDF_PAGE_SIZE = [PDF_SIZE[:x]+PDF_MARGIN*2, PDF_SIZE[:y]+700+PDF_MARGIN*2]


def stretch(value, istart, istop, ostart, ostop) 
      return ostart + (ostop - ostart) * ((value - istart) / (istop - istart));
end


def create_quake_image(quake)

	puts quake.to_str	

	calculated_position = [
						   stretch(quake.coordinates[:x], NZ_BOUNDS[0][:x], NZ_BOUNDS[1][:x], 0, PDF_SIZE[:x]),
						   stretch(quake.coordinates[:y], NZ_BOUNDS[0][:y], NZ_BOUNDS[1][:y], 0, PDF_SIZE[:y])
						  ];

	Prawn::Document.generate("quake.pdf", :page_size => PDF_PAGE_SIZE, :PDF_MARGIN => [PDF_MARGIN,PDF_MARGIN,PDF_MARGIN,PDF_MARGIN]) do
				
		self.line_width = PDF_SCALE*4

		stroke_horizontal_rule

		self.line_width = PDF_SCALE
		
		font "Helvetica", :style => :bold
		font_size PDF_SCALE*15

		text "\n\n"
		text quake.to_str :time, :location, :magnitude

		bounding_box([0, PDF_SIZE[:y]], :width => PDF_SIZE[:x], :height => PDF_SIZE[:y]) do
			svg IO.read("./nz_map.svg"), position: :center

			((quake.magnitude.floor)*2).times  do |c|
				stroke_circle calculated_position, (c+1)*5*PDF_SCALE
			end

		end


	end
end






%x(echo "booting geonetPrinter at: #{Time.new.inspect}" >> /etc/geonetPrinter.log)
%x( lp -o fit-to-page -o position=bottom-right -o media=Custom.58x210mm  "./boot.pdf")


georuby = GeonetRuby.new("/etc/geonetPrinter.log")

1.upto(Float::INFINITY) do |n|

  sleep TIMEOUT # second

  quake = georuby.newest_unseen_quake(4)
  
  if quake
  	%x(echo "#{quake.to_str :time, :location, :magnitude, :mmi}\n" >> /etc/geonetPrinter.log)
  	create_quake_image(quake)
	%x( lp -o fit-to-page -o position=bottom-right -o media=Custom.58x210mm  "./quake.pdf")
  end

  
end
