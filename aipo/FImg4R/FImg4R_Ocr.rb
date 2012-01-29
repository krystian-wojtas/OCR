require 'FImg4R_Core'

class FImg4R
  
  attr_reader :prj_h, :prj_v
    
  def projection_horizontal()
    @prj_h = Array.new(@s.o[:rows], 0)
    iteruj :channels => :monocolor do |r, c|
      if @vchb[r][c] > @img_rw.qr()/2
        @prj_h[r] = @prj_h[r]+1
      end
    end
    self
  end
  
  
  def projection_vertical()
    
  end
  
end