def contrast(w) 
  iteruj do |r, c|
    @vch[r][c] = cut( (@vchb[r][c] * w).to_i )
  end
  self
end
