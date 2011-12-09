require 'Core'

class FImg4RR

    def obrot(kat)
      edit do
        do_obrot(kat)
      end
    end
  
    def skaluj(s)
      edit do
        do_skaluj(s)
      end
    end
    
  #funkcja pomocnicza dla do_obrot
  #TODO wrzucic ja do srodka do_obrot
  #funkcja obracajaca punkt o zadany kat wokol punktu 0,0
  def obroc(i, j, kat)
    [
      ( Math.cos(kat)*i-Math.sin(kat)*j ).to_i,
      ( Math.sin(kat)*i+Math.cos(kat)*j ).to_i,
    ]
  end

  def do_obrot(kat)
    #powrot jesli nie trzeba obracac
    if kat == 0
      return
    end
    #ustalenie wymiarow obrazka i przesuniecia
    xs = []
    ys = []
    [ [0, 0], [@orginal.columns, 0], [@orginal.columns, @orginal.rows], [0, @orginal.rows] ].each do |x, y|
        xp, yp = obroc(x, y, kat)
        xs.push( xp )
        ys.push( yp )
    end
    xs.sort!()
    ys.sort!()
    #szerokosc i wysokosc nowego obrazka
    width = xs[3] - xs[0]
    height = ys[3] - ys[0]
    #wektor przesuniecia [p, q]
    p = xs[0]
    q = ys[0]
    
    iteruj(:columns => width, :rows => height, :buffered => 1, :background => Magick::QuantumRange) do |i, j, chb|
      xp, yp = obroc(i+q, j+p, kat)
      if xp < @orginal.columns and yp < @orginal.rows and xp > 0 and yp > 0 
        #puts i.to_s + ' ' + j.to_s + "\t" + xp.to_s + ' ' + yp.to_s #TODO aspect na kacie
        cut( chb[xp][yp] )
      end
    end
  end

    
    def do_skaluj(s)
      iteruj(:buffered => 1, :width => s*@orginal.rows, :height => s*@orginal.columns) do |r, c, ch, chb|
        puts r.to_s + ' ' + c.to_s
        ch[r][c] = chb[r/s][c/s]
        nil
      end
    end
  
  def zoom(scale)
    edit(
      :scale => scale,
      :columns => (scale * @orginal.columns).to_i,
      :rows => (scale * @orginal.rows).to_i ) do |i, j, chb|
      chb[i][j]
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
