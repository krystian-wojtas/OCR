#require 'rubygems'
#gem PLATFORM == 'java' ? 'rmagick4j' : 'rmagick'
require 'RMagick'
require 'Iterable'
require 'core/Settings'

class FImg4RR
  

  def initialize(orginal)
    #obiekt RMagick reprezentuje obraz poddawany obrobce
    @orginal = orginal
    
    #opcje przeksztalcenia
    # first transform resets all options to defaults
    @s = Settings.new( @orginal.rows, @orginal.columns )
    
    # tablice kanalow barw orginalu oraz obrazka przetwarzanego
    # tutaj referencje na tablice buforow i przetwarzan sa te same, dzieki temu domyslnie nie buforuje
    # nowe tablice dla buforow tworzone sa w metodzie iteruj jesli wybrano opcje @s.o[:buffered]
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
  

  #na koniec zwracany jest nowy obiekt biblioteki RMagick Magick::Image z wykonanymi przeksztalceniami
  def write(file_name)

    #przepisanie wynikow do nowego obrazka
    mod = Magick::Image.new( @s.o[:columns], @s.o[:rows] )
    (@s.o[:rows]-@s.o[:bottom]-1).downto @s.o[:top] do |r|
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
    #def edit(opts={})
  
  
    def trf_opts_atomic(opts)
      @s.make_defaults(opts)
      @s.lock_defaults()
      yield
      @s.unlock_defaults()
    end


    #iteracja w znaczeniu powtarzania danego przeksztalcenie obrazka
    #nie chodzi o iteracje po wierszach i kolumnach w poszczegolnych przeksztalceniach; to dalej
    #tutaj tworzone i obslugiwane sa bufory jesli przeksztalcenie ich wymaga
    #do funkcji mozna przekazac parametry o, ktore uaktulania aktualny obiekt
    def iteruj(opts={}, &block)
      
      #dodatkowe parametry opcjonalne nakladane na domyslne
      @s.make_defaults(opts)
      
      #jesli jest buforowanie utworzenie tablic i wypelnienie ich tlem
      # TODO == true
      if @s.o[:buffered]
        @rch = []
        @gch = []
        @bch = []
        #celowe kopiowanie calego zakresu bez obcinki topa i buttoma; ten obszar jest potrzebny do celow sasiedztwa
        @s.o[:top].upto @s.o[:rows]-1 do |r| #TODO bez |r|
          @rch.push( Array.new(@s.o[:columns], @s.o[:background]) )
          @gch.push( Array.new(@s.o[:columns], @s.o[:background]) )
          @bch.push( Array.new(@s.o[:columns], @s.o[:background]) )
        end
      end
      
      #przetwarzanie po kolejnych kanalach
      process_channels &block
      
      #przetworzone tablice staja sie buforami dla kolejnych iteracji
      @rchb = @rch
      @gchb = @gch
      @bchb = @bch
      
      nil
    end


    def process_channels &block
              
      case @s.o[:channels]
      when :monocolor
        # jesli wczytywany obrazek ma lustrzane wartosci w kanalach kolorow i przeksztalcenie rowniez propaguje wyliczona wartosc na wszystkie kanaly
        # wtedy nalezy zaznaczyc monocolor i przeksztalcenie wykona sie raz na kanale czerwonym, a pozostale kanaly sie propaguja poprzez wspolna referencje 
        # kanaly rgb przetwarzania wskazuja te same referencje dlatego wystarczy wywolac funkcje raz, a wszystkie kanaly dostana ta sama wartosc
        @rch = @gch = @bch
        process @rch, @rchb, &block
      when :rgb
        # te same operacje dla wszystkich kanalow
        process @rch, @rchb, &block
        process @gch, @gchb, &block
        process @bch, @bchb, &block
      when :r
        process @rch, @rchb, &block
      when :g
        process @gch, @gchb, &block
      when :b
        process @bch, @bchb, &block
      when :other
        # funkcja bedzie operowac na dostepnych jej zmiennych obiektowych @rch, @gch, @bch oraz na buforach jesli wlaczy
        process nil, nil, &block
      end
      
    end
    
    
    def process(vch, vchb, &block)
      
      #przetwarzany kanal
      @vch, @vchb = vch, vchb
       
      # lokalny hash 'o' tworzony jest na bazie pelnego hasha opcji @s.o
      # zawiera tylko niezbedne parametry potrzebne celom iteracji
      # sa to :iterable, :iterableOpts, :rows, :columns, :top, :bottom, :left, :right
      #
      # Ruby 1.8.7 i 1.9.1 roznia sie zwracanymi wartosciami z metody select klasy Hash
      # Do selecta mozna przekazac blok z argumentami klucz i wartosc
      # Select wywola blok dla wszystkich par klucz-wartosc jaka hash zawiera
      # Jesli blok zwraca prawde, para klucz-wartosc kopiowana jest do nowego wyniku
      # Roznica pomiedzy wersjami jest zwracany wynik: 1.9.1 zwroci nowy Hash; 1.8.7 zwroci tablice par
      # 1.9.1:
      o = @s.o.select {|k, v| [:iterable, :iterableOpts, :rows, :columns, :top, :bottom, :left, :right].include?(k) }
      # 1.8.7:
      o = {}
      @s.o.select {|k, v| [:iterable, :iterableOpts, :rows, :columns, :top, :bottom, :left, :right].include?(k) }.collect {|k, v| o[k]=v }
      
      Iterable.new(o).iterate(&block)
      
      nil 
    end

end
