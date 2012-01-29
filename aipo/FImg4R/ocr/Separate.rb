require 'ocr/Sign'

class Separate
  
  @sign = nil
  
  def initialize(img)
    @sign = Sign.new(img)
  end

  #takes array of projection and finds empty lines
  #empty line is a line that hasn't any black pixel - consist only of white pixels
  #it means that this line don't contains any character
  #empty lines usually lay one by one
  #important are only locations of edges for pieces of empty lines
  #method returns array of locations of edges
  def find_lines(prj)
    lines_edges = []
    line_nr = 0
    white_line = true
    0.upto prj.size() do |i|
      if white_line and prj[i] == 0 
        lines_edges[line_nr] = i
        line_nr = line_nr + 1
        white_line = false
      end
      if not (white_line or prj[i] == 0) 
        lines_edges[line_nr] = i
        line_nr = line_nr + 1
        white_line = true
      end
    end
    lines_edges
  end
  
  
  #separating method should find each separated sign and create new image with only this sign
  #array of signs should be returned with additional information about spaces between signs
  #amount of space will determine if there is a character space ' ' between signs
  #signs_separating = [
    # {
    #   img => FImg4R
    #   space_after =>
    # },
    # ...
    #]
  def method1()
    #initialize array of separated signs to return
    signs = []
    #finding verses in image
    @sign.projection_horizontal()
    lines_h = find_lines(@sign.prj_h)
    0.upto lines_h.size()-1 do |i|#TODO -2?
      verse = @sign.fragment(0, @sign.rows(), lines_h[2*i], lines_h[2*i+1]) #TODO
      #finding letters in verses
      verse.projection_vertical()
      lines_v = find_lines(verse.prj_v)
      0.upto lines_v.size()-1 do |j|
        sign = verse.fragment(lines_v[2*j], lines_v[2*j+1], lines_h[2*i], lines_h[2*i+1])
        #triming letters; they have extra space below and above them
        prj_h2 = sign.projection_horizontal()
        lines_h2 = find_lines(prj_h2)
        sign_trimed = FImg4R.new(lines_v[0], lines_v[1], 0, @sign.columns())
        #add
        signs.append(sign_trimed)
      end
    end
    #result
    signs
  end
  
end