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
  
  iteruj :columns => width, :rows => height, :buffered => true, :background => @QR do |r, c|
    xp, yp = rotating(r+q, c+p, kat)
    if (0 < xp and xp < @img_rw.columns)  and  (0 < yp and yp < @img_rw.rows) #TODO range?
      @vch[r][c] = @vchb[xp][yp]
    end
  end
  self
end
