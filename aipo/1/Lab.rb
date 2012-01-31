require "FImg4R_Simple"

class Lab
  
  def run(img_fn, out_fn)
#=begin
    FImg4R.new(img_fn).negate.write("1/out/#{out_fn}negate.jpg")
    FImg4R.new(img_fn).grayscale1.write("1/out/#{out_fn}grayscale1.jpg")
    FImg4R.new(img_fn).grayscale2.write("1/out/#{out_fn}grayscale2.jpg")
    FImg4R.new(img_fn).histogram.write("1/out/#{out_fn}histogram.jpg")
    FImg4R.new(img_fn).grayscale1.histogram.write("1/out/#{out_fn}grayscale1_histogram.jpg")
    FImg4R.new(img_fn).grayscale2.histogram.write("1/out/#{out_fn}grayscale2_histogram.jpg")
#=end
  end
end
