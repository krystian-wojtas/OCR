require 'FImg4RR_Core'
require 'Tools'

class FImg4RR

  
  def negate    
    iteruj do |r, c|
      @vch[r][c] = Tools.cut( Magick::QuantumRange - @vchb[r][c] )  
    end
    self
  end

  def grayscale1    
    iteruj :channels => :monocolor do |r, c|
      @vch[r][c] = (@rchb[r][c] + @gchb[r][c] + @bchb[r][c]) / 3
    end
    self
  end
  

  def grayscale2 
    iteruj :channels => :monocolor do |r, c|
      @vch[r][c] = 0.3*@rchb[r][c] + 0.59*@gchb[r][c] + 0.11*@bchb[r][c]
    end
    self
  end


  def brightness(w) 
    iteruj do |r, c|
      @vch[r][c] = Tools.cut( @vchb[r][c] + w )
    end
    self
  end


  def contrast(w) 
    iteruj do |r, c|
      @vch[r][c] = Tools.cut( @vchb[r][c] * w )
    end
    self
  end


  def zoom(s) 
    iteruj :buffered => true, :rows => (s*@orginal.rows).to_i, :columns => (s*@orginal.columns).to_i do |r, c|
      @vch[r][c] = @vchb[r/s][c/s]
    end
    self
  end
       
  
  # TODO tools 
  def ekstrema(ch=@vch)
    min = Magick::QuantumRange
    max = 0
    iteruj :channels => :other do |r, c|
      min = ch[r][c] if ch[r][c] < min
      max = ch[r][c] if ch[r][c] > max
    end
    [ min, max ]
  end


  def histogram
    minr, maxr = ekstrema(@rch)
    ming, maxg = ekstrema(@gch)
    minb, maxb = ekstrema(@bch)
    iteruj :channels => :other do |r, c|
      @rch[r][c] = Tools.cut( Magick::QuantumRange * (@rch[r][c] - minr) / (maxr - minr) )
      @gch[r][c] = Tools.cut( Magick::QuantumRange * (@gch[r][c] - ming) / (maxg - ming) )
      @bch[r][c] = Tools.cut( Magick::QuantumRange * (@bch[r][c] - minb) / (maxb - minb) )
    end   
    self
  end


  def histogram_grayscale
    min, max = ekstrema
    iteruj :channels => :monocolor do |r, c|
      @vch[r][c] = Tools.cut( Magick::QuantumRange * (@vch[r][c] - min) / (max - min) )
    end 
    self
  end
  
  end
