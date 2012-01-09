def average()
  total = 0
  pxs = 0
  iteruj :channels => :monocolor do |r, c|
    total += @vch[r][c]
    pxs += 1
  end
  total / pxs
end
