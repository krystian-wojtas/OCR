require 'FImg4R_Simple'

class Lab
  
  def run(img_fn)
    #FImg4R.new(img_fn).negate.write('1/out/negate.jpg')
#=begin
    FImg4R.new(img_fn).negate.write('1/out/negate.jpg')
    FImg4R.new(img_fn).grayscale1.write('1/out/grayscale1.jpg')
    FImg4R.new(img_fn).grayscale2.write('1/out/grayscale2.jpg')
    FImg4R.new(img_fn).histogram.write('1/out/histogram.jpg')
    FImg4R.new(img_fn).grayscale1.histogram.write('1/out/grayscale1_histogram.jpg')
    FImg4R.new(img_fn).grayscale2.histogram.write('1/out/grayscale2_histogram.jpg')
#=end
  end
end
