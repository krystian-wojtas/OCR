def krzyzRobertsa(orginal)
	edit(orginal, :top => 1, :bottom => 1, :left => 1, :right => 1) do |i, j, chb|
		cut( (chb[i][j] - chb[i+1][j+1]).abs + (chb[i][j+1] - chb[i+1][j]).abs )
	end
end
