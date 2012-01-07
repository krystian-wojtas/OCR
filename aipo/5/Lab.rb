require 'FImg4R_KMM'

class Lab
  
  def run(img_fn)
    FImg4R.new("5/in/p2.bmp").kmm.write('5/out/kmm_p2_100.jpg')
    FImg4R.new("5/in/p2.bmp").scienianie.write('5/out/sc_p2_100.jpg')
=begin
    FImg4R.new("5/in/p1.bmp").kmm.write('5/out/kmm_p1_100.jpg')
    FImg4R.new("5/in/p2.bmp").kmm.write('5/out/kmm_p2_100.jpg')
    FImg4R.new("5/in/p3.bmp").kmm.write('5/out/kmm_p3_100.jpg')
    FImg4R.new("5/in/p4.bmp").kmm.write('5/out/kmm_p4_100.jpg')
    FImg4R.new("5/in/o1.bmp").kmm.write('5/out/kmm_o1_100.jpg')
    FImg4R.new("5/in/o2.bmp").kmm.write('5/out/kmm_o2_100.jpg')
=end
    
=begin
    FImg4R.new("5/in/p1.bmp").scienianie.write('5/out/sc_p1_100.jpg')
    FImg4R.new("5/in/p1.bmp").scienianie.write('5/out/sc_p2_100.jpg')
    FImg4R.new("5/in/p3.bmp").scienianie.write('5/out/sc_p3_100.jpg')
    FImg4R.new("5/in/p4.bmp").scienianie.write('5/out/sc_p4_100.jpg')
    FImg4R.new("5/in/o1.bmp").scienianie.write('5/out/sc_o1_100.jpg')
    FImg4R.new("5/in/o2.bmp").scienianie.write('5/out/sc_o2_100.jpg')
=end
  end
end
