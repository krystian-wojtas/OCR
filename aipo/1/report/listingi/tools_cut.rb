class Tools

  def Tools.cut(c)
    (c > Magick::QuantumRange) ? Magick::QuantumRange : ( (c < 0) ? 0 : c )
  end
  
end
