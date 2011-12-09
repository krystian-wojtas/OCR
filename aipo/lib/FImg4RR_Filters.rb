require 'FImg4RR_Core'

class FImg4RR

  public

  def sol_pieprz(orginal, tol)
  	rnd = Random.new(1234)
  	edit(orginal) do |c, r, chb|
  		if rnd.rand < tol
  			if rnd.rand < 0.5 # rowne szanse na czarny i bialy pixel
  				0
  			else
  				Magick::QuantumRange
  			end
  		end
  	end
  end
  
=begin
  def szum_rownomierny(orginal, tol, allch)
  	#losowanie wartosci przesuniecia
  	rnd = Random.new(1234)
  	nt = *(-30..-20) + *(21..30) #splat
  	if(allch)
  		rn = gn = bn = nt[rnd.rand(nt.size)]
  	else
  		rn = nt[rnd.rand(nt.size)]
  		gn = nt[rnd.rand(nt.size)]
  		bn = nt[rnd.rand(nt.size)]
  	end
  	
  	#rzezba
  	edit(orginal) do |c, r, rchb, gchb, bchb|
  		if rnd.rand(100) >= tol
  			rchb[c][r] += rn
  			gchb[c][r] += gn
  			bchb[c][r] += bn
  		end
  	end
  end
  
  
  def filtr_medianowy(orginal, ot)
  	edit(orginal, :top => ot, :bottom => ot, :left => ot, :right => ot) do |c, r, rchb, gchb, bchb|
  		if rnd.rand(100) >= tol
  			rchb[c][r] += rn
  			gchb[c][r] += gn
  			bchb[c][r] += bn
  		end
  	end
  end
=end

end
