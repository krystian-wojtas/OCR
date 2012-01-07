require 'FImg4R_Simple'
require 'FImg4R_Rotate'
require 'FImg4R_SobelRoberts'

class Lab
  
  def run(img_fn)
    #FImg4R.brightness(0.1*Magick::QuantumRange).write('3/out/brightness_01q.jpg')
    #FImg4R.contrast(0.9).write('3/out/contrast_09.jpg')
#=begin
    FImg4R.new(img_fn).brightness(0.1).write('3/out/brightness_01q.jpg')
    FImg4R.new(img_fn).brightness(0.3).write('3/out/brightness_03q.jpg')
    FImg4R.new(img_fn).brightness(0.6).write('3/out/brightness_06q.jpg')
    FImg4R.new(img_fn).brightness(-0.1).write('3/out/brightness_m01q.jpg')
    FImg4R.new(img_fn).brightness(-0.3).write('3/out/brightness_m03q.jpg')
    FImg4R.new(img_fn).brightness(-0.6).write('3/out/brightness_m06q.jpg')
    FImg4R.new(img_fn).contrast(0.9).write('3/out/contrast_09.jpg')
    FImg4R.new(img_fn).contrast(0.7).write('3/out/contrast_07.jpg')
    FImg4R.new(img_fn).contrast(0.3).write('3/out/contrast_03.jpg')
    FImg4R.new(img_fn).contrast(1.1).write('3/out/contrast_11.jpg')
    FImg4R.new(img_fn).contrast(1.5).write('3/out/contrast_15.jpg')
    FImg4R.new(img_fn).contrast(2.1).write('3/out/contrast_21.jpg')
#=end
    FImg4R.new(img_fn).roberts_cross.write('3/out/roberts_cross.jpg')
    FImg4R.new(img_fn).sobel.write('3/out/sobel.jpg')
    FImg4R.new(img_fn).rotate(0.25*Math::PI).write('3/out/rotate_025.jpg')
    FImg4R.new(img_fn).rotate(0.1*Math::PI).write('3/out/rotate_01.jpg')
    FImg4R.new(img_fn).rotate(0.5*Math::PI).write('3/out/rotate_05.jpg')
    FImg4R.new(img_fn).rotate(0.8*Math::PI).write('3/out/rotate_08.jpg')
    FImg4R.new(img_fn).rotate(-0.3*Math::PI).write('3/out/rotate_m03.jpg')
    FImg4R.new(img_fn).rotate(Math::PI).write('3/out/rotate_1.jpg')
  end
end
