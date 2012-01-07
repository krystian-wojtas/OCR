class FImg4R

  private  
    def cut(c)
      (c > @img_rw.qr()) ? @img_rw.qr() : ( (c < 0) ? 0 : c )
    end

end