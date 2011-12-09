require 'RMagick'

orginal = Magick::ImageList.new("lena256.jpg") #TODO argument

orginal.each_pixel do |pixel, c, r|
  px = orginal.pixel_color(c, r)
  puts r.to_s + ' ' + c.to_s + ' ' + px.red.to_s
  puts r.to_s + ' ' + c.to_s + ' ' + px.green.to_s
  puts r.to_s + ' ' + c.to_s + ' ' + px.blue.to_s
end