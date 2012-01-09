class Tools

  def cut(c)
    (c > @QR) ? @QR : ( (c < 0) ? 0 : c )
  end

  
end
