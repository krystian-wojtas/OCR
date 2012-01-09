require 'FImg4R_Core'
require 'FImg4R_Tools'

class FImg4R

  #TODO :channels => monocolor, ale rand<freq przeniosiony do iterable
  def salt_pepper_feature(freq, min=0, max=@QR)
    iteruj :iterable => :frequency, :freq => freq do |r, c|
      p r.to_s + ' ' + c.to_s
      if rand < 0.5
        @rch[r][c] = @gch[r][c] = @bch[r][c] = min
      else
        @rch[r][c] = @gch[r][c] = @bch[r][c] = max
      end
    end
    self
  end

#TODO :channels => monocolor, ale rand<freq przeniosiony do iterable
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
  
  
  def get_noise()
    nt = [*-30..-21] + [*21..30] #splat
    nt.collect! {|v| v *= @QR / 255 } #normalize
    nt[rand(nt.size)]      
  end
  
  
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