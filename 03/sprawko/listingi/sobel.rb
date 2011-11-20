def sobel(orginal)
	edit(orginal, :top => 1, :bottom => 1, :left => 1, :right => 1) do |c, r, chb|
		x = chb[c+1][r-1] + 2*chb[c+1][r] + chb[c+1][r+1]
		y = chb[c-1][r+1] + 2*chb[c][r-1] + chb[c+1][r+1] - chb[c-1][r-1] - 2*chb[c][r-1] - chb[c-1][r+1]
		cut( Math.sqrt(x*x + y*y) )
	end
end
