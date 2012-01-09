def get_noise()
  nt = [*-30..-21] + [*21..30] #splat
  nt.collect! {|v| v *= @QR / 255 } #normalize
  nt[rand(nt.size)]      
end
