require 'FImg4RR_Core'

class FImg4RR


  def binaryzacja(tol = Magick::QuantumRange / 2, min = 0, max = Magick::QuantumRange)
    iteruj  do |r, c|
      if @vchb[r][c] > tol
        @vch[r][c] = max
      else
        @vch[r][c] = min
      end
    end   
    self
  end
  
  def do_progowanie(tol, obszarow)
    obszarow.downto 0 do |i|
      obszarow.downto 0 do |j|
        @o.merge!(
          :left => @orginal.columns/obszarow*i,
          :right => @orginal.columns/obszarow*(i+1),
          :top => @orginal.rows/obszarow*j,
          :down => @orginal.rows/obszarow*(j+1)
        )
        iteruj(:left => @orginal.columns/obszarow*i, :right => @orginal.columns/obszarow*(i+1), :top => 1, :down => 2) do |chr, chg, chb, c, r|
  
        end
      end
    end
  end

end
