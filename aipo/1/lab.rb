require 'FImg4RR_Simple'

#eclipse
orginal = Magick::ImageList.new("lena.jpg")
orginal = Magick::ImageList.new("lena256.jpg")

#lab 01
#FImg4RR.new(orginal).negatyw.write('1/out/negatyw.jpg')
#FImg4RR.new(orginal).szaro1.write('1/out/szaro1.jpg')
#FImg4RR.new(orginal).szaro2.write('1/out/szaro2.jpg')
#FImg4RR.new(orginal).histogram.write('1/out/histogram.jpg')
#FImg4RR.new(orginal).histogram(false).write('1/out/histogram_wspolna_norm.jpg')
FImg4RR.new(orginal).szaro1.histogram.write('1/out/szaro1_histogram.jpg')
FImg4RR.new(orginal).szaro2.histogram.write('1/out/szaro2_histogram.jpg')
#FImg4RR.new(orginal).skaluj(0.4).write('1/out/skaluj04.jpg')
#FImg4RR.new(orginal).skaluj(1.5).write('1/out/skaluj15.jpg')

puts 'ok'
