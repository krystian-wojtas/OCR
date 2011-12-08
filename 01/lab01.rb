require 'MyImgLib01'

orginal = Magick::ImageList.new("../MyImgLib/lena.jpg")
orginal = Magick::ImageList.new("../MyImgLib/lena256.jpg")
myImgLib = MyImgLib.new( orginal )

#lab 01
myImgLib.negatyw.write('out/negatyw.jpg')
#myImgLib.szaro1.write('out/szaro1.jpg')
#myImgLib.szaro2.write('out/szaro2.jpg')
#myImgLib.histogram.write('out/histogram.jpg') #TODO zle kolory
#myImgLib.skaluj(0.4).write('out/skaluj04.jpg') #TODO zoom nie dziala
#myImgLib.skaluj(1.5).write('out/skaluj15.jpg')

#MyImgLib.new( Magick::ImageList.new('out/negatyw.jpg') ).drukuj
puts 'ok'