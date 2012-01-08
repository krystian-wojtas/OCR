def brightness(w) 
  iteruj do |r, c|
    @vch[r][c] = Tools.cut( @vchb[r][c] + w )
  end
  self
end
