# TODO rewrite with AspectR
# AspectR has implemented cflow
# Aquarium has not
# From Aquarium 4.4 and 5.0 README:
# ### Differences With AspectJ Behavior
# ...
# * More advanced AspectJ pointcut language features are not supported, such as the runtime pointcut designators like `if` conditionals and `cflow` (context flow) and the compile time `within` and `withincode` designators. Most of AspectJ pointcut language features are planned, however.

#=begin
require 'aquarium'

class FImg4R
  include Aquarium::DSL
  
  it = nil
  kmm = false
  scienianie = false
  
  before :calls_to => [:kmm, :scienianie], :in_type => :FImg4R do |jp, o, *args|
    it = 0
  end
  
  before :calls_to => :kmm, :in_type => :FImg4R do |jp, o, *args|
    kmm = true
  end
  
  before :calls_to => :scienianie, :in_type => :FImg4R do |jp, o, *args|
    scienianie = true
  end
  
  after :calls_to => :iteruj, :in_type => :FImg4R do |jp, o, *args|
    if kmm or scienianie then it += 1 end
  end
  
  after :calls_to => :write, :in_type => :FImg4R do |jp, o, *args|
    if kmm or scienianie
      it -= 2 # 2 times thresholding
      if kmm
        it /= 5 # kmm is invoking 5 times processing in one iteration
        kmm = false
      else
        scienianie = false
      end
      fn = args[0].match(/\d+\/out\/([^\.]+)/)[1]
      File.open("#{ARGV[0]}/log/#{fn}", 'w') {|f| f.write("#{it}") }
    end
  end
  
end
#=end


=begin
require 'aquarium'
include Aquarium::Aspects

it = nil
bin = false
fn = nil

Aspect.new :before, :calls_to => [:kmm, :scienianie], :in_type => :FImg4R do |jp, o, *args|
  it = 0
  bin = true
end

Aspect.new :after, :calls_to => [:iteruj], :in_type => :FImg4R do |jp, o, *args|
  if bin then it += 1 end
end

Aspect.new :after, :calls_to => :write, :in_type => :FImg4R do |jp, o, *args|
  bin = false
  fn = args[0].match(/\d+\/out\/([^\.]+)/)[1]
  File.open("#{ARGV[0]}/log/#{fn}", 'w') {|f| f.write("#{it}") }
end
=end