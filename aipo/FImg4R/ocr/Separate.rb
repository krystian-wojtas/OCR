require 'ocr/Sign'

class Separate
  
  @sign = nil
  
  def setSign(img)
    @sign = Sign.new(img)
  end
  
  def getSign()
    @sign
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
    white_line = false
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
    0.upto lines_h.size()-1 do |i|
      if lines_h[2*i] and lines_h[2*i+1]
        verse = @sign.fragment(0, @sign.columns(), lines_h[2*i], lines_h[2*i+1]) #TODO
        #verse.img.write("ocr/out/recognized/v#{i}.jpg")
        #finding letters in verses
        verse.projection_vertical()
        lines_v = find_lines(verse.prj_v)
        0.step(lines_v.size()-2, 2) do |j|
          if lines_v.size() > 1
            if lines_v[2*j] and lines_v[2*j+1]
              sign = @sign.fragment(lines_v[2*j], lines_v[2*j+1], lines_h[2*i], lines_h[2*i+1])
              #sign.img.write("ocr/out/recognized/v#{i}s#{j}.jpg")
              #triming letters; they have extra space below and above them
              prj_h2 = sign.projection_horizontal()
              lines_h2 = find_lines(prj_h2)
              if lines_h2[0] and lines_h2[1]
                sign_trimed = sign.fragment(lines_h2[0], lines_h2[1], 0, sign.rows())
              else
                sign_trimed = sign
              end
              sign_trimed.img.write("ocr/out/recognized/v#{i}s#{j}.jpg")
              signs.push(sign_trimed)
            end
          end
        end
      end
    end
    #result
    signs
  end
  
end