def histogram_grayscale
  min, max = ekstrema
  iteruj :channels => :monocolor do |r, c|
    @vch[r][c] = Tools.cut( Magick::QuantumRange * (@vch[r][c] - min) / (max - min) )
  end 
  self
end
