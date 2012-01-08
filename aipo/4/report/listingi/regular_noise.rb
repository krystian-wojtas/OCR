def regular_noise(tol, allch=true )
  nt = [*-30..-21] + [*21..30] #splat
  nt.collect! {|v| v *= Magick::QuantumRange / 255 } #normalize
    
  unless allch
    noise_r = nt[rand(nt.size)]
    noise_g = nt[rand(nt.size)]
    noise_b = nt[rand(nt.size)]
  else
    noise_r = noise_g = noise_b = nt[rand(nt.size)]  
  end
  p 'noise r ' + noise_r.to_s
  p 'noise g ' + noise_g.to_s
  p 'noise b ' + noise_b.to_s
  
  iteruj :channels => :other do |r, c|
    if rand < tol
      @rch[r][c] = Tools.cut(@rch[r][c]+noise_r)
      @gch[r][c] = Tools.cut(@gch[r][c]+noise_g)
      @bch[r][c] = Tools.cut(@bch[r][c]+noise_b)
    end
  end
  self
end
