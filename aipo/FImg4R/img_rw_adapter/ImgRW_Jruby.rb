class ImgRW_Jruby  
  include Java 
  
  attr_accessor :rch, :gch, :bch
  attr_reader :qr
  
  def initialize(path)
    #obiekt reprezentuje obraz poddawany obrobce
    file = java.io.File.new(path)
    img = javax.imageio.ImageIO.read(file)
    
    #
    @type = img.getType()
    
    # tablice kanalow barw orginalu oraz obrazka przetwarzanego
    # tutaj referencje na tablice buforow i przetwarzan sa te same, dzieki temu domyslnie nie buforuje
    # nowe tablice dla buforow tworzone sa w metodzie iteruj jesli wybrano opcje @s.o[:buffered]
    @rch = Array.new(img.getHeight())
    @gch = Array.new(img.getHeight())
    @bch = Array.new(img.getHeight())
    
    # ladowanie kolejnych wersow obrazka do tablic kanalow
    0.upto img.getHeight()-1 do |r|
      @rch[r] = Array.new(img.getWidth())
      @gch[r] = Array.new(img.getWidth())
      @bch[r] = Array.new(img.getWidth())
      0.upto img.getWidth()-1 do |c|
        px = img.getRGB(c, r)
        @rch[r][c] = ((px << 8) >> 24) & 0xff
        @gch[r][c] = ((px << 16) >> 24) & 0xff
        @bch[r][c] = ((px << 24) >> 24) & 0xff
      end
    end
    
    @qr = 255
  end
  

  #na koniec zwracany jest nowy obiekt biblioteki RMagick Magick::Image z wykonanymi przeksztalceniami
  def write(path)

    #przepisanie wynikow do nowego obrazka
    img = java.awt.image.BufferedImage.new(columns(), rows(), @type)
    0.upto rows()-1 do |r|
      0.upto columns()-1 do |c|
        px = (((@rch[r][c] << 8) | @gch[r][c]) << 8) | @bch[r][c]
        img.setRGB(c, r, px)
      end
    end
    
    #write to file
    file = java.io.File.new(path)
    javax.imageio.ImageIO.write(img, "jpeg", file)
  end
  

  def rows
    @rch.size
  end
  
  def columns
    @rch[0].size
  end
  
end