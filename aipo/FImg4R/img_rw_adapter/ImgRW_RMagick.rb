require 'RMagick'

class ImgRW_RMagick
  
  attr_accessor :rch, :gch, :bch
  attr_reader :qr
  
  def initialize(path)
    #obiekt RMagick reprezentuje obraz poddawany obrobce
    img = Magick::ImageList.new(path)
    
    # tablice kanalow barw imgu oraz obrazka przetwarzanego
    # tutaj referencje na tablice buforow i przetwarzan sa te same, dzieki temu domyslnie nie buforuje
    # nowe tablice dla buforow tworzone sa w metodzie iteruj jesli wybrano opcje @s.o[:buffered]
    @rch = []
    @gch = []
    @bch = []
    
    # ladowanie kolejnych wersow obrazka do tablic kanalow
    0.upto img.rows-1 do |r|
      @rch.push( img.export_pixels(0, r, img.columns, 1, "R" ) )
      @gch.push( img.export_pixels(0, r, img.columns, 1, "G" ) )
      @bch.push( img.export_pixels(0, r, img.columns, 1, "B" ) )
    end
    
    @qr = Magick::QuantumRange
  end
  

  #na koniec zwracany jest nowy obiekt biblioteki RMagick Magick::Image z wykonanymi przeksztalceniami
  def write(path)

    #przepisanie wynikow do nowego obrazka
    mod = Magick::Image.new( columns(), rows() )
    (@rch.size-1).downto 0 do |r|
      mod.import_pixels(0, r, mod.columns, 1, "R", @rch[r])
      mod.import_pixels(0, r, mod.columns, 1, "G", @gch[r])
      mod.import_pixels(0, r, mod.columns, 1, "B", @bch[r])
    end
    
    #write to file
    mod.write(path)
  end

  
  def rows
    @rch.size
  end
  
  def columns
    @rch[0].size
  end
  
end