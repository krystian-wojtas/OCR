def median_filter(s)
  median_filter_matrix(s) do |neighberhood, r, c|
    @vch[r][c] = neighberhood[s*s/2]
  end
  self
end
