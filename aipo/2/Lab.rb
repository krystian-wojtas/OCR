require "FImg4R_Filters"
require "FImg4R_Thresholding"

class Lab
  
  def run(img_fn, out_fn)
    
#=begin
    FImg4R.new(img_fn).zoom(0.4).write("2/out/#{out_fn}zoom04.jpg")
    FImg4R.new(img_fn).zoom(1.5).write("2/out/#{out_fn}zoom15.jpg")
    FImg4R.new(img_fn).zoom(4).write("2/out/#{out_fn}zoom40.jpg")
#=end
    
#=begin
    FImg4R.new(img_fn).filter( [[1,1,1], [1,1,1], [1,1,1]] ).write("2/out/#{out_fn}fusr1.jpg")
    FImg4R.new(img_fn).filter( [[1,1,1], [1,2,1], [1,1,1]] ).write("2/out/#{out_fn}fusr2.jpg")
    FImg4R.new(img_fn).filter( [[1,2,1], [2,4,2], [1,2,1]] ).write("2/out/#{out_fn}fusr3.jpg")
    FImg4R.new(img_fn).filter( [[0,-1,0], [-1,5,-1], [0,-1,0]] ).write("2/out/#{out_fn}fwyostrz1.jpg")
    FImg4R.new(img_fn).filter( [[-1,-1,-1], [-1,9,-1], [-1,-1,-1]] ).write("2/out/#{out_fn}fwyostrz2.jpg")
    FImg4R.new(img_fn).filter( [[1,-2,1], [-2,5,-2], [1,-2,1]] ).write("2/out/#{out_fn}fwyostrz3.jpg")
#=end
    
#=begin
    FImg4R.new(img_fn).grayscale1.thresholding.write("2/out/#{out_fn}prog.jpg")
    FImg4R.new(img_fn).grayscale1.thresholding_avl.write("2/out/#{out_fn}prog1.jpg")
    FImg4R.new(img_fn).grayscale1.thresholding_avl(2).write("2/out/#{out_fn}prog2.jpg")
    FImg4R.new(img_fn).grayscale1.thresholding_avl(4).write("2/out/#{out_fn}prog4.jpg")
    FImg4R.new(img_fn).grayscale1.thresholding_avl(7).write("2/out/#{out_fn}prog7.jpg")
    FImg4R.new(img_fn).grayscale1.thresholding_avl(16).write("2/out/#{out_fn}prog16.jpg")
#=end
    
#=begin
    FImg4R.new(img_fn).grayscale1.thresholding_avl_g(2, 0.1).write("2/out/#{out_fn}prog2g01.jpg")
    FImg4R.new(img_fn).grayscale1.thresholding_avl_g(4, 0.1).write("2/out/#{out_fn}prog4g01.jpg")
    FImg4R.new(img_fn).grayscale1.thresholding_avl_g(7, 0.1).write("2/out/#{out_fn}prog7g01.jpg")
    FImg4R.new(img_fn).grayscale1.thresholding_avl_g(16, 0.1).write("2/out/#{out_fn}prog16g01.jpg")
#=end
    
#=begin
    FImg4R.new(img_fn).grayscale1.thresholding_avl_g(4, 0.05).write("2/out/#{out_fn}prog4g005.jpg")
    FImg4R.new(img_fn).grayscale1.thresholding_avl_g(4, 0.2).write("2/out/#{out_fn}prog4g02.jpg")
    FImg4R.new(img_fn).grayscale1.thresholding_avl_g(4, 0.4).write("2/out/#{out_fn}prog4g04.jpg")
    FImg4R.new(img_fn).grayscale1.thresholding_avl_g(4, 0.85).write("2/out/#{out_fn}prog4g085.jpg")
    FImg4R.new(img_fn).grayscale1.thresholding_avl_g(16, 0.2).write("2/out/#{out_fn}prog16g02.jpg")
    FImg4R.new(img_fn).grayscale1.thresholding_avl_g(16, 0.4).write("2/out/#{out_fn}prog16g04.jpg")
    FImg4R.new(img_fn).grayscale1.thresholding_avl_g(16, 0.6).write("2/out/#{out_fn}prog16g06.jpg")
    FImg4R.new(img_fn).grayscale1.thresholding_avl_g(16, 0.85).write("2/out/#{out_fn}prog16g085.jpg")
#=end
    
    FImg4R.new(img_fn).grayscale1.thresholding_avl_g(16, 0.05).write("2/out/#{out_fn}prog16g005.jpg")
  end
end
