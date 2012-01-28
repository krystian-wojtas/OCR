require 'FImg4R_Simple'
require 'FImg4R_Thresholding'

class OCR
  
  def initialize()
    @img = nil
  end
  
  def setImg(img)
    @img = img
  end
  
  def getImg()
    @img
  end

  #read file to image object
  def readfile(filename)
    @img = FImg4R.new(filename)
  end
  
  def getText()
    #prepare image
    img.grayscale1().thresholding()
    #do ocr and return text
    OCR_Core.new(@img).readText() #TODO new(@img, @font)
  end
end