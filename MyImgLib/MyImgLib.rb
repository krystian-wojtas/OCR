require 'RMagick'

class MyImgLib

  def initialize(orginal)
    @orginal = orginal
  end


  protected
  
    def default_opts(opts={})
      {
        :top => 0,
        :bottom => 0,
        :left => 0,
        :right => 0,
        :scale => 1,
        :columns => @orginal.columns,
        :rows => @orginal.rows
      }.merge(opts)
    end

    def edit(opts={}, &block)
      # parametry opcjonalne
      o = {
        :top => 0,
        :bottom => 0,
        :left => 0,
        :right => 0,
        :scale => 1,
        :columns => @orginal.columns,
        :rows => @orginal.rows
      }.merge(opts)

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
      o[:top].upto o[:rows]-o[:bottom]-1 do |r| #TODO odjalem jedynke, gdzies byla potrzebna do dodania, przesledzic
        rch.push( Array.new(o[:columns], 0) )
        gch.push( Array.new(o[:columns], 0) )
        bch.push( Array.new(o[:columns], 0) )
      end

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

      #przepisanie wynikow do nowego obrazka
      mod = Magick::Image.new( o[:columns], o[:rows] )
      (o[:rows]-o[:bottom]-1).downto o[:top] do |r|
        mod.import_pixels(0, r, mod.columns, 1, "R", rch.pop)
        mod.import_pixels(0, r, mod.columns, 1, "G", gch.pop)
        mod.import_pixels(0, r, mod.columns, 1, "B", bch.pop)
      end
      mod
    end


    def cut(c)
      (c > Magick::QuantumRange) ? Magick::QuantumRange : ( (c < 0) ? 0 : c )
    end
end