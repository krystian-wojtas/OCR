require 'MyImgLib'

MyImgLib.class_eval do
  
  def options(opts={})
    # parametry opcjonalne
    # zapisac do obiektu ?
    @o = {
      :top => 0,
      :bottom => 0,
      :left => 0,
      :right => 0,
      :scale => 1,
      :columns => @orginal.columns,
      :rows => @orginal.rows
    }.merge(opts)
  end
  
  def import()
    # tablice kanalow barw orginalu oraz obrazka przetwarzanego
    #TODO buforowanie; zrobione na lapcioku w szkicu 04
    rchb = []
    gchb = []
    bchb = []
    rch = []
    gch = []
    bch = []
    # ladowanie kolejnych wersow obrazka do tablic kanalow
    0.upto @orginal.rows-1 do |r|
      rchb.push( @orginal.export_pixels(0, r, @orginal.columns, 1, "R" ) )
      gchb.push( @orginal.export_pixels(0, r, @orginal.columns, 1, "G" ) )
      bchb.push( @orginal.export_pixels(0, r, @orginal.columns, 1, "B" ) )
    end
    #poczatkowe wyczarnienie obrazka przetwarzanego
    @o[:top].upto @o[:rows]-@o[:bottom]-1 do |r| #TODO odjalem jedynke, gdzies byla potrzebna do dodania, przesledzic
      rch.push( Array.new(o[:columns], 0) )
      gch.push( Array.new(o[:columns], 0) )
      bch.push( Array.new(o[:columns], 0) )
    end
    
  end
  
  def eksport()
    mod = Magick::Image.new( o[:columns], o[:rows] )
    (o[:rows]-o[:bottom]-1).downto o[:top] do |r|
      mod.import_pixels(0, r, mod.columns, 1, "R", rch.pop)
      mod.import_pixels(0, r, mod.columns, 1, "G", gch.pop)
      mod.import_pixels(0, r, mod.columns, 1, "B", bch.pop)
    end
    mod
  end
  
  def rzezba
    #rzezba
    #TODO rzezba w osobnej funkcji
    case block.arity
    when 3, 4
      o[:top].upto o[:rows]-o[:bottom]-1 do |r|
        o[:left].upto o[:columns]-o[:right]-1 do |c|
    rch[c][r] = yield(c/o[:scale], r/o[:scale], rchb)
    gch[c][r] = yield(c/o[:scale], r/o[:scale], gchb)
    bch[c][r] = yield(c/o[:scale], r/o[:scale], bchb)
        end
      end
    when 5
      #TODO przepisac, wyjac ifa na zewnatrz
      o[:top].upto o[:rows]-o[:bottom]-1 do |r|
        o[:left].upto o[:columns]-o[:right]-1 do |c|
    #sprawdzenie zwracanego typu. Jesli jedna wartosc to przepisz ja na wszystkie kanaly. Jesli tablica 3 wartosci: kolejne kanaly
    res = yield(c/o[:scale], r/o[:scale], rchb, gchb, bchb)
    if res.kind_of?(Array)
      rch[c][r] = res[0]
      bch[c][r] = res[1]
      gch[c][r] = res[2]
    else
      rch[c][r] = gch[c][r] = bch[c][r] = res
    end
        end
      end
    end
  end
  

def edit2(opts={}, &block)
    options(opts)
    
    eksport(
      rzezba(
        import()
      )
    )
  end

  def ramka(s=1, kolor=Magick::QuantumRange)
      edit(:columns => @orginal.columns + 2*s, :rows => @orginal.rows+2*s) do |c, r, chb|
        if c < s or c > @orginal.columns+s-1 or r < s or r > @orginal.rows+s-1
          kolor
        else
          chb[c-s][r-s]
        end
      end
  end
  
  def ramka2(s=1)
      edit(:columns => @orginal.columns + 2*s, :rows => @orginal.rows+2*s) do |c, r, chb|
        if c < s or c > @orginal.columns+s-1 or r < s or r > @orginal.rows+s-1
          0
        else
          #warstwa binearyzaji yieldem
          if chb[c-s][r-s] > Magick::QuantumRange / 2
            1
          else
            0
          end
        end
      end
  end

