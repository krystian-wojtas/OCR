def salt_pepper(freq, min=0, max=@QR)
  iteruj :channels => :other do |r, c|
    if rand < freq
      if rand < 0.5
        @rch[r][c] = @gch[r][c] = @bch[r][c] = min
      else
        @rch[r][c] = @gch[r][c] = @bch[r][c] = max
      end
    end
  end
  self
end
