require 'FImg4R_Simple'
require 'FImg4R_Thresholding'
require 'FImg4R_KMM'

class FImg4R
  
  attr_reader :img_rw
  
  def separate(&choosen_separating_method)
    #prepare image
    grayscale1()
    thresholding()
    kmm()
    
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


  def font()
    sings = separate() do
      separating_method1()
    end
    
    #making alphabet
    @alphabet = Alphaber.new(sings)
    self
  end
  
  
  def readText1(alphabet_prj)
    sings_prj = separate() do
      separating_method1()
    end
    recognizeLetters(sings_prj, alphabet_prj)
  end
  
  
  def readText2(alphabet_prj)
    sings_prj = separate() do
      separating_method1()
    end
    recognizeLetters(sings_prj, alphabet_prj)
  end
  
  
  def readText3(alphabet_prj)
    sings_prj = separate() do
      separating_method1()
    end
    recognizeLetters(sings_prj, alphabet_prj)
  end
  
end