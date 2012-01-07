def ekstrema(ch=@vch)
  min = Magick::QuantumRange
  max = 0
  iteruj :channels => :other do |r, c|
    min = ch[r][c] if ch[r][c] < min
    max = ch[r][c] if ch[r][c] > max
  end
  [ min, max ]
end
