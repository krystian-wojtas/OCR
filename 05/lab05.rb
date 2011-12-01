require 'MyImgLib05'

#orginal = Magick::ImageList.new("../MyImgLib/lena.jpg")
#orginal = Magick::ImageList.new("../MyImgLib/lena256.jpg")
#myImgLib.ramka(5).write('out/ramka.bmp')

#MyImgLib.new( Magick::ImageList.new("p1.bmp") ).kmm.write('out/kmm_p1_100.jpg')
#MyImgLib.new( Magick::ImageList.new("p2.bmp") ).kmm.write('out/kmm_p2_100.jpg')
#MyImgLib.new( Magick::ImageList.new("p3.bmp") ).kmm.write('out/kmm_p3_100.jpg')
#MyImgLib.new( Magick::ImageList.new("p4.bmp") ).kmm.write('out/kmm_p4_100.jpg')
#MyImgLib.new( Magick::ImageList.new("o1.bmp") ).kmm.write('out/kmm_o1_100.jpg')
#MyImgLib.new( Magick::ImageList.new("o2.bmp") ).kmm.write('out/kmm_o2_100.jpg')

orginal = Magick::ImageList.new("../MyImgLib/lena256.jpg")
myImgLib = MyImgLib.new( orginal )

#lab 03
myImgLib.jasnosc2(0.1*Magick::QuantumRange).write('out/jasnosc01q.jpg')

puts 'ok'
