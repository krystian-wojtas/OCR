require 'FImg4RR_Core'
require 'Tools'

class FImg4RR

  
  def negatyw    
    iteruj do |r, c|
        @vch[r][c] = Tools.cut( Magick::QuantumRange - @vchb[r][c] )  
    end
    self
  end

  def szaro1    
    iteruj :monocolor => 1 do |r, c|
      @vch[r][c] = (@rchb[r][c] + @gchb[r][c] + @bchb[r][c]) / 3
    end
    self
  end
  

  def szaro2 
    iteruj :monocolor => 1 do |r, c|
      @vch[r][c] = 0.3*@rchb[r][c] + 0.59*@gchb[r][c] + 0.11*@bchb[r][c]
    end
    self
  end


def jasnosc(w) 
  iteruj do |r, c|
    @vch[r][c] = Tools.cut( @vchb[r][c] + w )
  end
  self
end


  def kontrast(w) 
    iteruj do |r, c|
      @vch[r][c] = Tools.cut( @vchb[r][c] * w )
    end
    self
  end


  def skaluj(s) 
    iteruj :buffered => true, :rows => (s*@orginal.rows).to_i, :columns => (s*@orginal.columns).to_i do |r, c|
      @vch[r][c] = @vchb[r/s][c/s]
    end
    self
  end


  def histogram(osobne_kanaly = true)
            
    def do_ekstrema(ch)
      min = Magick::QuantumRange
      max = 0
      iteruj :channels => :other do |r, c|
        min = ch[r][c] if ch[r][c] < min
        max = ch[r][c] if ch[r][c] > max
      end
      [ min, max ]
    end
  
    minr, maxr = do_ekstrema(@rch)
    ming, maxg = do_ekstrema(@gch)
    minb, maxb = do_ekstrema(@bch)
    
    unless osobne_kanaly
      minr = ming = minb = [ minr, ming, minb ].min
      maxr = maxg = maxb = [ maxr, maxg, maxb ].max
    end
  
    iteruj :channels => :other do |r, c|
      @rch[r][c] = Tools.cut( Magick::QuantumRange * (@rch[r][c] - minr) / (maxr - minr) )
      @gch[r][c] = Tools.cut( Magick::QuantumRange * (@gch[r][c] - ming) / (maxg - ming) )
      @bch[r][c] = Tools.cut( Magick::QuantumRange * (@bch[r][c] - minb) / (maxb - minb) )
    end    
          
    self
  end
  
  end
