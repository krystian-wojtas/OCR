def histogram
  minr, maxr = ekstrema(@rch)
  ming, maxg = ekstrema(@gch)
  minb, maxb = ekstrema(@bch)
  iteruj :channels => :other do |r, c|
    @rch[r][c] = Tools.cut( Magick::QuantumRange * (@rch[r][c] - minr) / (maxr - minr) )
    @gch[r][c] = Tools.cut( Magick::QuantumRange * (@gch[r][c] - ming) / (maxg - ming) )
    @bch[r][c] = Tools.cut( Magick::QuantumRange * (@bch[r][c] - minb) / (maxb - minb) )
  end   
  self
end
