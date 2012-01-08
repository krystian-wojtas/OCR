def average_filter(s)
  iteruj :top => s/2, :bottom => s/2, :left => s/2, :right => s/2 do |r, c|
    neighberhood_addition = 0
    (-(s/2)).upto s/2 do |i|
      (-(s/2)).upto s/2 do |j|
        neighberhood_addition += @vchb[r+i][c+j]
      end
    end
    @vch[r][c] = neighberhood_addition / s / s
  end
  self
end
