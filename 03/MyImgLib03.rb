require 'MyImgLib'

MyImgLib.class_eval do

  def jasnosc(w)
    edit do |i, j, chb|
      cut( chb[i][j] + w )
    end
  end

  def kontrast(w)
    edit do |i, j, chb|
      cut( chb[i][j] * w )
    end
  end

  def sobel
    edit(:top => 1, :bottom => 1, :left => 1, :right => 1) do |c, r, chb|
      #puts c.to_s + ' ' + r.to_s
      # [p0 p1 p2; p7 px p3; p6 p5 p4],
      # x = (p2+2*p3+p4)-(p0+2*p7+p6)
      # y = (p6+2*p5+p4)-(p0+2*p1+p2)
      x = chb[c+1][r-1] + 2*chb[c+1][r] + chb[c+1][r+1]
      y = chb[c-1][r+1] + 2*chb[c][r-1] + chb[c+1][r+1] - chb[c-1][r-1] - 2*chb[c][r-1] - chb[c-1][r+1]
      cut( Math.sqrt(x*x + y*y) )
    end
  end

  def krzyzRobertsa
    edit(:top => 1, :bottom => 1, :left => 1, :right => 1) do |i, j, chb|
      cut( (chb[i][j] - chb[i+1][j+1]).abs + (chb[i][j+1] - chb[i+1][j]).abs )
    end
  end
  
  def obroc(i, j, kat)
    [
      ( Math.cos(kat)*i-Math.sin(kat)*j ).to_i,
      ( Math.sin(kat)*i+Math.cos(kat)*j ).to_i,
    ]
  end

  def obrot(kat)
    #powrot jesli nie trzeba obracac
    if kat == 0
      return @orginal
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
    #puts 'p ' + p.to_s
    
    edit(:columns => width, :rows => height ) do |i, j, chb|
      xp, yp = obroc(i+q, j+p, kat)
      if xp < @orginal.columns and yp < @orginal.rows and xp > 0 and yp > 0 
     #puts i.to_s + ' ' + j.to_s + "\t" + xp.to_s + ' ' + yp.to_s #TODO aspect na kacie
     cut( chb[xp][yp] ) 
      else
     Magick::QuantumRange
      end
    end
  end

end