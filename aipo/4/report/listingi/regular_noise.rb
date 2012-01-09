def regular_noise(freq, allch=true )
    
  unless allch
    noise_r = get_noise()
    noise_g = get_noise()
    noise_b = get_noise()
  else
    noise_r = noise_g = noise_b = get_noise()
  end
  
  iteruj :channels => :other do |r, c|
    if rand < freq
      @rch[r][c] = cut(@rch[r][c]+noise_r)
      @gch[r][c] = cut(@gch[r][c]+noise_g)
      @bch[r][c] = cut(@bch[r][c]+noise_b)
    end
  end
  self
end
