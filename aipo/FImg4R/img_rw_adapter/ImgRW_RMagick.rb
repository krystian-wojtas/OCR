require 'RMagick'

class ImgRW_RMagick
  
  attr_accessor :rch, :gch, :bch
  attr_reader :qr
  
  def initialize()    
    @qr = Magick::QuantumRange
  end
  
  
  def read(path)
    img = Magick::ImageList.new(path)
    
    @rch = []
    @gch = []
    @bch = []
    
    0.upto img.rows-1 do |r|
      @rch.push( img.export_pixels(0, r, img.columns, 1, "R" ) )
      @gch.push( img.export_pixels(0, r, img.columns, 1, "G" ) )
      @bch.push( img.export_pixels(0, r, img.columns, 1, "B" ) )
    end    
  end
  
  
  def create_empty(rows, columns)
    p 'empty'
    @rch = Array.new(rows)
    @gch = Array.new(rows)
    @bch = Array.new(rows)
    
    0.upto rows-1 do |r|
      @rch[r] = Array.new(columns)
      @gch[r] = Array.new(columns)
      @bch[r] = Array.new(columns)
    end    
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