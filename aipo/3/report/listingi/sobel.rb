def sobel
  iteruj :buffered=>true, :top=>1, :bottom=>1, :left=>1, :right=>1 do |r, c|
    x = @vchb[r-1][c+1] + 2*@vchb[r][c+1] + @vchb[r+1][c+1] - @vchb[r-1][c-1] - 2*@vchb[r][c-1] - @vchb[r+1][c-1]
    y = @vchb[r+1][c-1] + 2*@vchb[r+1][c] + @vchb[r+1][c+1] - @vchb[r-1][c-1] - 2*@vchb[r-1][c] - @vchb[r-1][c+1]
    @vch[r][c] = cut( (Math.sqrt(x*x + y*y)).to_i )
  end 
  self
end
