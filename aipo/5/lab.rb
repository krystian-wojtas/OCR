require 'FImg4RR_KMM'

#TODO metoda podmieniaja obrazek nad ktorym sie pracuje
#wtedy nie trzeba tworzyc tak wielu instancji biblioteki

#FImg4RR.new( Magick::ImageList.new("in/p1.bmp") ).kmm2.write('out/kmm_p1_100.jpg')
#FImg4RR.new( Magick::ImageList.new("5/in/p2.bmp") ).kmm2.write('5/out/kmm_p2_100.jpg')
#FImg4RR.new( Magick::ImageList.new("in/p3.bmp") ).kmm2.write('out/kmm_p3_100.jpg')
#FImg4RR.new( Magick::ImageList.new("in/p4.bmp") ).kmm2.write('out/kmm_p4_100.jpg')
#FImg4RR.new( Magick::ImageList.new("in/o1.bmp") ).kmm2.write('out/kmm_o1_100.jpg')
#FImg4RR.new( Magick::ImageList.new("in/o2.bmp") ).kmm2.write('out/kmm_o2_100.jpg')


FImg4RR.new( Magick::ImageList.new("5/in/p1.bmp") ).scienianie.write('5/out/sc_p1_100.jpg')
FImg4RR.new( Magick::ImageList.new("5/in/p2.bmp") ).scienianie.write('5/out/sc_p2_100.jpg')
FImg4RR.new( Magick::ImageList.new("5/in/p3.bmp") ).scienianie.write('5/out/sc_p3_100.jpg')
FImg4RR.new( Magick::ImageList.new("5/in/p4.bmp") ).scienianie.write('5/out/sc_p4_100.jpg')
FImg4RR.new( Magick::ImageList.new("5/in/o1.bmp") ).scienianie.write('5/out/sc_o1_100.jpg')
FImg4RR.new( Magick::ImageList.new("5/in/o2.bmp") ).scienianie.write('5/out/sc_o2_100.jpg')


puts 'ok'
