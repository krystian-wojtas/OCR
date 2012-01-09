def thresholding( threshold=@QR/2, min=0, max=@QR )
  iteruj :channels => :monocolor do |r, c|
    if @vchb[r][c] > threshold
      @vch[r][c] = max
    else
      @vch[r][c] = min
    end
  end
  self
end
