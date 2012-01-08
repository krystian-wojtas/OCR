require 'aop/FImg4R_aspects'

class FImg4R
  
  after :calls_to => :write, :in_type => :FImg4R do |jp, o, *args|
    File.open("#{ARGV[0]}/log/qr", 'w') {|f| f.write(o.qr) }
  end
  
end