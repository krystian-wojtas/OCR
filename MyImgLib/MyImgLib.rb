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
        :buffered => 0,
        #sposob iteracji kolumn i wierszy; domyslnie wyiteruje caly obrazek bez marginesow
        :iterable => iterable(:calosc),
      }.merge(opts)

      # tablice kanalow barw orginalu oraz obrazka przetwarzanego
      # tutaj referencje na tablice buforow i przetwarzan sa te same, dzieki temu domyslnie nie buforuje
      # nowe tablice dla buforow tworzone sa w metodzie iteruj jesli wybrano opcje @o[:buffered]
      @rch = @rchb = []
      @gch = @gchb = []
      @bch = @bchb = []
        
      
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

    
    def iteruj(opts={}, &block) #TODO nazwa
      
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
  
  
    def arr(gen_r, gen_c, &block)    #TODO nazwa  
      case block.arity
      when 3
        #TODO wolalbym konstrukcje 
        #gen_r.call do |r|
        #  gen_c.call do |c|
        #sprawdzic czy na pewno sie nie da jej uzyc    
        gen_r.call( lambda do |r|
          gen_c.call( lambda do |c|
            unless (res = block.call(r, c, @rchb)).nil?() then @rch[r][c] = res end
            unless (res = block.call(r, c, @gchb)).nil?() then @gch[r][c] = res end
            unless (res = block.call(r, c, @bchb)).nil?() then @bch[r][c] = res end
          end )
        end )
      when 5
        gen_r.call( lambda do |r|
          gen_c.call( lambda do |c|
            #sprawdzenie zwracanego typu. Jesli jedna wartosc to przepisz ja na wszystkie kanaly. Jesli tablica 3 wartosci: kolejne kanaly
            res = block.call(r, c, @rchb, @gchb, @bchb)
            if res.kind_of?(Array) #niew wstawiac: and res.length == 3; nil? i tak zabezpiecza a moze chodciaz pierwsze wartosci sie zapisza
              @rch[r][c] = res[0] unless res[0].nil?()
              @gch[r][c] = res[1] unless res[1].nil?()
              @bch[r][c] = res[2] unless res[2].nil?()
            else
              @rch[r][c] = @gch[r][c] = @bch[r][c] = res unless res.nil?()
            end
          end )
        end )
      end      
      nil
    end
  
end