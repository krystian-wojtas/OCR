require 'MyImgLib05'

orginal = Magick::ImageList.new("../MyImgLib/lena.jpg")
orginal = Magick::ImageList.new("../MyImgLib/lena256.jpg")
myImgLib = MyImgLib.new( orginal )

myImgLib.ramka(1).write('out/ramka.bmp')
#myImgLib.kmm.write('out/kmm.jpg')

puts 'ok'