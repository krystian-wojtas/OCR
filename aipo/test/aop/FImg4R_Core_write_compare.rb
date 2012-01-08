require 'FImg4R_Test'
require 'aop/FImg4R_aspects'

class FImg4R
  
  after :calls_to => :write, :in_type => :FImg4R do |jp, o, *args|
    fn_out = args[0]
    img_out = FImg4R.new(fn_out)
    fn_pat = fn_out.gsub('out', 'patterns')
    img_pat = FImg4R.new(fn_pat)
    begin
      img_out.test(img_pat)
      # the fastest way:
      # o.test(img_pat)
      # is not working
      # there are diffrences between values of channels holded in memory and written on disk
    rescue RuntimeError => ex
      p ex
    end
  end
  
end