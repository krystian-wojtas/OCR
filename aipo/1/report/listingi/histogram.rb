def histogram
  minr, maxr = extrems(@rch)
  ming, maxg = extrems(@gch)
  minb, maxb = extrems(@bch)
  iteruj :channels => :other do |r, c|
    @rch[r][c] = cut( @img_rw.qr() * (@rch[r][c] - minr) / (maxr - minr) )
    @gch[r][c] = cut( @img_rw.qr() * (@gch[r][c] - ming) / (maxg - ming) )
    @bch[r][c] = cut( @img_rw.qr() * (@bch[r][c] - minb) / (maxb - minb) )
  end   
  self
end
