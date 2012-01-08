def median_filter_matrix(s)
  iteruj :top => s/2, :bottom => s/2, :left => s/2, :right => s/2 do |r, c|
    neighberhood = []
    (-(s/2)).upto s/2 do |i|
      (-(s/2)).upto s/2 do |j|
        neighberhood.push @vchb[r+i][c+j]
      end
    end
    neighberhood.sort!      
    yield(neighberhood, r, c)
  end
end
