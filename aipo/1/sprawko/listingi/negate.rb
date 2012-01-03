def negate    
  iteruj do |r, c|
    @vch[r][c] = Tools.cut( Magick::QuantumRange - @vchb[r][c] )  
  end
  self
end
