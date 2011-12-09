require 'FImg4RR_Core'
require 'Tools'

class FImg4RR


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
  
    def jasnosc(w)
      edit do
        do_jasnosc(w)
      end
    end

    def kontrast(w)
      edit do
        do_kontrast(w)
      end
    end
  

    def histogram
      edit do
        do_histogram
      end
    end

  
  
    def do_negatyw
      iteruj do |r, c, ch|
        ch[r][c] = Tools.cut( Magick::QuantumRange - ch[r][c] )
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
    
    def do_jasnosc(w)
      iteruj do |r, c, chb|
        Tools.cut( chb[r][c] + w )
      end
    end

    def do_kontrast(w)
      iteruj do |r, c, chb|
        Tools.cut( chb[r][c] * w )
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
      
      #if rozne kanaly znajdz ming i maxg i przepisz je na wszystkie
      
      iteruj(:callable => :other) do |r, c|
        @rch[r][c] = cut( Magick::QuantumRange * (@rch[r][c] - minr) / (maxr - minr) )
        @gch[r][c] = cut( Magick::QuantumRange * (@rch[r][c] - minr) / (maxr - minr) )
        @bch[r][c] = cut( Magick::QuantumRange * (@rch[r][c] - minr) / (maxr - minr) )
      end
      
      [ minr, maxr, ming, maxg, minb, maxb ]
    end
    
  end
