require 'aop/FImg4R_aspects'

class FImg4R

  attr_reader :rch, :gch, :bch
  
  minr, maxr = nil, nil
  ming, maxg = nil, nil
  minb, maxb = nil, nil
  histogram = false
  
  before :calls_to => :histogram, :in_type => :FImg4R do |jp, o, *args|
    histogram = true
  end
  
  after_returning :calls_to => :extrems, :in_type => :FImg4R do |jp, o, *args|
    if histogram
      results = jp.context.returned_value
      case args[0]
      when o.rch
        minr, maxr = results[0], results[1]
      when o.gch
        ming, maxg = results[0], results[1]
      when o.bch
        minb, maxb = results[0], results[1]
      end
    end
  end
  
  after :calls_to => :write, :in_type => :FImg4R do |jp, o, *args|
    if histogram
      histogram = false
      fn = args[0].match(/\d+\/out\/([^\.]+)/)[1]
      File.open("#{ARGV[0]}/log/#{fn}_minr", 'w') {|f| f.write(minr) }
      File.open("#{ARGV[0]}/log/#{fn}_maxr", 'w') {|f| f.write(maxr) }
      File.open("#{ARGV[0]}/log/#{fn}_ming", 'w') {|f| f.write(ming) }
      File.open("#{ARGV[0]}/log/#{fn}_maxg", 'w') {|f| f.write(maxg) }
      File.open("#{ARGV[0]}/log/#{fn}_minb", 'w') {|f| f.write(minb) }
      File.open("#{ARGV[0]}/log/#{fn}_maxb", 'w') {|f| f.write(maxb) }
    end
  end
  
end