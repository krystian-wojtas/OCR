def zoom(s) 
  iteruj :buffered => true, :rows => (s*@img_rw.rows).to_i, :columns => (s*@img_rw.columns).to_i do |r, c|
    @vch[r][c] = @vchb[r/s][c/s]
  end
  self
end
