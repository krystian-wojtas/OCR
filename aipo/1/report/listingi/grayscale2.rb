def grayscale2 
  iteruj :channels => :monocolor do |r, c|
    @vch[r][c] = (0.3*@rchb[r][c] + 0.59*@gchb[r][c] + 0.11*@bchb[r][c]).to_i
  end
  self
end
