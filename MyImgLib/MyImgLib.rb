require 'RMagick'

class MyImgLib

  def initialize(orginal)
    @orginal = orginal
  end


  protected
  
    #edit zajmuje sie przepisaniem wartosci kanalow obrazka z obiektu Image biblioteki RMagick na czyste tablice Rubiego
    #poslugiwanie sie tablicami jest szybsze, metoda putpixel sprawdza zakresy obszaru obrazka oraz zakres koloru; nie zawsze sprawdzenia sa konieczne TODO sprawdzic
    #oraz czyste tablice wygladaja w kodzie zwiezlej niz uzywanie pixel_color
    #na koniec zwracany jest nowy obiekt RMagick z wykonanymi przeksztalceniami
    def edit(opts={}, &block)

      #parametry opcjonalne nalozone na domyslne
      @o = {
        :top => 0,
        :bottom => 0,
        :left => 0,
        :right => 0,
        :columns => @orginal.columns,
        :rows => @orginal.rows,
        :buffered => 0,
      }.merge(opts)

      # tablice kanalow barw orginalu oraz obrazka przetwarzanego
      @rch = @rchb = []
      @gch = @gchb = []
      @bch = @bchb = []
      if @o[:buffered]
        @rch = []
        @gch = []
        @bch = []
      end
      
      # ladowanie kolejnych wersow obrazka do tablic kanalow
      0.upto @orginal.rows-1 do |r|
        @rchb.push( @orginal.export_pixels(0, r, @orginal.columns, 1, "R" ) )
        @gchb.push( @orginal.export_pixels(0, r, @orginal.columns, 1, "G" ) )
        @bchb.push( @orginal.export_pixels(0, r, @orginal.columns, 1, "B" ) )
      end      
      #jesli jest buforowanie utworzenie tablic oraz poczatkowe wyczarnienie obrazka przetwarzanego
      if @o[:buffered]
        @o[:top].upto @o[:rows]-@o[:bottom]-1 do |r| #TODO odjalem jedynke, gdzies byla potrzebna do dodania, przesledzic
          @rch.push( Array.new(@o[:columns], 0) )
          @gch.push( Array.new(@o[:columns], 0) )
          @bch.push( Array.new(@o[:columns], 0) )
        end
      end

      #przeksztalcenia
      yield

      #przepisanie wynikow do nowego obrazka
      mod = Magick::Image.new( @o[:columns], @o[:rows] )
      (@o[:rows]-@o[:bottom]-1).downto @o[:top] do |r|
        mod.import_pixels(0, r, mod.columns, 1, "R", @rch.pop)
        mod.import_pixels(0, r, mod.columns, 1, "G", @gch.pop)
        mod.import_pixels(0, r, mod.columns, 1, "B", @bch.pop)
      end
      
      mod
    end
    
    
    #metoda iterujaca po obrazku sprawdza ilosc argumentow przekazanego bloku
    #
    def iteruj(opts={}, &block)
      
      #parametry opcjonalne nalozone na domyslne oraz na globalne
      @oi = {
        :scale => 1,
      }.merge(@o).merge(opts)      
      
      #rzezba
      case block.arity
      when 3, 4
        @oi[:top].upto @oi[:rows]-@oi[:bottom]-1 do |r|
          @oi[:left].upto @oi[:columns]-@oi[:right]-1 do |c|
            @rch[c][r] = yield(c/@oi[:scale], r/@oi[:scale], @rchb)
            @gch[c][r] = yield(c/@oi[:scale], r/@oi[:scale], @gchb)
            @bch[c][r] = yield(c/@oi[:scale], r/@oi[:scale], @bchb)
          end
        end
      when 5
        #TODO przepisac, wyjac ifa na zewnatrz
        @oi[:top].upto @oi[:rows]-@oi[:bottom]-1 do |r|
          @oi[:left].upto @oi[:columns]-@oi[:right]-1 do |c|
            #sprawdzenie zwracanego typu. Jesli jedna wartosc to przepisz ja na wszystkie kanaly. Jesli tablica 3 wartosci: kolejne kanaly
            res = yield(c/@oi[:scale], r/@oi[:scale], @rchb, @gchb, @bchb)
            if res.kind_of?(Array)
              @rch[c][r] = res[0]
              @gch[c][r] = res[1]
              @bch[c][r] = res[2]
            else
              @rch[c][r] = @gch[c][r] = @bch[c][r] = res
            end
          end
        end
      end
    end

    
    #przycina wartosc koloru do zakresu 0 - Magick::QuantumRange
    #TODO moze range?
    def cut(c)
      (c > Magick::QuantumRange) ? Magick::QuantumRange : ( (c < 0) ? 0 : c )
    end
end