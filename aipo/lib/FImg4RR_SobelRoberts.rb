require 'Core'

class FImg4RR


    def krzyzRobertsa
      edit do
        do_krzyzRobertsa
      end
    end
  
    def sobel
      edit do
        do_sobel
      end
    end
  

    def do_krzyzRobertsa
      iteruj(:top => 1, :bottom => 1, :left => 1, :right => 1) do |r, c, chb|
        cut( (chb[r][c] - chb[r+1][c+1]).abs + (chb[r][c+1] - chb[r+1][c]).abs )
      end
    end

    #TODO nie dziala
    def do_sobel
      iteruj(:top => 1, :bottom => 1, :left => 1, :right => 1) do |r, c, chb|
        #puts c.to_s + ' ' + r.to_s
        # [p0 p1 p2; p7 px p3; p6 p5 p4],
        # x = (p2+2*p3+p4)-(p0+2*p7+p6)
        # y = (p6+2*p5+p4)-(p0+2*p1+p2)
        #przy odwroconych wspolrzednych wychodzi polowa trojkata biala, druga polowa ma zmienione kolory; obraz przekrecony o 90
        x = chb[c+1][r-1] + 2*chb[c+1][r] + chb[c+1][r+1]
        y = chb[c-1][r+1] + 2*chb[c][r-1] + chb[c+1][r+1] - chb[c-1][r-1] - 2*chb[c][r-1] - chb[c-1][r+1]
        cut( Math.sqrt(x*x + y*y) )
=begin
        x = chb[r+1][c-1] + 2*chb[r+1][c] + chb[r+1][c+1]
        y = chb[r-1][c+1] + 2*chb[r][c-1] + chb[r+1][c+1] - chb[r-1][c-1] - 2*chb[r][c-1] - chb[r-1][c+1]
        cut( Math.sqrt(x*x + y*y) )
=end
      end
    end
    
end
