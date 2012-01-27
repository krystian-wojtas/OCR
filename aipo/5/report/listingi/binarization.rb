def binarization
  lock_settings( {
      :channels => :monocolor,
      :buffered => true,
      :columns => @s.o[:columns]+2,
      :rows => @s.o[:rows]+2,
      :top => 1,
      :bottom => 1,
      :left => 1,
      :right => 1,
  }) do
    thresholding( @QR/2, 1, 0)    
    yield    
    thresholding( 0, @QR, 0) #debinaryzacja
  end  
end
