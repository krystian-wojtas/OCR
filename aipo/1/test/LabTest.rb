require 'FImg4R_Simple'

class LabTest
  
  def run(img_fn)
    
    FImg4R.new(img_fn).negate.write('1/test/out/negate.bmp')
    FImg4R.new(img_fn).grayscale1.write('1/test/out/grayscale1.bmp')
    FImg4R.new(img_fn).grayscale2.write('1/test/out/grayscale2.bmp')
    FImg4R.new(img_fn).histogram.write('1/test/out/histogram.bmp')
    FImg4R.new(img_fn).grayscale1.histogram_grayscale.write('1/test/out/grayscale1_histogram.bmp')
    FImg4R.new(img_fn).grayscale2.histogram_grayscale.write('1/test/out/grayscale2_histogram.bmp')

  end
end
