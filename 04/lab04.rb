require 'MyImgLib04'

orginal = Magick::ImageList.new("../MyImgLib/lena.jpg")
#orginal = Magick::ImageList.new("../MyImgLib/lena256.jpg")
myImgLib = MyImgLib.new( orginal )


#myImgLib.negate.write('jasnosc01q.jpg')

myImgLib.solPieprz(85).write('solpieprz85.jpg')
puts 'ok'