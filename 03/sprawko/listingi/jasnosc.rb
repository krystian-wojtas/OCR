def jasnosc(orginal,w)
	edit(orginal) do |i, j, chb|
		cut( chb[i][j] + w )
	end
end
