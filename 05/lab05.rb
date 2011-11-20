require 'MyImgLib03'

orginal = Magick::ImageList.new("../MyImgLib/lena.jpg")
#orginal = Magick::ImageList.new("../MyImgLib/lena256.jpg")
myImgLib = MyImgLib.new( orginal )

puts 'ok'