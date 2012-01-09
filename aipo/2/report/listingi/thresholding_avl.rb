def thresholding_avl( peaces=1, avr_min=0, avr_max=@QR )
  
  0.upto peaces-1 do |i|
    0.upto peaces-1 do |j|
      
      lock_settings( {
        :channels => :monocolor,
        :iterable => :local,
        :iter_loc_peaces => peaces,
        :iter_loc_i => i,
        :iter_loc_j => j,
      }) do
        
        avr = average()
        if avr < avr_min then avr = avr_min end 
        if avr > avr_max then avr = avr_max end    
        thresholding avr
      end
    end
  end
  self
end

