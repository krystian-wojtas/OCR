#require 'rubygems'
#gem PLATFORM == 'java' ? 'rmagick4j' : 'rmagick'
require 'RMagick'

require 'IterableGenRC'

class MyImgLib
  include IterableGenRC

  def initialize(orginal)
    @orginal = orginal
  end


  protected
  
    #edit zajmuje sie przepisaniem wartosci kanalow obrazka z obiektu Image biblioteki RMagick na czyste tablice Rubiego
    #poslugiwanie sie tablicami jest szybsze, metoda putpixel sprawdza zakresy obszaru obrazka oraz zakres koloru; nie zawsze sprawdzenia sa konieczne TODO sprawdzic
    #oraz czyste tablice wygladaja w kodzie zwiezlej niz uzywanie pixel_color
    #na koniec zwracany jest nowy obiekt biblioteki RMagick Magick::Image z wykonanymi przeksztalceniami
    def edit(opts={})

      #TODO osobna funkcja?
      #parametry opcjonalne nalozone na domyslne
      @o = {
        :top => 0,
        :bottom => 0,
        :left => 0,
        :right => 0,
        :columns => @orginal.columns,
        :rows => @orginal.rows,
        :background => 0,
        #nastepne wartosci wykorzystywane sa podczas iteracji
        :monocolor => 0,
        :buffered => 0,
        #sposob iteracji kolumn i wierszy; domyslnie wyiteruje caly obrazek bez marginesow
        :iterable => iterable(:calosc),
      }.merge(opts)

      # tablice kanalow barw orginalu oraz obrazka przetwarzanego
      # tutaj referencje na tablice buforow i przetwarzan sa te same, dzieki temu domyslnie nie buforuje
      # nowe tablice dla buforow tworzone sa w metodzie iteruj jesli wybrano opcje @o[:buffered]
      # TODO odswiezyc opis
      if @o[:monocolor]
        @rch = @rchb = @gch = @gchb = @bch = @bchb = []
      else
        @rch = @rchb = []
        @gch = @gchb = []
        @bch = @bchb = []
      end
        
      
      # ladowanie kolejnych wersow obrazka do tablic kanalow
      0.upto @orginal.rows-1 do |r|
        @rchb.push( @orginal.export_pixels(0, r, @orginal.columns, 1, "R" ) )
        @gchb.push( @orginal.export_pixels(0, r, @orginal.columns, 1, "G" ) )
        @bchb.push( @orginal.export_pixels(0, r, @orginal.columns, 1, "B" ) )
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

    #iteracja w znaczeniu powtarzania danego przeksztalcenie obrazka
    #nie chodzi o iteracje po wierszach i kolumnach w poszczegolnych przeksztalceniach; to dalej
    #do funkcji mozna przekazac parametry o, ktore uaktulania aktualny obiekt
    #tutaj tworzone i obslugiwane sa bufory jesli przeksztalcenie ich wymaga
    def iteruj(opts={}, &block)
      
      #dodatkowe parametry opcjonalne
      @o.merge!(opts)
      
      #jesli jest buforowanie utworzenie tablic oraz poczatkowe wyczarnienie obrazka przetwarzanego
      if @o[:buffered] == 1
        @rch = []
        @gch = []
        @bch = []
        #celowe kopiowanie calego zakresu bez obcinki topa i buttoma; ten obszar jest potrzebny do celow sasiedztwa
        @o[:top].upto @o[:rows]-1 do |r|
          @rch.push( Array.new(@o[:columns], @o[:background]) )
          @gch.push( Array.new(@o[:columns], @o[:background]) )
          @bch.push( Array.new(@o[:columns], @o[:background]) )
        end
      end
      
      @o[:iterable].call(block)
      
      #przetworzone tablice staja sie buforami dla kolejnych iteracji
      @rchb = @rch
      @gchb = @gch
      @bchb = @bch
      
      nil
    end


    #funkcja wywoluje blok przeksztalcenia dla kazdego z kanalow osobno lub robi to raz jesli operuje nad obrazkiem jednokanalowym
    def przetworz_kanaly(gen_r, gen_c, &block)
      if @o[:monocolor] == 1
        # kanaly rgb przetwarzania lub buforow wskazuja te same referencje dlatego wystarczy wywolac funkcje raz
        przejscie_rc(gen_r, gen_c) do |r, c|
          block.call(r, c, @rchb, @rch)
        end
      else
        przejscie_rc(gen_r, gen_c) do |r, c|
          block.call(r, c, @rchb, @rch)
          block.call(r, c, @gchb, @gch)
          block.call(r, c, @bchb, @bch)
        end
      end
    end
  
    
    #funkcja odpala przekazane generatory z blokiem zawierajacym wlasciwe przeksztalcenie
    #szczyt wywolan rdzenia
    #TODO dlaczego taka konstrukcja, domkniecia
    def przejscie_rc(gen_r, gen_c) 
      gen_r.call( lambda do |r|
        gen_c.call( lambda do |c|
          yield(r, c)
        end )
      end )
    end
    
end