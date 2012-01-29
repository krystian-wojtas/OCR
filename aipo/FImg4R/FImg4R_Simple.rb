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
    w = (w * @QR).to_i
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


  def zoom(s) #TODO check if @s.o[:rows] works
    iteruj :buffered => true, :rows => (s*@s.o[:rows]).to_i, :columns => (s*@s.o[:columns]).to_i do |r, c|
      @vch[r][c] = @vchb[r/s][c/s]
    end
    self
  end


  def stretch_vertical(s) 
    iteruj :buffered => true, :rows => (s*@s.o[:rows]).to_i do |r, c|
      @vch[r][c] = @vchb[r/s][c]
    end
    self
  end


  def stretch_horizontal(s) 
    iteruj :buffered => true, :columns => (s*@s.o[:columns]).to_i do |r, c|
      @vch[r][c] = @vchb[r][c/s]
    end
    self
  end
  
  
  def fit_size(size)
    if size[:rows]
      scale = (0.0 + size[:rows]) / @s.o[:rows]
      stretch_vertical(scale)
    end
    if size[:columns]
      scale = (0.0 + size[:columns]) / @s.o[:columns]
      stretch_horizontal(scale)      
    end
    self
  end



  def fragment(img_org, x, y)
    x2 = x + @s.o[:columns]
    y2 = y + @s.o[:rows]
    p 'x ' + x.to_s
    p 'y ' + y.to_s
    p 'x2 ' + x2.to_s
    p 'y2 ' + y2.to_s
    p 'columns ' + @s.o[:columns].to_s
    p 'rows ' + @s.o[:rows].to_s
    p 'img_org.rch.size ' + img_org.rch.size().to_s
    p 'img_org.rch[0].size ' + img_org.rch[0].size().to_s
    p 'img_org.rch[0][0] ' + img_org.rch[0][0].to_s
    iteruj({
      :left => x, :right => x2,
      :top => y, :bottom => y2,
      :iterable => :area,
      :channels => :other
    }) do |r, c|
      @rch[r-y][c-x] = img_org.rch[r][c]
      @gch[r-y][c-x] = img_org.gch[r][c]
      @bch[r-y][c-x] = img_org.bch[r][c]
    end
    self
  end
  
  
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
