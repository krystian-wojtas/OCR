require 'FImg4R_Core'
require 'ocr/Sign'

class Alphabet #TODO refactor Patterns

  attr_reader :max_rows, :max_columns
  

  def make(signs, pattern_signs_order_path)
    @signs = signs
    fit_sizes()
    tie_signs_with_patterns(pattern_signs_order_path)
  end  
  
  
  def setSigns(signs)
    @signs = signs    
  end
    
    
  def getSigns()
    @signs
  end
  
  
  def max_size()
    #scaling each letter to same size for projection
    #first find max size of alphabet letters...
    @max_rows = 0
    @max_columns = 0
    @signs.each do |sign|
      @max_rows = sign.rows() if sign.rows() > @max_rows
      @max_columns = sign.columns() if sign.columns() > @max_columns
    end
    [ @max_rows, @max_columns ]
  end
  
  
  def tie_signs_with_patterns(pattern_signs_order_path)
    #preparing list of patterns for signs from file if its filename is given
    patterns = []    
    if pattern_signs_order_path
      File.readlines(pattern_signs_order_path).each do |line|
        patterns += line.split()
      end
    end
    
    0.upto(@signs.size()-1) do |i|
      if i < patterns.size()
        sign_name = patterns[i]
      else
        sign_name = "UNORDERED_#{i}"
      end
      
      p i.to_s() + ' ' + sign_name
      @signs[i].setPattern(sign_name)
    end    
  end
  
  
  def save(pattern_signs_dirname)    
    @signs.each do |sign|
      sign.img.write("#{pattern_signs_dirname}/#{sign.getPattern()}.jpg")
    end    
  end
  
  
  def read(pattern_signs_dirname)
    @signs = []
    Dir.entries(pattern_signs_dirname).each do |path|
      if path =~ /(.*)\.jpg$/
        pattern = $1
        sign_img = FImg4R.new(path)
        sign = Sign.new(sign_img) #TODO Sign constructor with path
        sign.setPattern(pattern)
        signs.push(sign)
      end
    end
  end
      
end