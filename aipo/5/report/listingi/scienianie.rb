def scienianie

  #tablica buforowa dostaje dodatkowa obramowke grubosci 1pixela, domyslnie wypelniona zerami (zera sa w tym algorytmie bardzo odpowiednie wiec jest ok)
  #potrzebna ona jest dla nastepujacych przeksztalcen, gdzie uzywane sa wszyscy sasiedzi kazdego pixela
  #dzieki tej obramowce mozna iterowac rowniez krawedzie obrazu, bo one w ten sposob dostaly swoich sasiadow
  #jednak orginal nie posiada dodatkowych pikseli, wiec zeby nie wejsc w niezdefiniowany obszar robie tutaj marginesy
  trf_opts_atomic( {
      :channels => :monocolor,
      :buffered => true,
      :columns => @s.o[:columns]+2,
      :rows => @s.o[:rows]+2,
      :top => 1,
      :bottom => 1,
      :left => 1,
      :right => 1,
  }) do
    
    thresholding( Magick::QuantumRange / 2, 1, 0)
    
    # pattern of each matrix
    pattern = [ 
        [nil,0,nil],
        [nil,1,nil],
        [1,1,1],
    ]
    # m represents all matrixes
    m = []
    # filling m with concrete instances of pattern
    # nil must be replaced by values 0 or 1 in every possible combinations
    2.times do |x1|
      2.times do |x2|
        2.times do |x3|
          2.times do |x4|
            mi = Array.new(3) {|i| Array.new pattern[i]}
            mi[0][0] = x1
            mi[0][2] = x2
            mi[1][0] = x3
            mi[1][2] = x4
            m.push mi
          end
        end
      end
    end
    
    # m_rotates represents matrixes of m rotated by 90, 180 and 270 degrees
    m_rotates = []
    # filling m_rotates
    m.each do |mi|
      mii = mi
      3.times do
        mr = Array.new(3) { Array.new(3) }
        mr[1][1] = 1
        mr[0][2] = mii[0][0]
        mr[1][2] = mii[0][1]
        mr[2][2] = mii[0][2]
        mr[2][1] = mii[1][2]
        mr[2][0] = mii[2][2]
        mr[1][0] = mii[2][1]
        mr[0][0] = mii[2][0]
        mr[0][1] = mii[1][0]
        m_rotates.push mr
        mii = mr
      end
    end
    #adding rotates
    m += m_rotates 
    
    repeat = true
    it = 0
    while repeat and it < 100 do
      repeat = false
      iteruj do |r, c|
        if @vchb[r][c] == 1
          @vch[r][c] = 1
          m.each do |mi|
            if @vchb[r-1][c-1] == mi[0][0] and
              @vchb[r-1][c] == mi[0][1] and
              @vchb[r-1][c+1] == mi[0][2] and
              @vchb[r][c-1] == mi[1][0] and
              @vchb[r][c] == mi[1][1] and
              @vchb[r][c+1] == mi[1][2] and
              @vchb[r+1][c-1] == mi[2][0] and
              @vchb[r+1][c] == mi[2][1] and
              @vchb[r+1][c+1] == mi[2][2] then
                 @vch[r][c] = 0
                 repeat = true
            end
          end 
        end
      end
      it += 1
      #puts it.to_s
    end
    puts '-sc------------- ' + it.to_s
    thresholding( 0, Magick::QuantumRange, 0) #debinaryzacja
  end
  self
end
