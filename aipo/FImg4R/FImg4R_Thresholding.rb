require 'FImg4R_Core'
require 'FImg4R_Simple'

class FImg4R


  def thresholding( threshold=@qr/2, min=0, max=@qr )
    iteruj :channels => :monocolor do |r, c|
      if @vchb[r][c] > threshold
        @vch[r][c] = max
      else
        @vch[r][c] = min
      end
    end
    self
  end
  

  def thresholding_avl( peaces=1, avr_min=0, avr_max=@qr )
    
    0.upto peaces-1 do |i|
      0.upto peaces-1 do |j|
        
        trf_opts_atomic( {
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
    # reset margins to 0 before writing an image
    # TODO delete and writing the whole image with margins
    @s.make_defaults()
    self
  end


  def thresholding_avl_g( peaces=1, tol=0 )    
    avr_glob = average()
    avr_min = avr_glob - tol * avr_glob
    avr_max = avr_glob + tol * avr_glob
    #TODO better way
    avr_min, avr_max = [ avr_min, avr_max ].collect! do |a|
      cut( a.floor )
    end    
    thresholding_avl( peaces, avr_min, avr_max )
  end

  #TODO tools
  def average()
    total = 0
    pxs = 0
    iteruj :channels => :monocolor do |r, c|
      total += @vch[r][c]
      pxs += 1
    end
    total / pxs
  end

end
