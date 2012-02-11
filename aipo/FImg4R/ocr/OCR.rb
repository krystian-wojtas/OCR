#FImg4R
require 'FImg4R_Simple'
require 'FImg4R_Thresholding'
require 'FImg4R_KMM'
#ocr
require 'ocr/Separate'
require 'ocr/Alphabet'
require 'ocr/Recognition'


class OCR
  
  @alphabet = nil
  @separation = nil
  @recognition = nil
  
  def initialize()
    @alphabet = Alphabet.new()
    @separation = Separate.new() #TODO Separation.new
    @recognition = Recognition.new()
  end
  

  def separate(path, &choosen_separating_method)
    img = FImg4R.new(path)
    #prepare image
    img.grayscale1()
    img.thresholding()
    img.kmm() #TODO default white pixels as a background
    
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
    @separation.setSign(img)
    signs = choosen_separating_method.call()
    
    #returns separated signs
    signs
  end


  def makeFont(pattern_signs_dirname, pattern_signs_img_path, pattern_signs_order_path=nil)
    #separate signs
    signs = separate(pattern_signs_img_path) do
      @separation.method1()
    end
    
    @alphabet.setSigns(signs)
    #finding max size of columns and rows
    @alphabet.max_size()

    #resizing each img of sign to finded max size
    signs.each do |sign|
    #  sign.fit( :rows => @alphabet.max_rows, :columns => @alphabet.max_columns )
    end
    
    #making projection of each sign
    signs.each do |sign|
      sign.projection()
    end
    
    #making patterns from list of separated signs
    #file pattern_signs_order_path should consist words or letters in order coresponding to order of list of signs
    @alphabet.tie_signs_with_patterns( pattern_signs_order_path )
    
    #writing each separated sign to image file. Name of file is connected with word or letter which image is reprezenting
    @alphabet.save(pattern_signs_dirname)
    
    self
  end
  
  
  def readFont(pattern_signs_dirname)
    @alphabet.read(pattern_signs_dirname)
    self
  end
  
  
  
  def readText(path, &choosen_separating_method)
    #separate signs
    signs = separate(path, &choosen_separating_method)

    #resizing each img of sign to max size of alphabet
    signs.each do |sign|
      sign.fit( :rows => @alphabet.max_rows, :columns => @alphabet.max_columns )
    end
    
    #making projection of each sign
    signs.each do |sign|
      sign.projection()
    end
    
    #recognize letters or words from image basic on created alphabet
    recognition.recognize(signs, @alphabet.get())
      
    self
  end
  
  
  def readText1(path)
    readText(path) do
      @separation.method1() 
    end
  end
  
  
  def readText2(path)
    readText(path) do
      @separation.method2() 
    end
  end
  
  
  def readText3(path)
    readText(path) do
      @separation.method3() 
    end
  end
  
end