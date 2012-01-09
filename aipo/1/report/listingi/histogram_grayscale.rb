def histogram_grayscale
  grayscale1
  min, max = extrems
  iteruj :channels => :monocolor do |r, c|
    @vch[r][c] = cut( @img_rw.qr() * (@vch[r][c] - min) / (max - min) )
  end 
  self
end
