require 'MyImgLib03'

orginal = Magick::ImageList.new("../MyImgLib/lena.jpg")
#orginal = Magick::ImageList.new("../MyImgLib/lena256.jpg")
myImgLib = MyImgLib.new( orginal )

#lab 03
=begin
myImgLib.jasnosc(0.1*Magick::QuantumRange).write('out/jasnosc01q.jpg')
myImgLib.jasnosc(0.3*Magick::QuantumRange).write('out/jasnosc03q.jpg')
myImgLib.jasnosc(0.6*Magick::QuantumRange).write('out/jasnosc06q.jpg')
myImgLib.jasnosc(-0.1*Magick::QuantumRange).write('out/jasnoscm01q.jpg')
myImgLib.jasnosc(-0.3*Magick::QuantumRange).write('out/jasnoscm03q.jpg')
myImgLib.jasnosc(-0.6*Magick::QuantumRange).write('out/jasnoscm06q.jpg')
myImgLib.kontrast(0.9).write('out/kontrast09.jpg')
myImgLib.kontrast(0.7).write('out/kontrast07.jpg')
myImgLib.kontrast(0.3).write('out/kontrast03.jpg')
myImgLib.kontrast(1.1).write('out/kontrast11.jpg')
myImgLib.kontrast(1.5).write('out/kontrast15.jpg')
myImgLib.kontrast(2.1).write('out/kontrast21.jpg')
myImgLib.krzyzRobertsa.write('out/krzyz.jpg')
myImgLib.sobel.write('out/sobel.jpg')
=end
myImgLib.obrot(0.25*Math::PI).write('out/obrot025.jpg')
myImgLib.obrot(0.1*Math::PI).write('out/obrot01.jpg')
myImgLib.obrot(0.5*Math::PI).write('out/obrot05.jpg')
myImgLib.obrot(0.8*Math::PI).write('out/obrot08.jpg')
myImgLib.obrot(-0.3*Math::PI).write('out/obrotm03.jpg')
myImgLib.obrot(Math::PI).write('out/obrot1.jpg')

puts 'ok'