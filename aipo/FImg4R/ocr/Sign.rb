class Sign
  
  attr_accessor :letter, :space_after
  attr_reader :img
  
  @img = nil
  @prj_v, @prj_h = nil, nil
  
  
  def initialize(img)
    @img = img
  end
  
    
  def projection_horizontal()
    @prj_v = Array.new(@s.o[:rows], 0)
    iteruj :channels => :monocolor do |r, c|
      if @vchb[r][c] > @img_rw.qr()/2
        @proj[r] = @proj[r]+1
      end
    end
  end
  
  
  def projection_vertical()
    
  end
  
  
  def similar(another)
    
  end

  
  def fragment(x1, x2, y1, y2)
    Sign.new( @img.fragment(x1,x2,y1,y2) )
  end
  
  
  def rows()
    @img.img_rw.rows()
  end
  

  def columns()
    @img.img_rw.columns()
  end


  
end