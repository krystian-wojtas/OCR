def obroc(i, j, kat)
	[
		( Math.cos(kat)*i-Math.sin(kat)*j ).to_i,
		( Math.sin(kat)*i+Math.cos(kat)*j ).to_i,
	]
end

def obrot(orginal, kat)
	#powrot jesli nie trzeba obracac
	if kat == 0
		return orginal
	end
	#ustalenie wymiarow obrazka i przesuniecia
	xs = []
	ys = []
	[ [0, 0], [orginal.columns, 0], [orginal.columns, orginal.rows], [0, orginal.rows] ].each do |m|
		px = obroc(m[0], m[1], kat)
		xs.push( px[0] )
		ys.push( px[1] )
	end
	xs.sort!()
	ys.sort!()
	#szerokosc i wysokosc nowego obrazka
	width = xs[3] - xs[0]
	height = ys[3] - ys[0]
	#wektor przesuniecia [p, q]
	p = xs[0]
	q = ys[0]

	edit(orginal, :columns => width, :rows => height ) do |i, j, chb|
		px = obroc(i+q, j+p, kat)
		if px[0] < orginal.columns and px[1] < orginal.rows and px[0] > 0 and px[1] > 0 
			cut( chb[px[0]][px[1]] ) 
		else
			Magick::QuantumRange
		end
	end
end
