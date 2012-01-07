def thresholding( threshold=Magick::QuantumRange/2, min=0, max=Magick::QuantumRange )
  iteruj :channels => :monocolor do |r, c|
    if @vchb[r][c] > threshold
      @vch[r][c] = max
    else
      @vch[r][c] = min
    end
  end
  self
end
