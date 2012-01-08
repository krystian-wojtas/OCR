#TODO rename FImg4R_Core_write
require 'aquarium'
include Aquarium::Aspects

Aspect.new :after, :calls_to => :write, :in_type => :FImg4R do |jp, o, *args|
  p "written #{args[0]}"
end