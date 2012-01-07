def rotate(kat)
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
  #szerokosc i wysokosc nowego obrazka
  width = xs.max - xs.min
  height = ys.max - ys.min
  #wektor przesuniecia [p, q]
  p = xs.min
  q = ys.min
  
  iteruj :columns => width, :rows => height, :buffered => true, :background => Magick::QuantumRange do |r, c|
    xp, yp = obroc(r+q, c+p, kat)
    if (0 < xp and xp < @orginal.columns)  and  (0 < yp and yp < @orginal.rows) #TODO range?
      @vch[r][c] = @vchb[xp][yp]
      #puts r.to_s + ' ' + c.to_s + "\t" + xp.to_s + ' ' + yp.to_s + ' ' + @vch[r][c].to_s + ' ' + @vchb[xp][yp].to_s #TODO aspect na kacie
    end
  end
  self
end
