require 'FImg4RR_Noise'

orginal = Magick::ImageList.new("lena.jpg")
orginal = Magick::ImageList.new("lena256.jpg")

=begin
FImg4RR.new(orginal).salt_pepper(0.05).write('4/out/saltpepper005.bmp')
FImg4RR.new(orginal).salt_pepper(0.1).write('4/out/saltpepper01.bmp')
FImg4RR.new(orginal).salt_pepper(0.15).write('4/out/saltpepper015.bmp')
=end

=begin
FImg4RR.new(orginal).regular_noise(0.05).write('4/out/regular_noise005.bmp')
FImg4RR.new(orginal).regular_noise(0.1).write('4/out/regular_noise01.bmp')
FImg4RR.new(orginal).regular_noise(0.15).write('4/out/regular_noise015.bmp')
FImg4RR.new(orginal).regular_noise(0.35).write('4/out/regular_noise035.bmp')
=end

=begin
FImg4RR.new(orginal).regular_noise(0.05, false).write('4/out/regular_noise_ch005.bmp')
FImg4RR.new(orginal).regular_noise(0.1, false).write('4/out/regular_noise_ch01.bmp')
FImg4RR.new(orginal).regular_noise(0.15, false).write('4/out/regular_noise_ch015.bmp')
FImg4RR.new(orginal).regular_noise(0.35, false).write('4/out/regular_noise_ch035.bmp')
=end

#FImg4RR.new(Magick::ImageList.new("4/out/regular_noise_ch035.bmp")).median_filter(3).write('4/out/regular_noise_ch035__median_filter3.bmp')
#FImg4RR.new(Magick::ImageList.new("4/out/regular_noise_ch01.bmp")).median_filter(3).write('4/out/regular_noise_ch01__median_filter3.bmp')
#FImg4RR.new(Magick::ImageList.new("4/out/regular_noise_ch01.bmp")).median_filter(5).write('4/out/regular_noise_ch01__median_filter5.bmp')

#FImg4RR.new(Magick::ImageList.new("4/out/regular_noise_ch035.bmp")).median_filter_limited(3).write('4/out/regular_noise_ch035__median_filter3_limited.bmp')
FImg4RR.new(Magick::ImageList.new("4/out/regular_noise_ch01.bmp")).median_filter_limited(3).write('4/out/regular_noise_ch01__median_filter3_limited.bmp')
FImg4RR.new(Magick::ImageList.new("4/out/regular_noise_ch01.bmp")).median_filter_limited(5).write('4/out/regular_noise_ch01__median_filter5_limited.bmp')

#FImg4RR.new(Magick::ImageList.new("4/out/regular_noise_ch035.bmp")).average_filter(3).write('4/out/regular_noise_ch035__average_filter3.bmp')


puts 'ok'