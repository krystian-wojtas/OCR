def zoom(s) 
  iteruj :buffered => true, :rows => (s*@orginal.rows).to_i, :columns => (s*@orginal.columns).to_i do |r, c|
    @vch[r][c] = @vchb[r/s][c/s]
  end
  self
end
