require 'FImg4RR_Core'
require 'Tools'

class FImg4RR

  #TODO :channels => monocolor, ale rand<freq przeniosiony do iterable
  def salt_pepper(freq, min=0, max=Magick::QuantumRange)
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


  def regular_noise2(freq, allch=true )
    nt = [*-30..-21] + [*21..30] #splat
    nt.collect! {|v| v *= Magick::QuantumRange / 255 } #normalize
      
    if allch
      v = nt[rand(nt.size)]
      iteruj :channels => :other do |r, c|
        if rand < freq
          @rch[r][c] = Tools.cut(@rch[r][c]+v)
          @gch[r][c] = Tools.cut(@gch[r][c]+v)
          @bch[r][c] = Tools.cut(@bch[r][c]+v)
        end
      end
    else
      
      def regular_noise_ch(ch, nt, freq) # TODO nt freq przekazane inaczej
        v = nt[rand(nt.size)]
        iteruj :channels => ch do |r, c|
          if rand < freq
            @vch[r][c] = Tools.cut(@vch[r][c]+v)
          end
        end
      end
      
      [:r, :g, :b].each {|ch| regular_noise_ch(ch,nt,freq)}
    end
    self
  end
  
  
  def regular_noise(freq, allch=true )
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
      if rand < freq
        @rch[r][c] = Tools.cut(@rch[r][c]+noise_r)
        @gch[r][c] = Tools.cut(@gch[r][c]+noise_g)
        @bch[r][c] = Tools.cut(@bch[r][c]+noise_b)
      end
    end
    self
  end


  #TODO :rows -= s, :columns -= s 
  def median_filter_matrix(s)
    iteruj :top => s/2, :bottom => s/2, :left => s/2, :right => s/2 do |r, c|
      neighberhood = []
      (-(s/2)).upto s/2 do |i|
        (-(s/2)).upto s/2 do |j|
          neighberhood.push @vchb[r+i][c+j]
        end
      end
      neighberhood.sort!      
      yield(neighberhood, r, c)
    end
  end

  
  def median_filter(s)
    median_filter_matrix(s) do |neighberhood, r, c|
      @vch[r][c] = neighberhood[s*s/2]
    end
    self
  end


  def median_filter_limited(s)
    #TODO if s is not a number or if s is less then 0 then throw new exception
    #if 0.2*s*s == 0 then raise "" end
    #equivalent if s < 3 raise
    median_filter_matrix(s) do |neighberhood, r, c|
      idx = neighberhood.index( @vch[r][c] )
      if idx < 0.2*s*s or 0.8*s*s < idx
        @vch[r][c] = neighberhood[s*s/2]
      else
        @vch[r][c] = @vchb[r][c]
      end
    end
    self
  end
  
  
  def average_filter(s)
    iteruj :top => s/2, :bottom => s/2, :left => s/2, :right => s/2 do |r, c|
      neighberhood_addition = 0
      (-(s/2)).upto s/2 do |i|
        (-(s/2)).upto s/2 do |j|
          neighberhood_addition += @vchb[r+i][c+j]
        end
      end
      @vch[r][c] = neighberhood_addition / s / s
    end
    self
  end
  
end