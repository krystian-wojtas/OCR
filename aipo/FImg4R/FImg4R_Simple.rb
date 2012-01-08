require 'FImg4R_Core'
require 'FImg4R_Tools'

class FImg4R
  
  def negate    
    iteruj do |r, c|
      @vch[r][c] = cut( @img_rw.qr() - @vchb[r][c] )  
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
      @vch[r][c] = (0.3*@rchb[r][c] + 0.59*@gchb[r][c] + 0.11*@bchb[r][c]).to_i
    end
    self
  end


  def brightness(w)
    w = (w * @qr).to_i
    iteruj do |r, c|
      @vch[r][c] = cut( @vchb[r][c] + w )
    end
    self
  end


  def contrast(w) 
    iteruj do |r, c|
      @vch[r][c] = cut( (@vchb[r][c] * w).to_i )
    end
    self
  end


  def zoom(s) 
    iteruj :buffered => true, :rows => (s*@img_rw.rows).to_i, :columns => (s*@img_rw.columns).to_i do |r, c|
      @vch[r][c] = @vchb[r/s][c/s]
    end
    self
  end
       
  
  # TODO tools 
  def extrems(ch=@vch)
    min = @img_rw.qr()
    max = 0
    iteruj :channels => :other do |r, c|
      min = ch[r][c] if ch[r][c] < min
      max = ch[r][c] if ch[r][c] > max
    end
    [ min, max ]
  end


  def histogram
    minr, maxr = extrems(@rch)
    ming, maxg = extrems(@gch)
    minb, maxb = extrems(@bch)
    iteruj :channels => :other do |r, c|
      @rch[r][c] = cut( @img_rw.qr() * (@rch[r][c] - minr) / (maxr - minr) )
      @gch[r][c] = cut( @img_rw.qr() * (@gch[r][c] - ming) / (maxg - ming) )
      @bch[r][c] = cut( @img_rw.qr() * (@bch[r][c] - minb) / (maxb - minb) )
    end   
    self
  end


  #TODO doesnt work
  def histogram_grayscale
    grayscale1
    min, max = extrems
    iteruj :channels => :monocolor do |r, c|
      @vch[r][c] = cut( @img_rw.qr() * (@vch[r][c] - min) / (max - min) )
    end 
    self
  end
  
  end
