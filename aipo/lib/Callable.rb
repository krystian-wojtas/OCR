class Callable
  

  @@c = {
    #TODO meta
    #TODO re-otwierajac klase mozna dodac nowe sposoby wywolan blokow; wtedy eval musi dorzuci sposoby do hasha
    :rgb => lambda { |gen_r, gen_c, chs, block| Callable.rgb(gen_r, gen_c, chs, &block) },
    :monocolor => lambda { |gen_r, gen_c, chs, block| Callable.monocolor(gen_r, gen_c, chs, &block) },
    :other => lambda { |gen_r, gen_c, chs, block| Callable.other(gen_r, gen_c, chs, &block) },
  }
  
  
  def Callable.factory(sposob)
    @@c[sposob]
  end


  # kanaly przetwarzane osobno tym samym przeksztalceniem
  def Callable.rgb(gen_r, gen_c, chs, &block)
    Callable.przejscie_rc(gen_r, gen_c) do |r, c|
      block.call(r, c, chs[:rch], chs[:rchb])
      block.call(r, c, chs[:gch], chs[:gchb])
      block.call(r, c, chs[:bch], chs[:bchb])
    end
  end


  # kanaly rgb przetwarzania wskazuja te same referencje dlatego wystarczy wywolac funkcje raz, a wszystkie kanaly dostana ta sama wartosc
  def Callable.monocolor(gen_r, gen_c, chs, &block)
    chs[:gch] = chs[:bch] = chs[:rch]
    przejscie_rc(gen_r, gen_c) do |r, c|
      block.call(r, c, chs[:rch], chs[:rchb])
    end
  end
  
  
  # inny rodzaj przetwarzania; podane sa tylko kolejne r i c, funkcja bedzie operowac na dostepnych jej zmiennych obiektowych @rch, @gch, @bch oraz na buforach jesli wlaczy
  def Callable.other(gen_r, gen_c, chs, &block)
    przejscie_rc(gen_r, gen_c) do |r, c|
      block.call(r, c)
    end
  end


  #funkcja odpala przekazane generatory z blokiem zawierajacym wlasciwe przeksztalcenie
  #szczyt wywolan rdzenia
  #TODO dlaczego taka konstrukcja, domkniecia
  def Callable.przejscie_rc(gen_r, gen_c) 
    gen_r.call( lambda do |r|
      gen_c.call( lambda do |c|
        yield(r, c)
      end )
    end )
  end

end