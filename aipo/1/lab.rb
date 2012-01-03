require 'FImg4RR_Simple'

#eclipse
orginal = Magick::ImageList.new("lena.jpg")
#orginal = Magick::ImageList.new("lena256.jpg")

FImg4RR.new(orginal).negate.write('1/out/negate.jpg')
#=begin
FImg4RR.new(orginal).grayscale1.write('1/out/grayscale1.jpg')
FImg4RR.new(orginal).grayscale2.write('1/out/grayscale2.jpg')
FImg4RR.new(orginal).histogram.write('1/out/histogram.jpg')
FImg4RR.new(orginal).grayscale1.histogram.write('1/out/grayscale1_histogram.jpg')
FImg4RR.new(orginal).grayscale2.histogram.write('1/out/grayscale2_histogram.jpg')
#=end

puts 'ok'
