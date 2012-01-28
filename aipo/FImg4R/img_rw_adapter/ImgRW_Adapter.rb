class ImgRW_Adapter #TODO Delegate?
  
  attr_reader :qr
  @adapter = nil
  
  def initialize(path=nil)
    if PLATFORM == 'java'
      require 'FImg4R/img_rw_adapter/ImgRW_Jruby'
      @adapter = ImgRW_Jruby.new(path)
    else
      require 'FImg4R/img_rw_adapter/ImgRW_RMagick'
      @adapter = ImgRW_RMagick.new(path)
    end
    
    @qr = @adapter.qr
  end
  
  def rows
    @adapter.rows
  end
  
  def columns
    @adapter.columns
  end
  
  def rch
    @adapter.rch
  end
  
  def gch
    @adapter.gch
  end
  
  def bch
    @adapter.bch
  end
  
  def rch=(ch)
    @adapter.rch = ch
  end
  
  def gch=(ch)
    @adapter.gch = ch
  end
  
  def bch=(ch)
    @adapter.bch = ch
  end
  
  def write(path)
    @adapter.write(path)
  end
  
end