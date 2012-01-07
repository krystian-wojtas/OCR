def grayscale1    
  iteruj :channels => :monocolor do |r, c|
    @vch[r][c] = (@rchb[r][c] + @gchb[r][c] + @bchb[r][c]) / 3
  end
  self
end
