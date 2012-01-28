require 'FImg4R_Ocr'
#require 'FImg4R_Simple'

class Lab
  
  def run(img_fn)
    
    
#=begin
        FImg4R.new(img_fn).zoom(0.4).write('ocr/out/zoom04.jpg')
        FImg4R.new(img_fn).stretch_vertical(1.5).write('ocr/out/stretch_v15.jpg')
        FImg4R.new(img_fn).stretch_vertical(0.4).write('ocr/out/stretch_v04.jpg')
        FImg4R.new(img_fn).stretch_horizontal(1.5).write('ocr/out/stretch_h15.jpg')
        FImg4R.new(img_fn).stretch_horizontal(0.4).write('ocr/out/stretch_h04.jpg')        
        FImg4R.new(img_fn).fit_size(:rows=>300).write('ocr/out/fit_rows_300.jpg')
        FImg4R.new(img_fn).fit_size(:columns=>500).write('ocr/out/fit_columns_300.jpg')
        FImg4R.new(img_fn).fit_size(:rows=>300,:columns=>500).write('ocr/out/fit_rows_300_columns_500.jpg')
#=end
    
    #FImg4R.new('ocr/in/litwa.jpg').readText('font').write('1/out/negate.jpg')
    #FImg4R.new('ocr/in/litwa.png').negate.write('ocr/out/tmp.jpg')
    font = FImg4R.new('ocr/fonts/TimesNewRoman.png').font()
    p FImg4R.new('ocr/in/litwa.jpg').readText1(font)
  end
end
