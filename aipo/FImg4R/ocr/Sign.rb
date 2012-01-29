require 'FImg4R_Simple'
require 'FImg4R_Ocr'

class Sign
  
  attr_accessor :letter, :space_after
  attr_reader :img
  attr_reader :prj_h, :prj_v
  
  
  def initialize(img)
    @img = img
  end
  
    
  def projection_horizontal()
    @img.projection_horizontal()
    @prj_h = @img.prj_h
  end
  
  
  def projection_vertical()
    @img.projection_vertical()
    @prj_v = @prj_v.prj_h    
  end
  
  
  def similar(another)
    
  end

  
  def fragment(x1, x2, y1, y2)
    columns = (x2 - x1).abs()
    rows = (y2 - y1).abs()
    
    img_fr = FImg4R.new(columns, rows)
    Sign.new( @img.fragment(img_fr, x1, y1) )
  end
  
  
  def rows()
    @img.rows()
  end
  

  def columns()
    @img.columns()
  end


  
end