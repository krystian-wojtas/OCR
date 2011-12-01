require 'MyImgLib'

MyImgLib.class_eval do
  

  def jasnosc(w)
    edit do |i, j, chb|
      cut( chb[i][j] + w )
    end
  end
  
 private
  def do_jasnosc2(w)
     iteruj do |i, j, chb|
       cut( chb[i][j] + w )
     end
  end
   
  #TODO co jesli bez block.arity? 
  def do_jasnosc3(w)
     iteruj do |i, j|
       teSame(
         cut(
           @chb[i][j] + w
         )
       )
     end
   end
   
   def do_progowanie(tol, obszarow)
     obszarow.downto 0 do |i|
       obszarow.downto 0 do |j|
         iteruj(:left => @orginal.columns/obszarow*i, :right => @orginal.columns/obszarow*(i+1), :top => 1, :down => 2) do |chr, chg, chb, c, r|
           
         end
       end
     end
   end
   
   def do_binearyzacja(tol = Magick::QuantumRange / 2, min = 0, max = Magick::QuantumRange)
     iteruj do |i, j, chb|
       if chb[i][j] > tol
         max
       else
         min
       end
     end
   end
   
  def do_kmn2
    do_binearyzacja( Magick::QuantumRange / 2, 0, 1)
    iteruj do |i, j, chb|
      cut( chb[i][j] + w )
    end
    do_binearyzacja( 0, 0, Magick::QuantumRange) #debinaryzacja
  end
   
  
public
  #TODO jeden wrapper evalujacy te metody; metaprogramowanie
  #argumenty metod wyciaga z argumentow metod do_ i nienaruszajac przekazuje je do do_
  #egzemplarze metod roznia sie opcjami dla edita
  
  def jasnosc2(w)
     edit(:buforowanie => 1) do 
       do_jasnosc2(w)
     end
   end
   
   def progowanie(tol, obszarow = 1)
     edit(:buforowanie => 1) do 
       do_progowanie(tol, obszarow)
     end
   end
   
   def binearyzacja(tol = Magick::QuantumRange / 2, min = 0, max = Magick::QuantumRange)
     edit do 
       do_binearyzacja(tol, min, max)
     end
   end
   
   
   
  def kmm2
    edit(:buforowanie => 1) do
      do_kmn2
    end
  end
  

def edit2(opts={}, &block)
    options(opts)
    
    eksport(
      rzezba(
        import()
      )
    )
  end

  def ramka(s=1, kolor=Magick::QuantumRange)
      edit(:columns => @orginal.columns + 2*s, :rows => @orginal.rows+2*s) do |c, r, chb|
        if c < s or c > @orginal.columns+s-1 or r < s or r > @orginal.rows+s-1
          kolor
        else
          chb[c-s][r-s]
        end
      end
  end
  
  def ramka2(s=1)
      edit(:columns => @orginal.columns + 2*s, :rows => @orginal.rows+2*s) do |c, r, chb|
        if c < s or c > @orginal.columns+s-1 or r < s or r > @orginal.rows+s-1
          0
        else
          #warstwa binearyzaji yieldem
          if chb[c-s][r-s] > Magick::QuantumRange / 2
            1
          else
            0
          end
        end
      end
  end

