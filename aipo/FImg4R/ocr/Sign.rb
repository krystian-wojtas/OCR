require 'FImg4R_Simple'
require 'FImg4R_Ocr'

class Sign
  
  attr_accessor :pattern, :space_after
  attr_reader :img
  attr_reader :prj_h, :prj_v
  
  
  def initialize(img)
    @img = img
  end
  
  
  def projection()
    projection_horizontal()
    projection_vertical()
  end
  
    
  def projection_horizontal()
    @img.projection_horizontal()
    @prj_h = @img.prj_h
  end
  
  
  def projection_vertical()
    @img.projection_vertical()
    @prj_v = @img.prj_v
  end
  
  
  def fit(size)
    @img.fit(size)
  end
  
  
  def rows()
    @img.rows()
  end
  

  def columns()
    @img.columns()
  end
  
  
  def setPattern(pattern)
    @pattern = pattern
  end
  
  
  def getPattern()
    @pattern
  end
  
  
  def similar(another)
    
  end

  
  def fragment(x1, x2, y1, y2)
    #p x1.to_s
    #p y1.to_s
    #p x2.to_s
    #p y2.to_s
    columns = (x2 - x1).abs()
    rows = (y2 - y1).abs()
    
    img_fr = FImg4R.new(rows, columns)
    Sign.new( img_fr.fragment(@img, x1, y1) )
  end


  
end