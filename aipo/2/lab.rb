require 'FImg4RR_Filters'

orginal = Magick::ImageList.new("lena.jpg")
#orginal = Magick::ImageList.new("lena256.jpg")
fImg4RR = FImg4RR.new( orginal )

#fImg4RR.filtr( [[1,1,1], [1,1,1], [1,1,1]] ).write('2/out/fusr1.jpg')
#fImg4RR.filtr( [[1,1,1], [1,2,1], [1,1,1]] ).write('2/out/fusr2.jpg')
#fImg4RR.filtr( [[1,2,1], [2,4,2], [1,2,1]] ).write('2/out/fusr3.jpg')
#fImg4RR.filtr( [[0,-1,0], [-1,5,-1], [0,-1,0]] ).write('2/out/fwyostrz1.jpg')
fImg4RR.filtr( [[-1,-1,-1], [-1,9,-1], [-1,-1,-1]] ).write('2/out/fwyostrz2.jpg')
#fImg4RR.filtr( [[1,-2,1], [-2,5,-2], [1,-2,1]] ).write('2/out/fwyostrz3.jpg')