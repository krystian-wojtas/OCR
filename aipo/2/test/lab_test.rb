require 'FImg4RR_Filters'
require 'FImg4RR_Thresholding'

orginal = "lena256.jpg"


FImg4RR.new(orginal).zoom(0.4).write('2/test/out/zoom04.jpg')
FImg4RR.new(orginal).filter( [[1,1,1], [1,2,1], [1,1,1]] ).write('2/test/out/fusr2.jpg')
FImg4RR.new(orginal).filter( [[-1,-1,-1], [-1,9,-1], [-1,-1,-1]] ).write('2/test/out/fwyostrz2.jpg')
FImg4RR.new(orginal).grayscale1.thresholding_avl(4).write('2/test/out/prog4.jpg')
FImg4RR.new(orginal).grayscale1.thresholding_avl_g(4, 0.2).write('2/test/out/prog4g02.jpg')

puts 'ok'