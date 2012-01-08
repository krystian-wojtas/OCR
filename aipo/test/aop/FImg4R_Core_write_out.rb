#TODO require 'aop/aquarium_aspects.rb'
require 'aquarium'
include Aquarium::Aspects

Aspect.new :before, :calls_to => :write, :in_type => :FImg4R do |jp, o, *args|
  args[0].gsub!('out', 'patterns')
end