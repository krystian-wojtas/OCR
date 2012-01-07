def thresholding_avl( peaces=1, avr_min=0, avr_max=Magick::QuantumRange )
  
  0.upto peaces-1 do |i|
    0.upto peaces-1 do |j|
      
      top = @s.o[:rows] / peaces*j
      bottom = @s.o[:rows] / peaces*(j+1)
      left = @s.o[:columns] / peaces*i
      right = @s.o[:columns] / peaces*(i+1)
      if bottom > @s.o[:rows] then bottom = @s.o[:rows] end
      if right > @s.o[:columns] then right = @s.o[:columns] end
      trf_opts_atomic( {
        :channels => :monocolor,
        :iterable => :area,
        :top => top,
        :bottom => bottom,
        :left => left,
        :right => right,
      }) do
        
        avr = average( (bottom-top), (right-left) )
        if avr < avr_min then avr = avr_min end 
        if avr > avr_max then avr = avr_max end 
        puts avr          
        thresholding avr
      end
    end
  end
  # reset margins to 0 before writing an image
  @s.make_defaults()
  self
end
