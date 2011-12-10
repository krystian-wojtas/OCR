require 'FImg4RR_Core'
require 'Tools'

class FImg4RR
  
  
  def filtr(matrix)
    sw = 0 # suma wag macierzy
    matrix.each {|mm| mm.each {|v| sw += v}}

    k = matrix.length() 
    l = matrix.collect {|m| m.length}.max
      
    iteruj :buffered=>1, :top=>k/2, :bottom=>k/2, :left=>l/2, :right=>l/2 do |r, c|
      v = 0
#TODO pierwsze rozwiazanie      
=begin      
          for i in -k/2+1..k/2 do
            l = matrix[i].length
            for j in -l/2+1..l/2 do
              v += matrix[i][j] * chb[r+j][c+i]
            end
          end
=end        
#=begin      
      for i in 0...(k=matrix.length) do
        for j in 0...(l=matrix[i].length) do
          v += matrix[i][j] * @vchb[r-j+l/2][c-i+k/2]
        end
      end
#=end      
      @vch[r][c] = Tools.cut(v/sw)
    end
    self
  end

end
