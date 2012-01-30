require 'FImg4R_Core'

class FImg4R
  
  attr_reader :prj_h, :prj_v
    
  def projection_horizontal()
    @prj_h = Array.new(@s.o[:rows], 0)
    iteruj :channels => :monocolor do |r, c|
      #p r.to_s + ' ' + c.to_s
      #"19 27"
      #"19 28"
      #"19 29"
      if @vchb[r][c] < @QR/2
        @prj_h[r] = @prj_h[r]+1
      end
    end
    #0.upto @prj_h.size() do |i|
    #  p 'aa ' + i.to_s + ' ' + @prj_h[i].to_s
    #end
    self
  end
  
  
  def projection_vertical()
    @prj_v = Array.new(@s.o[:columns], 0)
    iteruj :channels => :monocolor, :iterable => :reverse do |c, r|
      #p r.to_s + ' ' + c.to_s
      if @vchb[r][c] < @QR/2
        @prj_v[c] = @prj_v[c]+1
      end
    end
    self    
  end
  
end