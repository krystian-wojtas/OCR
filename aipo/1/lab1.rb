require 'FImg4RR_Simple'

#eclipse
orginal = Magick::ImageList.new("lena.jpg")
orginal = Magick::ImageList.new("lena256.jpg")
fImg4RR = FImg4RR.new( orginal )

#lab 01
#fImg4RR.negatyw.write('1/out/negatyw.jpg')
#fImg4RR.szaro1.write('1/out/szaro1.jpg')
#fImg4RR.szaro2.write('1/out/szaro2.jpg')
fImg4RR.histogram(true).write('1/out/histogram_osobne_kanaly.jpg')
fImg4RR.histogram(false).write('1/out/histogram_wspolna_norm.jpg')
#fImg4RR.skaluj(0.4).write('1/out/skaluj04.jpg')
#fImg4RR.skaluj(1.5).write('1/out/skaluj15.jpg')

#MyImgLib.new( Magick::ImageList.new('out/negatyw.jpg') ).drukuj
puts 'ok'
