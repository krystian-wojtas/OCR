require 'FImg4RR_Core'

class FImg4RR

    def drukuj
      edit do
        do_drukuj
      end
    end

  def do_drukuj
    iteruj do |r, c|
      puts r.to_s + ' ' + c.to_s + ' ' + @rchb[r][c].to_s
      puts r.to_s + ' ' + c.to_s + ' ' + @gchb[r][c].to_s
      puts r.to_s + ' ' + c.to_s + ' ' + @bchb[r][c].to_s
    end
  end
  
end
