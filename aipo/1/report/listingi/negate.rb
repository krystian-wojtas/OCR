def negate    
  iteruj do |r, c|
    @vch[r][c] = cut( @img_rw.qr() - @vchb[r][c] )  
  end
  self
end
