require 'aop/FImg4R_aspects'

class FImg4R

  noise_r = nil
  noise_g = nil
  noise_b = nil
  allch = nil
  regular_noise = false
  
  before :calls_to => :regular_noise, :in_type => :FImg4R do |jp, o, *args|
    regular_noise = true
    allch = args[1]
  end
  
  after_returning :calls_to => :get_noise, :in_type => :FImg4R do |jp, o, *args|
    if regular_noise
      noise = jp.context.returned_value
      unless allch
        if noise_r.nil?
          noise_r = noise
        elsif noise_g.nil?
          noise_g = noise
        elsif noise_b.nil?
          noise_b = noise
        end
      else
        noise_r = noise_g = noise_b = noise
      end
    end
  end
  
  after :calls_to => :write, :in_type => :FImg4R do |jp, o, *args|
    if regular_noise
      regular_noise = false
      fn = args[0].match(/\d+\/out\/([^\.]+)/)[1]
      File.open("#{ARGV[0]}/log/#{fn}_noise_r", 'w') {|f| f.write(noise_r) }
      File.open("#{ARGV[0]}/log/#{fn}_noise_g", 'w') {|f| f.write(noise_g) }
      File.open("#{ARGV[0]}/log/#{fn}_noise_b", 'w') {|f| f.write(noise_b) }
      noise_r = noise_g = noise_b = nil
    end
  end
  
end