require 'FImg4R_Filters'
require 'FImg4R_Thresholding'

class LabTest
  
  def run(img_fn)
    
    FImg4RR.new(img_fn).zoom(0.4).write('2/test/out/zoom04.jpg')
    FImg4RR.new(img_fn).filter( [[1,1,1], [1,2,1], [1,1,1]] ).write('2/test/out/fusr2.jpg')
    FImg4RR.new(img_fn).filter( [[-1,-1,-1], [-1,9,-1], [-1,-1,-1]] ).write('2/test/out/fwyostrz2.jpg')
    FImg4RR.new(img_fn).grayscale1.thresholding_avl(4).write('2/test/out/prog4.jpg')
    FImg4RR.new(img_fn).grayscale1.thresholding_avl_g(4, 0.2).write('2/test/out/prog4g02.jpg')

  end
end