require 'Core'

class FImg4RR

  def binearyzacja(tol = Magick::QuantumRange / 2, min = 0, max = Magick::QuantumRange)
    edit do
      do_binearyzacja(tol, min, max)
    end
  end

  def do_binaryzacja(tol = Magick::QuantumRange / 2, min = 0, max = Magick::QuantumRange)
    iteruj do |r, c, chb|
      if chb[r][c] > tol
        max
      else
        min
      end
    end
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
