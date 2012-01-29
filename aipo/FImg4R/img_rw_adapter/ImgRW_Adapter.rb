class ImgRW_Adapter #TODO Delegate?
  
  attr_reader :qr
  @adapter = nil
  
  def initialize(*args)
    #creating adapter which depends of runtime environment
    if PLATFORM == 'java'
      require 'FImg4R/img_rw_adapter/ImgRW_Jruby'
      @adapter = ImgRW_Jruby.new()
    else
      require 'FImg4R/img_rw_adapter/ImgRW_RMagick'
      @adapter = ImgRW_RMagick.new()
    end
    
    #reading color channels from file or creating them empty
    unless args[1] #args[1] is nil, there isn't second parameter, so first parameter is a path to image file
      @adapter.read(args[0]) #args[0] - path
    else #args[1] is given, so given arguments are a pair of rows and columns for new empty image
      @adapter.create_empty(args[0], args[1]) #args[0] - rows, args[1] - columns 
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