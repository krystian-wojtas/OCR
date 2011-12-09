require 'FImg4RR_Simple'
#require 'FImg4RR_ZoomRotate'

orginal = Magick::ImageList.new("../lena.jpg")
orginal = Magick::ImageList.new("../lena256.jpg")
fImg4RR = FImg4RR.new( orginal )

#lab 01
fImg4RR.negatyw.write('out/negatyw.jpg')
#fImg4RR.szaro1.write('out/szaro1.jpg')
#fImg4RR.szaro2.write('out/szaro2.jpg')
#fImg4RR.histogram.write('out/histogram.jpg') #TODO zle kolory
#fImg4RR.skaluj(0.4).write('out/skaluj04.jpg') #TODO zoom nie dziala
#fImg4RR.skaluj(1.5).write('out/skaluj15.jpg')

#MyImgLib.new( Magick::ImageList.new('out/negatyw.jpg') ).drukuj
puts 'ok'
