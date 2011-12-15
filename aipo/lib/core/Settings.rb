class Settings
  
  def initialize(rows, columns)
    @lock_defaults = false
    @o = {}
    make_defaults( :rows => rows, :columns => columns )
  end  
  
  
  def make_defaults(opts={})

    unless @lock_defaults
      # opcje rdzenia do wykonywanych przeksztalcen
      # parametry opcjonalne nalozone na domyslne
      @o.merge!( {
        #sposob iteracji kolumn i wierszy; domyslnie wyiteruje caly obrazek bez marginesow
        :iterable => :all,
        :iterableOpts => {},
        #sposob wywolywania transformacji i przekazywania argumentow; domyslnie wykona przeksztalcenie dla kazdego kanalu z osobna
        :channels => :rgb,
        #marginesy
        :top => 0,
        :bottom => 0,
        :left => 0,
        :right => 0,
        #ustawienia buforow
        :buffered => false,
        :background => 0, #kolor tla dla buforow
      } ).merge!(opts)
    end
    @o
  end
  
  
  def lock_defaults
    @lock_defaults = true
  end
  
  def unlock_defaults
    @lock_defaults = false
  end
  
  
  # it is working without any locking conditions
  def update(opts)
    @o.merge!(opts)
  end
  
  
  def o
    @o 
  end
  
end