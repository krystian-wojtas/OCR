#require 'rubygems'
#gem PLATFORM == 'java' ? 'rmagick4j' : 'rmagick'
require 'FImg4R_Core_Iterable'
require 'FImg4R_Core_Settings'
require 'FImg4R/img_rw_adapter/ImgRW_Adapter'

class FImg4R
  
  attr_reader :qr

  def initialize(path)
    
    @img_rw = ImgRW_Adapter.new(path)
    @qr = @img_rw.qr() #TODO rename @QR
    
    #opcje przeksztalcenia
    # first transform resets all options to defaults
    @s = FImg4R_Core_Settings.new( @img_rw.rows, @img_rw.columns )
    
    # tablice kanalow barw orginalu oraz obrazka przetwarzanego
    # tutaj referencje na tablice buforow i przetwarzan sa te same, dzieki temu domyslnie nie buforuje
    # nowe tablice dla buforow tworzone sa w metodzie iteruj jesli wybrano opcje @s.o[:buffered]
    @rch = @rchb = @img_rw.rch
    @gch = @gchb = @img_rw.gch
    @bch = @bchb = @img_rw.bch
  end
  

  #na koniec zwracany jest nowy obiekt biblioteki RMagick Magick::Image z wykonanymi przeksztalceniami
  def write(path)
    @img_rw.rch = @rch
    @img_rw.gch = @gch
    @img_rw.bch = @bch
    @img_rw.write(path)
  end


  
  #edit zajmuje sie przepisaniem wartosci kanalow obrazka z obiektu Image biblioteki RMagick na czyste tablice Rubiego
  #poslugiwanie sie tablicami jest szybsze, metoda putpixel sprawdza zakresy obszaru obrazka oraz zakres koloru; nie zawsze sprawdzenia sa konieczne TODO sprawdzic
  #oraz czyste tablice wygladaja w kodzie zwiezlej niz uzywanie pixel_color
  #na koniec zwracany jest nowy obiekt biblioteki RMagick Magick::Image z wykonanymi przeksztalceniami
  #def edit(opts={})


  def trf_opts_atomic(opts={}) #refactor lock_settings?
    @s.make_defaults(opts)
    @s.lock_defaults()
    yield
    @s.unlock_defaults()
  end
    
    
  #iteracja w znaczeniu powtarzania danego przeksztalcenie obrazka
  #nie chodzi o iteracje po wierszach i kolumnach w poszczegolnych przeksztalceniach; to dalej
  #tutaj tworzone i obslugiwane sa bufory jesli przeksztalcenie ich wymaga
  #do funkcji mozna przekazac parametry o, ktore uaktulania aktualny obiekt
  def iteruj(opts={}, &block) # TODO rename iterate

    #dodatkowe parametry opcjonalne nakladane na domyslne
    @s.make_defaults(opts)    
    process_channels &block
    nil
  end


  def process_channels &block
            
    case @s.o[:channels]
    when :monocolor
      # jesli wczytywany obrazek ma lustrzane wartosci w kanalach kolorow i przeksztalcenie rowniez propaguje wyliczona wartosc na wszystkie kanaly
      # wtedy nalezy zaznaczyc monocolor i przeksztalcenie wykona sie raz na kanale czerwonym, a pozostale kanaly sie propaguja poprzez wspolna referencje 
      # kanaly rgb przetwarzania wskazuja te same referencje dlatego wystarczy wywolac funkcje raz, a wszystkie kanaly dostana ta sama wartosc
      @rch = buffer @rch, &block
      @gch = @bch = @rch
    when :rgb
      # te same operacje dla wszystkich kanalow
      @rch = buffer @rch, &block
      @gch = buffer @gch, &block
      @bch = buffer @bch, &block
    when :r
      @rch = buffer @rch, &block
    when :g
      @gch = buffer @gch, &block
    when :b
      @bch = buffer @bch, &block
    when :other
      # funkcja bedzie operowac na dostepnych jej zmiennych obiektowych @rch, @gch, @bch oraz na buforach jesli wlaczy
      buffer &block
    end
  end
  
  
  
  def buffer(vchb=nil, &block)
    
    #przetwarzany kanal
    @vchb = vchb
    
    #jesli jest buforowanie utworzenie tablic i wypelnienie ich tlem
    if @s.o[:buffered]
      @vch = Array.new(@s.o[:rows])
      0.upto @s.o[:rows]-1 do |r|
        @vch[r] = Array.new(@s.o[:columns], @s.o[:background])
      end
    else
      @vch = @vchb
    end
    
    count_pxs &block
    
    @vch    
  end
  
  
  def count_pxs(&block)     
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
    #Iterable.new(o).iterate(&block)
    #TODO del calosc wyzej albo dopisac lokalne opcje iteracji
      
    FImg4R_Core_Iterable.new(@s.o).iterate(&block)
  end
  
    
  def inspect
    "Ruby is "
  end
  
  def to_s
    "Java is "
  end

end
