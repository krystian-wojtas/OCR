def median_filter_limited(s)
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
