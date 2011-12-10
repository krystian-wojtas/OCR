#require 'rubygems'
#gem PLATFORM == 'java' ? 'rmagick4j' : 'rmagick'
require 'RMagick'
require 'Callable'
require 'Iterable'

class FImg4RR
  
  
  def make_opts(opts)

    # opcje rdzenia do wykonywanych przeksztalcen
    # parametry opcjonalne nalozone na domyslne
    @o.merge!( {
      #sposob iteracji kolumn i wierszy; domyslnie wyiteruje caly obrazek bez marginesow
      :iterable => :all,
      #sposob wywolywania transformacji i przekazywania argumentow; domyslnie wykona przeksztalcenie dla kazdego kanalu z osobna
      :callable => :rgb,
      #marginesy
      :top => 0,
      :bottom => 0,
      :left => 0,
      :right => 0,
      #ustawienia buforow
      :buffered => 0,
      :columns => @orginal.columns,
      :rows => @orginal.rows,
      :background => 0, #kolor tla dla buforow
    } ).merge!(opts)
    
  end
  

  def initialize(orginal)
    #obiekt RMagick reprezentuje obraz poddawany obrobce
    @orginal = orginal
    
    #opcje przeksztalcenia
    @o = {}
    
    # tablice kanalow barw orginalu oraz obrazka przetwarzanego
    # tutaj referencje na tablice buforow i przetwarzan sa te same, dzieki temu domyslnie nie buforuje
    # nowe tablice dla buforow tworzone sa w metodzie iteruj jesli wybrano opcje @o[:buffered]
    @rch = @rchb = []
    @gch = @gchb = []
    @bch = @bchb = []
    # kanaly wirtualne, aktualnie przetwarzany kanal, referencje na powyzsze
    @vch, @vchb = nil, nil  
    
    # ladowanie kolejnych wersow obrazka do tablic kanalow
    0.upto @orginal.rows-1 do |r|
      @rchb.push( @orginal.export_pixels(0, r, @orginal.columns, 1, "R" ) )
      @gchb.push( @orginal.export_pixels(0, r, @orginal.columns, 1, "G" ) )
      @bchb.push( @orginal.export_pixels(0, r, @orginal.columns, 1, "B" ) )
    end
  end
  
  
  def write(file_name)

    #przepisanie wynikow do nowego obrazka
    mod = Magick::Image.new( @o[:columns], @o[:rows] )
    (@o[:rows]-@o[:bottom]-1).downto @o[:top] do |r|
      #nie mozna popowac chaneli; w przypadku :monocolor kanal czerwony zrzucilby rowniez pozosatale kanaly jako ze mialyby ta sama referencje TODO del
      mod.import_pixels(0, r, mod.columns, 1, "R", @rch[r])
      mod.import_pixels(0, r, mod.columns, 1, "G", @gch[r])
      mod.import_pixels(0, r, mod.columns, 1, "B", @bch[r])
    end
    
    #zapis
    mod.write(file_name)
  end


  protected
  
    #edit zajmuje sie przepisaniem wartosci kanalow obrazka z obiektu Image biblioteki RMagick na czyste tablice Rubiego
    #poslugiwanie sie tablicami jest szybsze, metoda putpixel sprawdza zakresy obszaru obrazka oraz zakres koloru; nie zawsze sprawdzenia sa konieczne TODO sprawdzic
    #oraz czyste tablice wygladaja w kodzie zwiezlej niz uzywanie pixel_color
    #na koniec zwracany jest nowy obiekt biblioteki RMagick Magick::Image z wykonanymi przeksztalceniami
    def edit(opts={})

      #przeksztalcenia
      yield
    end    


    #iteracja w znaczeniu powtarzania danego przeksztalcenie obrazka
    #nie chodzi o iteracje po wierszach i kolumnach w poszczegolnych przeksztalceniach; to dalej
    #tutaj tworzone i obslugiwane sa bufory jesli przeksztalcenie ich wymaga
    #do funkcji mozna przekazac parametry o, ktore uaktulania aktualny obiekt
    def iteruj(opts={}, &block)
      
      #dodatkowe parametry opcjonalne nakladane na domyslne
      make_opts(opts)
      
      #jesli jest buforowanie utworzenie tablic i wypelnienie ich tlem
      if @o[:buffered] == 1
        @rch = []
        @gch = []
        @bch = []
        #celowe kopiowanie calego zakresu bez obcinki topa i buttoma; ten obszar jest potrzebny do celow sasiedztwa
        @o[:top].upto @o[:rows]-1 do |r| #TODO bez |r|
          @rch.push( Array.new(@o[:columns], @o[:background]) )
          @gch.push( Array.new(@o[:columns], @o[:background]) )
          @bch.push( Array.new(@o[:columns], @o[:background]) )
        end
      end
      
      #przetwarzanie po kolejnych kanalach
      przetwarzaj_kanaly &block
      
      #przetworzone tablice staja sie buforami dla kolejnych iteracji
      @rchb = @rch
      @gchb = @gch
      @bchb = @bch
      
      nil
    end


    def przetwarzaj_kanaly(&block)
              
      case @o[:callable]          
      when :monocolor
        # jesli wczytywany obrazek ma lustrzane wartosci w kanalach kolorow i przeksztalcenie rowniez propaguje wyliczona wartosc na wszystkie kanaly
        # wtedy nalezy zaznaczyc monocolor i przeksztalcenie wykona sie raz na kanale czerwonym, a pozostale kanaly sie propaguja poprzez wspolna referencje 
        # kanaly rgb przetwarzania wskazuja te same referencje dlatego wystarczy wywolac funkcje raz, a wszystkie kanaly dostana ta sama wartosc
        @rch = @gch = @bch
        przetwarzaj_kanal @rch, @rchb, &block
      when :rgb
        # te same operacje dla wszystkich kanalow
        przetwarzaj_kanal @rch, @rchb, &block
        przetwarzaj_kanal @gch, @gchb, &block
        przetwarzaj_kanal @bch, @bchb, &block
      when :r
        przetwarzaj_kanal @rch, @rchb, &block
      when :g
        przetwarzaj_kanal @gch, @gchb, &block
      when :b
        przetwarzaj_kanal @bch, @bchb, &block
      when :other
        # funkcja bedzie operowac na dostepnych jej zmiennych obiektowych @rch, @gch, @bch oraz na buforach jesli wlaczy
        przetwarzaj_kanal @vch, @vchb, &block
      end
      
    end
    
    
    def przetwarzaj_kanal(vch, vchb, &block)
      @vch, @vchb = vch, vchb
      przetwarzaj &block
    end
    
    
    def przetwarzaj(&block)
       
      # lokalny hash 'o' tworzony jest na bazie pelnego hasha opcji @o
      # zawiera tylko niezbedne parametry potrzebne celom iteracji
      # sa to :rows, :columns, :top, :bottom, :left, :right
      #
      # Ruby 1.8.7 i 1.9.1 roznia sie zwracanymi wartosciami z metody select klasy Hash
      # Do selecta mozna przekazac blok z argumentami klucz i wartosc
      # Select wywola blok dla wszystkich par klucz-wartosc jaka hash zawiera
      # Jesli blok zwraca prawde, para klucz-wartosc kopiowana jest do nowego wyniku
      # Roznica pomiedzy wersjami jest zwracany wynik: 1.9.1 zwroci nowy Hash; 1.8.7 zwroci tablice par
      # 1.9.1:
      o = @o.select {|k, v| [:rows, :columns, :top, :bottom, :left, :right].include?(k) }
      # 1.8.7:
      o = {}
      @o.select {|k, v| [:rows, :columns, :top, :bottom, :left, :right].include?(k) }.collect {|k, v| o[k]=v }
      
      # rzezba
      #funkcja odpala przekazane generatory z blokiem zawierajacym wlasciwe przeksztalcenie
      #szczyt wywolan rdzenia
      #TODO dlaczego taka konstrukcja, domkniecia
      Iterable.factory( @o[:iterable] ).call( o,
        #TODO rzezba w iterable; przekazywanie blocku i opcji tylko
        lambda {|gen_r, gen_c|
          gen_r.call( lambda do |r|
            gen_c.call( lambda do |c|
              yield(r, c)
            end )
          end )
        }
      )
      
    end

end
