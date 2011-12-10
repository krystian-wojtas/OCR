require 'FImg4RR_Core'
require 'Tools'

class FImg4RR
  

  def krzyzRobertsa
    iteruj :bottom => 1, :right => 1 do |r, c|
      @vch[r][c] = Tools.cut( (@vchb[r][c] - @vchb[r+1][c+1]).abs + (@vchb[r][c+1] - @vchb[r+1][c]).abs )
    end
    self
  end


  def sobel
    iteruj :buffered=>1, :top=>1, :bottom=>1, :left=>1, :right=>1 do |r, c|
      #puts c.to_s + ' ' + r.to_s
      # [p0 p1 p2; p7 px p3; p6 p5 p4],
      # x = (p2+2*p3+p4)-(p0+2*p7+p6)
      # y = (p6+2*p5+p4)-(p0+2*p1+p2)
      x = @vchb[r-1][c+1] + 2*@vchb[r][c+1] + @vchb[r+1][c+1] - @vchb[r-1][c-1] - 2*@vchb[r][c-1] - @vchb[r+1][c-1]
      y = @vchb[r+1][c-1] + 2*@vchb[r+1][c] + @vchb[r+1][c+1] - @vchb[r-1][c-1] - 2*@vchb[r-1][c] - @vchb[r-1][c+1]
      @vch[r][c] = Tools.cut( Math.sqrt(x*x + y*y) )
    end 
    self
  end
    
end
