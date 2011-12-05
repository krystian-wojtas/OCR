require 'MyImgLib'

MyImgLib.class_eval do
  
  #przycina wartosc koloru do zakresu 0 - Magick::QuantumRange
  #TODO moze range?
  #TODO osobny plik
  def cut(c)
    (c > Magick::QuantumRange) ? Magick::QuantumRange : ( (c < 0) ? 0 : c )
  end

  public
  
    def jasnosc(w)
      edit do
        do_jasnosc(w)
      end
    end

    def kontrast(w)
      edit do
        do_kontrast(w)
      end
    end

    def krzyzRobertsa
      edit do
        do_krzyzRobertsa
      end
    end
  
    def sobel
      edit do
        do_sobel
      end
    end

    def obrot(kat)
      edit do
        do_obrot(kat)
      end
    end
  
  private
    
    def do_jasnosc(w)
      iteruj do |r, c, chb|
        cut( chb[r][c] + w )
      end
    end

    def do_kontrast(w)
      iteruj do |r, c, chb|
        cut( chb[r][c] * w )
      end
    end

    def do_krzyzRobertsa
      iteruj(:top => 1, :bottom => 1, :left => 1, :right => 1) do |r, c, chb|
        cut( (chb[r][c] - chb[r+1][c+1]).abs + (chb[r][c+1] - chb[r+1][c]).abs )
      end
    end

    #TODO nie dziala
    def do_sobel
      iteruj(:top => 1, :bottom => 1, :left => 1, :right => 1) do |r, c, chb|
        #puts c.to_s + ' ' + r.to_s
        # [p0 p1 p2; p7 px p3; p6 p5 p4],
        # x = (p2+2*p3+p4)-(p0+2*p7+p6)
        # y = (p6+2*p5+p4)-(p0+2*p1+p2)
        #przy odwroconych wspolrzednych wychodzi polowa trojkata biala, druga polowa ma zmienione kolory; obraz przekrecony o 90
        x = chb[c+1][r-1] + 2*chb[c+1][r] + chb[c+1][r+1]
        y = chb[c-1][r+1] + 2*chb[c][r-1] + chb[c+1][r+1] - chb[c-1][r-1] - 2*chb[c][r-1] - chb[c-1][r+1]
        cut( Math.sqrt(x*x + y*y) )
=begin
        x = chb[r+1][c-1] + 2*chb[r+1][c] + chb[r+1][c+1]
        y = chb[r-1][c+1] + 2*chb[r][c-1] + chb[r+1][c+1] - chb[r-1][c-1] - 2*chb[r][c-1] - chb[r-1][c+1]
        cut( Math.sqrt(x*x + y*y) )
=end
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

end