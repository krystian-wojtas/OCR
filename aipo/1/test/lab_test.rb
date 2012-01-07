require 'FImg4RR_Simple'

orginal = "lena256.jpg"

FImg4RR.new(orginal).negate.write('1/test/out/negate.bmp')
FImg4RR.new(orginal).grayscale1.write('1/test/out/grayscale1.bmp')
FImg4RR.new(orginal).grayscale2.write('1/test/out/grayscale2.bmp')
FImg4RR.new(orginal).histogram.write('1/test/out/histogram.bmp')
FImg4RR.new(orginal).grayscale1.histogram.write('1/test/out/grayscale1_histogram.bmp')
FImg4RR.new(orginal).grayscale2.histogram.write('1/test/out/grayscale2_histogram.bmp')

puts 'ok'
