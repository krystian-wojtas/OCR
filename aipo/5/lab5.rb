require 'MyImgLib05'

#TODO metoda podmieniaja obrazek nad ktorym sie pracuje
#wtedy nie trzeba tworzyc tak wielu instancji biblioteki
MyImgLib.new( Magick::ImageList.new("p1.bmp") ).kmm2.write('out/kmm_p1_100.jpg')
MyImgLib.new( Magick::ImageList.new("p2.bmp") ).kmm2.write('out/kmm_p2_100.jpg')
MyImgLib.new( Magick::ImageList.new("p3.bmp") ).kmm2.write('out/kmm_p3_100.jpg')
MyImgLib.new( Magick::ImageList.new("p4.bmp") ).kmm2.write('out/kmm_p4_100.jpg')
MyImgLib.new( Magick::ImageList.new("o1.bmp") ).kmm2.write('out/kmm_o1_100.jpg')
MyImgLib.new( Magick::ImageList.new("o2.bmp") ).kmm2.write('out/kmm_o2_100.jpg')


puts 'ok'