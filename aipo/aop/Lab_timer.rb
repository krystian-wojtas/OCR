require 'aop/Lab_aspects'

class Lab
  
  start_time = nil
  
  before :calls_to => :run, :in_type => :Lab do |jp, o, *args|
    start_time = Time.new
  end
  
  after :calls_to => :run, :in_type => :Lab do |jp, o, *args|
    end_time = Time.new
    File.open("log/time/#{ARGV[0]}", 'w') {|f| f.write( (end_time - start_time).to_s + "\n" ) }
  end
  
end