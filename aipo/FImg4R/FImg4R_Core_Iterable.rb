class FImg4R_Core_Iterable
  #TODO extending local edges
  
  def initialize(o)
    @o = o
    
    @c = {
      #TODO meta
      #TODO re-otwierajac klase mozna dodac nowe sposoby wywolan blokow; wtedy eval musi dorzuci sposoby do hasha
      #TODO bez lambdy? &all
      :all => lambda { |callable| all callable },
      :area => lambda { |callable| area callable },
      :edges => lambda { |callable| edges callable },
      :local => lambda { |callable| local callable },
    }
  end
  
  
  
  def factory
    @c[ @o[:iterable] ]
  end


  def all(callable)
    callable.call(
      lambda {|block_r| @o[:top].upto @o[:rows]-@o[:top]-@o[:bottom]-1 do |r| block_r.call(r) end },
      lambda {|block_c| @o[:left].upto @o[:columns]-@o[:left]-@o[:right]-1 do |c| block_c.call(c) end }
    )
    nil
  end
  

  def area(callable)
    callable.call(
      lambda {|block_r| @o[:top].upto @o[:bottom]-1 do |r| block_r.call(r) end },
      lambda {|block_c| @o[:left].upto @o[:right]-1 do |c| block_c.call(c) end }
    )
    nil
  end


  def edges(callable)
    #TODO parametry najierw sie ustala w globalnym obiekcie, pozniej tyklo area
    #pixele z rogow iterowane sa przez poziome przejscia
    area( :top => 0, :bottom => @o[:top]-1, :left => 0, :right => @o[:columns]-1, &block) #gorna krawedz
    area( :top => @o[:rows]-@o[:bottom]-1, :bottom => @o[:rows]-1, :left => 0, :right => @o[:columns]-1, &block) #dolna krawedz
    area( :top => 1, :bottom => @o[:rows]-2, :left => 0, :right => @o[:left]-1, &block) #lewa krawedz
    area( :top => 1, :bottom => @o[:rows]-2, :left => @o[:columns]-@o[:right]-1, :right => @o[:columns]-1, &block) #prawa krawedz
  end
  
  
  def local(callable)
    @o[:top] = @o[:rows] / @o[:iter_loc_peaces] * @o[:iter_loc_j]
    @o[:bottom] = @o[:rows] / @o[:iter_loc_peaces] * (@o[:iter_loc_j]+1)
    @o[:left] = @o[:columns] / @o[:iter_loc_peaces] * @o[:iter_loc_i]
    @o[:right] = @o[:columns] / @o[:iter_loc_peaces] * (@o[:iter_loc_i]+1)
    if @o[:bottom] > @o[:rows] then @o[:bottom] = @o[:rows] end
    if @o[:right] > @o[:columns] then @o[:right] = @o[:columns] end
    area(callable)
  end
  
  
  def iterate
    # rzezba
    #funkcja odpala przekazane generatory z blokiem zawierajacym wlasciwe przeksztalcenie
    #szczyt wywolan rdzenia
    #TODO dlaczego taka konstrukcja, domkniecia
    #TODO factory rename
    factory.call(
      lambda do |gen_r, gen_c|
        gen_r.call( lambda do |r|
          gen_c.call( lambda do |c|
            yield(r, c)
          end )
        end )
      end
    )
  end
  
end