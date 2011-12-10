require 'FImg4RR_Core'
require 'Tools'

class FImg4RR


    def krzyzRobertsa
      edit do
        do_krzyzRobertsa
      end
      self
    end
  
    def sobel
      edit do
        do_sobel
      end
      self
    end
  

    def do_krzyzRobertsa
      iteruj(:bottom => 1, :right => 1) do |r, c, ch|
        ch[r][c] = Tools.cut( (ch[r][c] - ch[r+1][c+1]).abs + (ch[r][c+1] - ch[r+1][c]).abs )
      end
    end

    #TODO nie dziala
    def do_sobel
      iteruj(:buffered=>1, :top=>1, :bottom=>1, :left=>1, :right=>1) do |r, c, ch, chb|
        #puts c.to_s + ' ' + r.to_s
        # [p0 p1 p2; p7 px p3; p6 p5 p4],
        # x = (p2+2*p3+p4)-(p0+2*p7+p6)
        # y = (p6+2*p5+p4)-(p0+2*p1+p2)
        x = chb[r-1][c+1] + 2*chb[r][c+1] + chb[r+1][c+1] - chb[r-1][c-1] - 2*chb[r][c-1] - chb[r+1][c-1]
        y = chb[r+1][c-1] + 2*chb[r+1][c] + chb[r+1][c+1] - chb[r-1][c-1] - 2*chb[r-1][c] - chb[r-1][c+1]
        ch[r][c] = Tools.cut( Math.sqrt(x*x + y*y) )
      end
    end
    
end
