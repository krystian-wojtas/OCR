require 'FImg4RR_Simple'
require 'FImg4RR_Rotate'
require 'FImg4RR_SobelRoberts'

orginal = Magick::ImageList.new("lena.jpg")
orginal = Magick::ImageList.new("lena256.jpg")
fImg4RR = FImg4RR.new( orginal )

#lab 03
#fImg4RR.jasnosc(0.1*Magick::QuantumRange).write('3/out/jasnosc01q.jpg')
#fImg4RR.kontrast(0.9).write('3/out/kontrast09.jpg')
=begin
fImg4RR.jasnosc(0.1*Magick::QuantumRange).write('3/out/jasnosc01q.jpg')
fImg4RR.jasnosc(0.3*Magick::QuantumRange).write('3/out/jasnosc03q.jpg')
fImg4RR.jasnosc(0.6*Magick::QuantumRange).write('3/out/jasnosc06q.jpg')
fImg4RR.jasnosc(-0.1*Magick::QuantumRange).write('3/out/jasnoscm01q.jpg')
fImg4RR.jasnosc(-0.3*Magick::QuantumRange).write('3/out/jasnoscm03q.jpg')
fImg4RR.jasnosc(-0.6*Magick::QuantumRange).write('3/out/jasnoscm06q.jpg')
fImg4RR.kontrast(0.9).write('3/out/kontrast09.jpg')
fImg4RR.kontrast(0.7).write('3/out/kontrast07.jpg')
fImg4RR.kontrast(0.3).write('3/out/kontrast03.jpg')
fImg4RR.kontrast(1.1).write('3/out/kontrast11.jpg')
fImg4RR.kontrast(1.5).write('3/out/kontrast15.jpg')
fImg4RR.kontrast(2.1).write('3/out/kontrast21.jpg')
=end
#fImg4RR.krzyzRobertsa.write('3/out/krzyz.jpg')
#fImg4RR.sobel.write('3/out/sobel.jpg')
fImg4RR.obrot(0.25*Math::PI).write('3/out/obrot025.jpg')
#fImg4RR.obrot(0.1*Math::PI).write('3/out/obrot01.jpg')
#fImg4RR.obrot(0.5*Math::PI).write('3/out/obrot05.jpg')
#fImg4RR.obrot(0.8*Math::PI).write('3/out/obrot08.jpg')
#fImg4RR.obrot(-0.3*Math::PI).write('3/out/obrotm03.jpg')
#fImg4RR.obrot(Math::PI).write('3/out/obrot1.jpg')

puts 'ok'