require 'FImg4R_Core'

class FImg4R

    
  #funkcja pomocnicza dla do_obrot
  #TODO wrzucic ja do srodka do_obrot
  #funkcja obracajaca punkt o zadany kat wokol punktu 0,0
  def rotating(i, j, kat)
    [
      ( Math.cos(kat)*i-Math.sin(kat)*j ).to_i,
      ( Math.sin(kat)*i+Math.cos(kat)*j ).to_i,
    ]
  end
  

  def rotate(kat)
    #powrot jesli nie trzeba obracac
    if kat == 0
      return
    end
    #ustalenie wymiarow obrazka i przesuniecia
    xs = []
    ys = []
    [ [0, 0], [@img_rw.columns, 0], [@img_rw.columns, @img_rw.rows], [0, @img_rw.rows] ].each do |x, y|
        xp, yp = rotating(x, y, kat)
        xs.push( xp )
        ys.push( yp )
    end
    #szerokosc i wysokosc nowego obrazka
    width = xs.max - xs.min
    height = ys.max - ys.min
    #wektor przesuniecia [p, q]
    p = xs.min
    q = ys.min
    
    iteruj :columns => width, :rows => height, :buffered => true, :background => @qr do |r, c|
      xp, yp = rotating(r+q, c+p, kat)
      if (0 < xp and xp < @img_rw.columns)  and  (0 < yp and yp < @img_rw.rows) #TODO range?
        @vch[r][c] = @vchb[xp][yp]
        #puts r.to_s + ' ' + c.to_s + "\t" + xp.to_s + ' ' + yp.to_s + ' ' + @vch[r][c].to_s + ' ' + @vchb[xp][yp].to_s #TODO aspect na kacie
      end
    end
    self
  end

end
