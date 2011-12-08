require 'MyImgLib'

class MyImgLib

  #przycina wartosc koloru do zakresu 0 - Magick::QuantumRange
  #TODO moze range?
  #TODO osobny plik
  def cut(c)
    (c > Magick::QuantumRange) ? Magick::QuantumRange : ( (c < 0) ? 0 : c )
  end
  
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

    def drukuj
      edit do
        do_drukuj
      end
    end
  
  
  private
  
    def do_negatyw
      iteruj do |r, c, ch|
        ch[r][c] = cut( Magick::QuantumRange - ch[r][c] )
      end
    end
    
    
    def do_szaro1
      iteruj(:collable=>Callable.factory(:monocolor)) do |r, c, ch|
        ch[r][c] = (@rchb[r][c] + @gchb[r][c] + @bchb[r][c]) / 3
      end
    end
  
    
    def do_szaro2
      iteruj(:collable=>Callable.factory(:monocolor)) do |r, c, ch|
        ch[r][c] = 0.3*@rchb[r][c] + 0.59*@gchb[r][c] + 0.11*@bchb[r][c]
      end
    end
    
    
    def do_histogram2
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
    
    
    def do_ekstrema(ch)
      min = Magick::QuantumRange
      max = 0
      iteruj do |r, c, ch|
        min = ch[r][c] if ch[r][c] < min
        max = ch[r][c] if ch[r][c] > min
      end
      [ min, max ]
    end


    def do_histogram
      minr, maxr = do_ekstrema(@rch)
      ming, maxg = do_ekstrema(@gch)
      minb, maxb = do_ekstrema(@bch)
      
      iteruj(:callable => :other) do |r, c|
        @rch[r][c] = cut( Magick::QuantumRange * (@rch[r][c] - minr) / (maxr - minr) )
        @gch[r][c] = cut( Magick::QuantumRange * (@rch[r][c] - minr) / (maxr - minr) )
        @bch[r][c] = cut( Magick::QuantumRange * (@rch[r][c] - minr) / (maxr - minr) )
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


  def do_drukuj
    iteruj do |r, c|
      puts r.to_s + ' ' + c.to_s + ' ' + @rchb[r][c].to_s
      puts r.to_s + ' ' + c.to_s + ' ' + @gchb[r][c].to_s
      puts r.to_s + ' ' + c.to_s + ' ' + @bchb[r][c].to_s
    end
  end
  
end