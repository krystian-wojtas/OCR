require 'MyImgLib'

class MyImgLib

  public
  
    def negatyw
      edit do
        do_negatyw
      end
    end
  
    def szaro1
      edit do
        do_szaro1
      end
    end
  
    def szaro2
      edit do
        do_szaro2
      end
    end
    
    def histogram
      edit do
        do_histogram
      end
    end
  
    def skaluj(s)
      edit do
        do_skaluj(s)
      end
    end
  
  
  private
  
    def do_negatyw
      iteruj(:buffered=>1) do |r, c|
        @rch[r][c] = Magick::QuantumRange - @rchb[r][c]
        @gch[r][c] = Magick::QuantumRange - @gchb[r][c]
        @bch[r][c] = Magick::QuantumRange - @bchb[r][c]
        puts r.to_s + ' ' + c.to_s + ' ' + @rchb[r][c].to_s + ' ' + @rch[r][c].to_s
      end
    end
    
    
    def do_szaro1
      iteruj do |r, c|
        @rch[r][c] = @gch[r][c] = @bch[r][c] =
          (@rchb[r][c] + @gchb[r][c] + @bchb[r][c]) / 3
      end
    end
  
    
    def do_szaro2
      iteruj do |r, c|
        @rch[r][c] = @gch[r][c] = @bch[r][c] =
          0.3*@rchb[r][c] + 0.59*@gchb[r][c] + 0.11*@bchb[r][c]
      end
    end
    
    
    def do_histogram
      #funkcja pomocnicza
      def ekstrema(chb)
        min = Magick::QuantumRange
        max = 0
        0.upto chb.length-1 do |r|
          0.upto chb[r].length-1 do |c|
            min = chb[r][c] if chb[r][c] < min
            max = chb[r][c] if chb[r][c] > min
          end
        end
        [ min, max ]
      end
      #wartosci ekstremalne z kazdego kanalu
      minr, maxr = ekstrema(@rchb)
      ming, maxg = ekstrema(@gchb)
      minb, maxb = ekstrema(@bchb)
      
      iteruj do |r, c|
        przepisz_na_kanaly(r, c,
          [
            Magick::QuantumRange * (@rchb[r][c] - minr) / (maxr - minr),
            Magick::QuantumRange * (@gchb[r][c] - ming) / (maxg - ming),
            Magick::QuantumRange * (@bchb[r][c] - minb) / (maxb - minb),
          ]
        )
      end
      
      [ minr, maxr, ming, maxg, minb, maxb ]
    end

    
    def do_skaluj(s)
      iteruj(:buffered => 1, :width => s*@orginal.rows, :height => s*@orginal.columns) do |r, c, ch, chb|
        puts r.to_s + ' ' + c.to_s
        ch[r][c] = chb[r/s][c/s]
        nil
      end
    end
    

def zoom(orginal, scale)
  mod = Magick::Image.new(scale*orginal.rows, scale*orginal.columns)
  mod.each_pixel do |pixel, c, r|
    px = orginal.pixel_color(c/scale, r/scale)
    mod.pixel_color(c, r, px)
  end
  return mod
end
  
end