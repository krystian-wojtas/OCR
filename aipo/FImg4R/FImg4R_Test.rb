require 'FImg4R_Core'

class FImg4R
  
  attr_reader :img_rw
  
  def test(img_org)
    if @img_rw.columns() != img_org.img_rw.columns()
      raise "Number of columns do not match" 
    end
    if @img_rw.rows() != img_org.img_rw.rows()
      raise "Number of rows do not match" 
    end
    diffs = []
    iteruj :channels => :monocolor do |r, c|
      if @rch[r][c] != img_org.img_rw.rch[r][c]
        diffs.push( {:r=>r, :c=>c, :ch=>'red', :v1=>@rch[r][c], :v2=>img_org.img_rw.rch[r][c]} )
      end
      if @gch[r][c] != img_org.img_rw.gch[r][c]
        diffs.push( {:r=>r, :c=>c, :ch=>'green', :v1=>@gch[r][c], :v2=>img_org.img_rw.gch[r][c]} )
      end
      if @bch[r][c] != img_org.img_rw.bch[r][c]
        diffs.push( {:r=>r, :c=>c, :ch=>'blue', :v1=>@bch[r][c], :v2=>img_org.img_rw.bch[r][c]} )
      end
    end
    
    if diffs.size > 0
      # TODO pring if log level > ..
      for d in diffs
        p 'row: ' + d[:r].to_s + ' column: ' + d[:c].to_s + ' channel: ' + d[:ch] + ' pixel out value: ' + d[:v1].to_s + ' pixel pat value: ' + d[:v2].to_s
      end
      raise 'There are diffrences between images'
    end
  end
  
end