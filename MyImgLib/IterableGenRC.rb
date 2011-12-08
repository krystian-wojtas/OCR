module IterableGenRC
  
  def iterable(sposob)
    {
      :calosc => lambda { |block| iteruj_calosc(&block) },
      :obszar => lambda { |block| iteruj_obszar(&block) },
      :krawedzie => lambda { |block| iteruj_krawedzie(&block) },
    }[sposob]
  end

#TODO private? i fabryka? wtedy implementowac jako osobna klasa z parametryzowanymi zakresami?

  def iteruj_obszar(r1, r2, c1, c2, &block)
    przetworz_kanaly(
      lambda {|block_r| r1.upto r2-1 do |r| block_r.call(r) end },
      lambda {|block_c| c1.upto c2-1 do |c| block_c.call(c) end },
      &block
    )
    nil
  end
  
  
  def iteruj_krawedzie(&block)
    #pixele z rogow iterowane sa przez poziome przejscia
    iteruj_obszar( 0, @o[:top]-1, 0, @o[:columns]-1, &block) #gorna krawedz
    iteruj_obszar( @o[:rows]-@o[:bottom]-1, @o[:rows]-1, 0, @o[:columns]-1, &block) #dolna krawedz
    iteruj_obszar( 1, @o[:rows]-2, 0, @o[:left]-1, &block) #lewa krawedz
    iteruj_obszar( 1, @o[:rows]-2, @o[:columns]-@o[:right]-1, @o[:columns]-1, &block) #prawa krawedz
    nil
  end

  def iteruj_calosc(&block)
    przetworz_kanaly(
      lambda {|block_r| @o[:top].upto @o[:rows]-@o[:top]-@o[:bottom]-1 do |r| block_r.call(r) end },
      lambda {|block_c| @o[:left].upto @o[:columns]-@o[:left]-@o[:right]-1 do |c| block_c.call(c) end },
      &block
    )
    nil
  end

  def iteruj_calosc2(&block)
    @o[:collable].call(
      lambda {|block_r| @o[:top].upto @o[:rows]-@o[:top]-@o[:bottom]-1 do |r| block_r.call(r) end },
      lambda {|block_c| @o[:left].upto @o[:columns]-@o[:left]-@o[:right]-1 do |c| block_c.call(c) end },
      &block
    )
    nil
  end
  
end
