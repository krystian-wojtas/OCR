def kmm
  binarization do
    @s.update( :buffered => false )
    
    czworki = [ 3, 6, 7, 12, 14, 15, 24, 28, 30, 48, 56, 60, 96, 112, 120, 129, 131, 135, 192, 193, 195, 224, 225, 240 ]
    wyciecia = [ 3, 5, 7, 12, 13, 14, 15, 20, 21, 22, 23, 28, 29, 30, 31, 48, 52, 53, 54, 55, 56, 60, 61, 62, 63, 65, 67, 69, 71, 77, 79, 80, 81, 83, 84, 85, 86, 87, 88, 89, 91, 92, 93, 94, 95, 97, 99, 101, 103, 109, 111, 112, 113, 115, 116, 117, 118, 119, 120, 121, 123, 124, 125, 126, 127, 131, 133, 135, 141, 143, 149, 151, 157, 159, 181, 183, 189, 191, 192, 193, 195, 197, 199, 205, 207, 208, 209, 211, 212, 213, 214, 215, 216, 217, 219, 220, 221, 222, 223, 224, 225, 227, 229, 231, 237, 239, 240, 241, 243, 244, 245, 246, 247, 248, 249, 251, 252, 253, 254, 255 ]
    sprawdzarka = [ [128, 64, 32], [1, 0, 16], [2, 4, 8] ]
    #petla
    it = 0
    powtorzyc = true
    while(powtorzyc and it < 100) do
      powtorzyc = false
      it += 1
      
      iteruj do |r, c|
        if @vchb[r][c] == 1
          if @vchb[r][c-1] == 0 or @vchb[r][c+1] == 0 or @vchb[r-1][c] == 0 or @vchb[r+1][c] == 0
            @vch[r][c] = 2
          elsif @vchb[r-1][c-1] == 0 or @vchb[r-1][c+1] == 0 or @vchb[r+1][c-1] == 0 or @vchb[r+1][c+1] == 0
            @vch[r][c] = 3
          end
        end
      end

      def maska(r, c, sprawdzarka)
        s = 0
        if @vchb[r-1][c-1] != 0 then s += sprawdzarka[0][0] end
        if @vchb[r-1][c] != 0 then s += sprawdzarka[0][1] end
        if @vchb[r-1][c+1] != 0 then s += sprawdzarka[0][2] end
        if @vchb[r][c-1] != 0 then s += sprawdzarka[1][0] end
        if @vchb[r][c+1] != 0 then s += sprawdzarka[1][2] end
        if @vchb[r+1][c-1] != 0 then s += sprawdzarka[2][0] end
        if @vchb[r+1][c] != 0 then s += sprawdzarka[2][1] end
        if @vchb[r+1][c+1] != 0 then s += sprawdzarka[2][2] end
        s
      end
      iteruj do |r, c|
        if @vchb[r][c] == 2
          if czworki.include? maska(r,c, sprawdzarka)
            @vch[r][c] = 4
          end
        end
      end
      #TODO powtorzyc na true w jednym z blokow nie jest wymagane
      iteruj do |r, c|
        if @vchb[r][c] == 4
          if wyciecia.include? maska(r,c, sprawdzarka)
            powtorzyc = true
            @vchb[r][c] = 0
          else
            @vchb[r][c] = 1
          end
        end
      end
      iteruj do |r, c|
        if @vchb[r][c] == 2
          if wyciecia.include? maska(r,c, sprawdzarka)
            powtorzyc = true
            @vchb[r][c] = 0
          else
            @vchb[r][c] = 1
          end
        end
      end
      iteruj do |r, c|
        if @vchb[r][c] == 3
          if wyciecia.include? maska(r,c, sprawdzarka)
            powtorzyc = true
            @vchb[r][c] = 0
          else
            @vchb[r][c] = 1
          end
        end
      end
    end
  end
  self
end
