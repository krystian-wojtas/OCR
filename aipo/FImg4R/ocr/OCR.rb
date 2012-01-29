#FImg4R
require 'FImg4R_Simple'
require 'FImg4R_Thresholding'
require 'FImg4R_KMM'
#ocr
require 'ocr/Separate'

class OCR
  
  @img = nil
  @alphabet = nil
  
  def initialize()
    
  end
  

  def separate(&choosen_separating_method)
    #prepare image
    @img.grayscale1()
    @img.thresholding()
    @img.kmm()
    
    #signs_separating = [
    # {
    #   img => FImg4R
    #   space_after =>
    #   prj_v => nil
    #   prj_h => nil
    # },
    # ...
    #]
    #separate signs from image
    sings = choosen_separating_method.call()
    
    #returns separated signs
    signs
  end


  def makeFont(path)
    @img = FImg4R.new(path)
    sings = separate() do
      Separate.new(@img).method1()      
    end
    
    #making alphabet
    @alphabet = Alphabet.new(sings)
    self
  end
  
  
  def readText1(path)
    @img = FImg4R.new(path)
    sings_prj = separate() do #TODO not prj yet
      Separate.new(@img).method1() 
    end
    recognizeLetters(sings_prj, @alphabet.get())
  end
  
  
  def readText2(path)
    @img = FImg4R.new(path)
    sings_prj = separate() do
      Separate.new(@img).method2() 
    end
    recognizeLetters(sings_prj, @alphabet.get())
  end
  
  
  def readText3(path)
    @img = FImg4R.new(path)
    sings_prj = separate() do
      Separate.new(@img).method3() 
    end
    recognizeLetters(sings_prj, @alphabet.get())
  end
  
end