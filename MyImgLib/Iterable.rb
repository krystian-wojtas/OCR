class Iterable
  
  @@c = {
    #TODO meta
    #TODO re-otwierajac klase mozna dodac nowe sposoby wywolan blokow; wtedy eval musi dorzuci sposoby do hasha
    :all => lambda { |p, callable| Iterable.all(p, callable) },
    :area => lambda { |p, callable, block| Iterable.area(p, callable, &block) },
    :edges => lambda { |p, callable, block| Iterable.edges(p, callable, &block) },
  }
  
  
  def Iterable.factory(sposob)
    @@c[sposob]
  end


  def Iterable.all(p, callable)
    callable.call(
      lambda {|block_r| p[:top].upto p[:rows]-p[:top]-p[:bottom]-1 do |r| block_r.call(r) end },
      lambda {|block_c| p[:left].upto p[:columns]-p[:left]-p[:right]-1 do |c| block_c.call(c) end }
    )
    nil
  end
  

  def Iterable.area(p, callable, &block)
    callable.call(
      lambda {|block_r| p[:top].upto p[:bottom]-1 do |r| block_r.call(r) end },
      lambda {|block_c| p[:left].upto p[:right]-1 do |c| block_c.call(c) end },
      &block
    )
    nil
  end


  def Iterable.edges(p, callable, &block)
    #pixele z rogow iterowane sa przez poziome przejscia
    Iterable.area( :top => 0, :bottom => p[:top]-1, :left => 0, :right => p[:columns]-1, &block) #gorna krawedz
    Iterable.area( :top => p[:rows]-p[:bottom]-1, :bottom => p[:rows]-1, :left => 0, :right => p[:columns]-1, &block) #dolna krawedz
    Iterable.area( :top => 1, :bottom => p[:rows]-2, :left => 0, :right => p[:left]-1, &block) #lewa krawedz
    Iterable.area( :top => 1, :bottom => p[:rows]-2, :left => p[:columns]-p[:right]-1, :right => p[:columns]-1, &block) #prawa krawedz
    nil
  end
  
end