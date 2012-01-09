def roberts_cross
  iteruj :bottom => 1, :right => 1 do |r, c|
    @vch[r][c] = cut( (@vchb[r][c] - @vchb[r+1][c+1]).abs + (@vchb[r][c+1] - @vchb[r+1][c]).abs )
  end
  self
end