@@czworki = [ 3, 6, 7, 12, 14, 15, 24, 28, 30, 48, 56, 60, 96, 112, 120, 129, 131, 135, 192, 193, 195, 224, 225, 240 ]
@@wyciecia = [ 3, 5, 7, 12, 13, 14, 15, 20, 21, 22, 23, 28, 29, 30, 31, 48, 52, 53, 54, 55, 56, 60, 61, 62, 63, 65, 67, 69, 71, 77, 79, 80, 81, 83, 84, 85, 86, 87, 88, 89, 91, 92, 93, 94, 95, 97, 99, 101, 103, 109, 111, 112, 113, 115, 116, 117, 118, 119, 120, 121, 123, 124, 125, 126, 127, 131, 133, 135, 141, 143, 149, 151, 157, 159, 181, 183, 189, 191, 192, 193, 195, 197, 199, 205, 207, 208, 209, 211, 212, 213, 214, 215, 216, 217, 219, 220, 221, 222, 223, 224, 225, 227, 229, 231, 237, 239, 240, 241, 243, 244, 245, 246, 247, 248, 249, 251, 252, 253, 254, 255 ]
@@sprawdzarka = [ [128, 64, 32], [1, 0, 16], [2, 4, 8] ]
  def kmm
      
    #mod = ramka2
    
    #alokacja tablic, wypelnienie zerami
    vch = []  
    0.upto @orginal.rows-1+2 do |r| #-1 dla rows, +2 dodatkowe wiersze obramowania
      vch.push( Array.new(@orginal.columns+2, 0) ) #+2 dodatkowe kolumny obramowania
    end
    
    #binearyzacja
    1.upto vch.length-2 do |r|
      1.upto vch[r].length-2 do |c|
        if @orginal.pixel_color(c-1, r-1).red > Magick::QuantumRange / 2
          vch[r][c] = 0
        else
          vch[r][c] = 1
        end
      end
    end
    
    #petla
    it = 0
    powtorzyc = true
    while(powtorzyc and it < 100) do #TODO for
    #for(it = 0; it < 100; it += 1) do
      puts it
      it += 1
      powtorzyc = false
      1.upto vch.length-2 do |r|
        1.upto vch[r].length-2 do |c|
          if vch[r][c] == 1
            if vch[r][c-1] == 0 or vch[r][c+1] == 0 or vch[r-1][c] == 0 or vch[r+1][c] == 0
              vch[r][c] = 2
            elsif vch[r-1][c-1] == 0 or vch[r-1][c+1] == 0 or vch[r+1][c-1] == 0 or vch[r+1][c+1] == 0
              vch[r][c] = 3
            end
          end
        end
      end
      def maska(r, c, vch)
        s = 0
        if vch[r-1][c-1] != 0 then s += @@sprawdzarka[0][0] end
        if vch[r-1][c] != 0 then s += @@sprawdzarka[0][1] end
        if vch[r-1][c+1] != 0 then s += @@sprawdzarka[0][2] end 
        if vch[r][c-1] != 0 then s += @@sprawdzarka[1][0] end
        if vch[r][c+1] != 0 then s += @@sprawdzarka[1][2] end
        if vch[r+1][c-1] != 0 then s += @@sprawdzarka[2][0] end
        if vch[r+1][c] != 0 then s += @@sprawdzarka[2][1] end
        if vch[r+1][c+1] != 0 then s += @@sprawdzarka[2][2] end
        s
      end
      1.upto vch.length-2 do |r|
        1.upto vch[r].length-2 do |c|
          if vch[r][c] == 2
            if @@czworki.include? maska(r,c, vch)
              vch[r][c] = 4
            end
          end
        end
      end
      1.upto vch.length-2 do |r|
        1.upto vch[r].length-2 do |c|
          if vch[r][c] == 4
            if @@wyciecia.include? maska(r,c, vch)
              vch[r][c] = 0
              powtorzyc = true
            else
              vch[r][c] = 1
            end
          end
        end
      end
      1.upto vch.length-2 do |r|
        1.upto vch[r].length-2 do |c|
          if vch[r][c] == 2
            if @@wyciecia.include? maska(r,c, vch)
              vch[r][c] = 0
              powtorzyc = true
            else
              vch[r][c] = 1
            end
          end
        end
      end
      1.upto vch.length-2 do |r|
        1.upto vch[r].length-2 do |c|
          if vch[r][c] == 3
            if @@wyciecia.include? maska(r,c, vch)
              vch[r][c] = 0
              powtorzyc = true
            else
              vch[r][c] = 1
            end
          end
        end
      end
    end
    puts '--------- ' + it.to_s
#debinearyzacja
    mod = Magick::Image.new( @orginal.columns, @orginal.rows )
    0.upto mod.rows-1 do |r|
      0.upto mod.columns-1 do |c|
        if vch[r][c] == 0
          px = Magick::Pixel::new( Magick::QuantumRange, Magick::QuantumRange, Magick::QuantumRange, Magick::QuantumRange )
        else
          px = Magick::Pixel::new( 0, 0, 0, Magick::QuantumRange )
        end
        mod.pixel_color(c, r, px)
      end
    end
    
=begin    
    (@orginal.rows-1).downto 0 do |r|
      ch = vch.pop
      mod.import_pixels(0, r, mod.columns, 1, "R", ch)
      mod.import_pixels(0, r, mod.columns, 1, "G", ch)
      mod.import_pixels(0, r, mod.columns, 1, "B", ch)
    end
=end    

    mod
  end
  
end
