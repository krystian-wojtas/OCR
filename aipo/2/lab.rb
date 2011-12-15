require 'FImg4RR_Filters'
require 'FImg4RR_Thresholding'

orginal = Magick::ImageList.new("lena.jpg")
orginal = Magick::ImageList.new("lena256.jpg")
fImg4RR = FImg4RR.new( orginal )

#fImg4RR.filtr( [[1,1,1], [1,1,1], [1,1,1]] ).write('2/out/fusr1.jpg')
#fImg4RR.filtr( [[1,1,1], [1,2,1], [1,1,1]] ).write('2/out/fusr2.jpg')
#fImg4RR.filtr( [[1,2,1], [2,4,2], [1,2,1]] ).write('2/out/fusr3.jpg')
#fImg4RR.filtr( [[0,-1,0], [-1,5,-1], [0,-1,0]] ).write('2/out/fwyostrz1.jpg')
#fImg4RR.filtr( [[-1,-1,-1], [-1,9,-1], [-1,-1,-1]] ).write('2/out/fwyostrz2.jpg')
#fImg4RR.filtr( [[1,-2,1], [-2,5,-2], [1,-2,1]] ).write('2/out/fwyostrz3.jpg')

#=begin
FImg4RR.new(orginal).szaro1.thresholding.write('2/out/prog.jpg')
FImg4RR.new(orginal).szaro1.thresholding_avl.write('2/out/prog1.jpg')
FImg4RR.new(orginal).szaro1.thresholding_avl(2).write('2/out/prog2.jpg')
FImg4RR.new(orginal).szaro1.thresholding_avl(4).write('2/out/prog4.jpg')
FImg4RR.new(orginal).szaro1.thresholding_avl(7).write('2/out/prog7.jpg')
FImg4RR.new(orginal).szaro1.thresholding_avl(16).write('2/out/prog16.jpg')
#=end

FImg4RR.new(orginal).szaro1.thresholding_avl_g(2, 0.1).write('2/out/prog2g01.jpg')
FImg4RR.new(orginal).szaro1.thresholding_avl_g(4, 0.1).write('2/out/prog4g01.jpg')
FImg4RR.new(orginal).szaro1.thresholding_avl_g(7, 0.1).write('2/out/prog7g01.jpg')
FImg4RR.new(orginal).szaro1.thresholding_avl_g(16, 0.1).write('2/out/prog16g01.jpg')

#fImg4RR.filtr( [[1,-2,1], [-2,5,-2], [1,-2,1]] ).write('2/out/fwyostrz3.jpg')

puts 'ok'