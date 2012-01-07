def average( sr, sc )
  total = 0
  iteruj :channels => :monocolor do |r, c|
    total += @vch[r][c]
  end
  total / sr / sc
end
