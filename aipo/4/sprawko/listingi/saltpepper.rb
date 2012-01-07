def salt_pepper(tol, min=0, max=Magick::QuantumRange)
  iteruj :channels => :other do |r, c|
    if rand < tol
      if rand < 0.5
        @rch[r][c] = @gch[r][c] = @bch[r][c] = min
      else
        @rch[r][c] = @gch[r][c] = @bch[r][c] = max
      end
    end
  end
  self
end
