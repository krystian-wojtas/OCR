

class Alphabet

  attr_reader :height
  
  def initialize(signs)
    @signs = signs
    
    #TODO przesiew maluczkich
    
    #scaling each letter to same height for projection
    #first find max height of alphabet letters...
    @height = 0
    @sings.each do |sing|
      height = sing.rows() if sing.rows() > height
    end
    
    #...then fit height of each letter to this max size
    @sings.each do |sing|
      sing.fit_size :rows => max_height      
    end
    
    #projections of each sign
    @sings.each do |sing|
      sign.projection_horizontal()
      sign.projection_vertical()
    end
    
    #signs are ready for creating alphabet
    make_alphabet()
  end
    
    
  #TODO in aspect log how many letters is recognized
  #letters in font's image must be exactly in order below
  @@alph = %w( q w e r t y u i o p a s d f g h j k l z x c v b n m Q W E R T Y U I O P A S D F G H J K L Z X C V B N M 1 2 3 4 5 6 7 8 9 0 )
  def make_alphabet()
    0.upto @@alph.len()-1 do |i|
      @signs[i].setLetter( @@alph[i] )
    end
  end
  
  
  def get()
    @signs
  end
      
end