require 'RMagick'

class Tools

  #przycina wartosc koloru do zakresu 0 - Magick::QuantumRange
  #TODO moze w range?
  def Tools.cut(c)
    (c > Magick::QuantumRange) ? Magick::QuantumRange : ( (c < 0) ? 0 : c )
  end
  
end