@@czworki = [ 3, 6, 7, 12, 14, 15, 24, 28, 30, 48, 56, 60, 96, 112, 120, 129, 131, 135, 192, 193, 195, 224, 225, 240 ]
@@wyciecia = [ 3, 5, 7, 12, 13, 14, 15, 20, 21, 22, 23, 28, 29, 30, 31, 48, 52, 53, 54, 55, 56, 60, 61, 62, 63, 65, 67, 69, 71, 77, 79, 80, 81, 83, 84, 85, 86, 87, 88, 89, 91, 92, 93, 94, 95, 97, 99, 101, 103, 109, 111, 112, 113, 115, 116, 117, 118, 119, 120, 121, 123, 124, 125, 126, 127, 131, 133, 135, 141, 143, 149, 151, 157, 159, 181, 183, 189, 191, 192, 193, 195, 197, 199, 205, 207, 208, 209, 211, 212, 213, 214, 215, 216, 217, 219, 220, 221, 222, 223, 224, 225, 227, 229, 231, 237, 239, 240, 241, 243, 244, 245, 246, 247, 248, 249, 251, 252, 253, 254, 255 ]
@@sprawdzarka = [ [128, 64, 32], [1, 0, 16], [2, 4, 8] ]
  def kmm
      
    #mod = ramka2
    
    #alokacja tablic, wypelnienie zerami
    vch = []  
    0.upto @orginal.rows-1+2 do |r| #-1 dla rows, +2 dodatkowe wiersze obramowania
      vch.push( Array.new(@orginal.columns+2, 0) ) #+2 dodatkowe kolumny obramowania
    end
    
    #binearyzacja
    1.upto vch.length-2 do |r|
      1.upto vch[r].length-2 do |c|
        if @orginal.pixel_color(c-1, r-1).red > Magick::QuantumRange / 2
          vch[r][c] = 0
        else
          vch[r][c] = 1
        end
      end
    end
    
    #petla
    it = 0
    powtorzyc = true
    while(powtorzyc and it < 100) do #TODO for
    #for(it = 0; it < 100; it += 1) do
      puts it
      it += 1
      powtorzyc = false
      1.upto vch.length-2 do |r|
        1.upto vch[r].length-2 do |c|
          if vch[r][c] == 1
            if vch[r][c-1] == 0 or vch[r][c+1] == 0 or vch[r-1][c] == 0 or vch[r+1][c] == 0
              vch[r][c] = 2
            elsif vch[r-1][c-1] == 0 or vch[r-1][c+1] == 0 or vch[r+1][c-1] == 0 or vch[r+1][c+1] == 0
              vch[r][c] = 3
            end
          end
        end
      end
      def maska(r, c, vch)
        s = 0
        if vch[r-1][c-1] != 0 then s += @@sprawdzarka[0][0] end
        if vch[r-1][c] != 0 then s += @@sprawdzarka[0][1] end
        if vch[r-1][c+1] != 0 then s += @@sprawdzarka[0][2] end 
        if vch[r][c-1] != 0 then s += @@sprawdzarka[1][0] end
        if vch[r][c+1] != 0 then s += @@sprawdzarka[1][2] end
        if vch[r+1][c-1] != 0 then s += @@sprawdzarka[2][0] end
        if vch[r+1][c] != 0 then s += @@sprawdzarka[2][1] end
        if vch[r+1][c+1] != 0 then s += @@sprawdzarka[2][2] end
        s
      end
      1.upto vch.length-2 do |r|
        1.upto vch[r].length-2 do |c|
          if vch[r][c] == 2
            if @@czworki.include? maska(r,c, vch)
              vch[r][c] = 4
            end
          end
        end
      end
      1.upto vch.length-2 do |r|
        1.upto vch[r].length-2 do |c|
          if vch[r][c] == 4
            if @@wyciecia.include? maska(r,c, vch)
              vch[r][c] = 0
              powtorzyc = true
            else
              vch[r][c] = 1
            end
          end
        end
      end
      1.upto vch.length-2 do |r|
        1.upto vch[r].length-2 do |c|
          if vch[r][c] == 2
            if @@wyciecia.include? maska(r,c, vch)
              vch[r][c] = 0
              powtorzyc = true
            else
              vch[r][c] = 1
            end
          end
        end
      end
      1.upto vch.length-2 do |r|
        1.upto vch[r].length-2 do |c|
          if vch[r][c] == 3
            if @@wyciecia.include? maska(r,c, vch)
              vch[r][c] = 0
              powtorzyc = true
            else
              vch[r][c] = 1
            end
          end
        end
      end
    end
    puts '--------- ' + it.to_s
#debinearyzacja
    mod = Magick::Image.new( @orginal.columns, @orginal.rows )
    0.upto mod.rows-1 do |r|
      0.upto mod.columns-1 do |c|
        if vch[r][c] == 0
          px = Magick::Pixel::new( Magick::QuantumRange, Magick::QuantumRange, Magick::QuantumRange, Magick::QuantumRange )
        else
          px = Magick::Pixel::new( 0, 0, 0, Magick::QuantumRange )
        end
        mod.pixel_color(c, r, px)
      end
    end
    
=begin    
    (@orginal.rows-1).downto 0 do |r|
      ch = vch.pop
      mod.import_pixels(0, r, mod.columns, 1, "R", ch)
      mod.import_pixels(0, r, mod.columns, 1, "G", ch)
      mod.import_pixels(0, r, mod.columns, 1, "B", ch)
    end
=end    

    mod
  end
  
end
