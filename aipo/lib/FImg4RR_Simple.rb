require 'FImg4RR_Core'
require 'Tools'

class FImg4RR


  def negatyw
    edit do
      do_negatyw
    end
    self
  end

  def szaro1
    edit do
      do_szaro1
    end
    self
  end

  def szaro2
    edit do
      do_szaro2
    end
    self
  end

  def jasnosc(w)
    edit do
      do_jasnosc(w)
    end
    self
  end

  def kontrast(w)
    edit do
      do_kontrast(w)
    end
    self
  end

  def skaluj(s)
    edit do
      do_skaluj(s)
    end
    self
  end
  

  def histogram(osobne_kanaly = true)
    edit do
      do_histogram(osobne_kanaly)
    end
    self
  end

  
  
  def do_negatyw
    iteruj do |r, c, ch|
      ch[r][c] = Tools.cut( Magick::QuantumRange - ch[r][c] )
    end
  end
  
  
  def do_szaro1
    iteruj(:collable=>:monocolor) do |r, c, ch|
      ch[r][c] = (@rchb[r][c] + @gchb[r][c] + @bchb[r][c]) / 3
    end
  end

  
  def do_szaro2
    iteruj(:collable=>:monocolor) do |r, c, ch|
      ch[r][c] = 0.3*@rchb[r][c] + 0.59*@gchb[r][c] + 0.11*@bchb[r][c]
    end
  end
  
  def do_jasnosc(w)
    iteruj do |r, c, ch|
      ch[r][c] = Tools.cut( ch[r][c] + w )
    end
  end

  def do_kontrast(w)
    iteruj do |r, c, ch|
      ch[r][c] = Tools.cut( ch[r][c] * w )
    end
  end

  
  def do_skaluj(s)
    iteruj(
      :buffered => 1,
      :rows => (s*@orginal.rows).to_i,
      :columns => (s*@orginal.columns).to_i ) do |r, c, ch, chb|
      ch[r][c] = chb[r/s][c/s]
    end
  end
    
    
    def do_ekstrema(ch)
      min = Magick::QuantumRange
      max = 0
      iteruj(:callable=>:other) do |r, c|     
        min = ch[r][c] if ch[r][c] < min
        max = ch[r][c] if ch[r][c] > max
      end
      [ min, max ]
    end


    def do_histogram(osobne_kanaly = true)
      minr, maxr = do_ekstrema(@rch)
      ming, maxg = do_ekstrema(@gch)
      minb, maxb = do_ekstrema(@bch)
      
      unless osobne_kanaly
        minr = ming = minb = [ minr, ming, minb ].min
        maxr = maxg = maxb = [ maxr, maxg, maxb ].max
      end
      
      iteruj(:callable => :other) do |r, c|
        @rch[r][c] = Tools.cut( Magick::QuantumRange * (@rch[r][c] - minr) / (maxr - minr) )
        @gch[r][c] = Tools.cut( Magick::QuantumRange * (@gch[r][c] - ming) / (maxg - ming) )
        @bch[r][c] = Tools.cut( Magick::QuantumRange * (@bch[r][c] - minb) / (maxb - minb) )
      end
      
      [ minr, maxr, ming, maxg, minb, maxb ]
    end
    
  end
