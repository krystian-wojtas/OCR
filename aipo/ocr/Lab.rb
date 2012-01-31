require 'ocr/OCR'
#require 'FImg4R_Simple'

class Lab
  
  def run(img_fn)
    

   #FImg4R.new(img_fn).zoom(0.4).write('ocr/out/zoom04.jpg')
   #lenka = FImg4R.new(img_fn)
   #FImg4R.new(100, 150).fragment(lenka, 80, 50).write('ocr/out/fragment.jpg')
=begin
        FImg4R.new(img_fn).zoom(0.4).write('ocr/out/zoom04.jpg')
        FImg4R.new(img_fn).stretch_vertical(1.5).write('ocr/out/stretch_v15.jpg')
        FImg4R.new(img_fn).stretch_vertical(0.4).write('ocr/out/stretch_v04.jpg')
        FImg4R.new(img_fn).stretch_horizontal(1.5).write('ocr/out/stretch_h15.jpg')
        FImg4R.new(img_fn).stretch_horizontal(0.4).write('ocr/out/stretch_h04.jpg')        
        FImg4R.new(img_fn).fit_size(:rows=>300).write('ocr/out/fit_rows_300.jpg')
        FImg4R.new(img_fn).fit_size(:columns=>500).write('ocr/out/fit_columns_300.jpg')
        FImg4R.new(img_fn).fit_size(:rows=>300,:columns=>500).write('ocr/out/fit_rows_300_columns_500.jpg')
=end
    require 'FImg4R_Ocr'
    #img = FImg4R.new('ocr/in/litwa.jpg')
    #img.projection_horizontal()
    #p img.prj_h
    #p ''
    #img.projection_vertical()
    #p img.prj_v
    
    #roman = FImg4R.new('ocr/fonts/TimesNewRoman.png')
    #roman.grayscale1().thresholding().kmm().write('ocr/out/font.bmp')
    #roman.projection_horizontal()
    
    ocr = OCR.new()
    #ocr.makeFont('ocr/in/litwa.png')
    ocr.makeFont('ocr/fonts/TimesNewRoman.png')
    #p ocr.readText('ocr/in/litwa.jpg')
  end
end
