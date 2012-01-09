def brightness(w)
  w = (w * @QR).to_i
  iteruj do |r, c|
    @vch[r][c] = cut( @vchb[r][c] + w )
  end
  self
end
