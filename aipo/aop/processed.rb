require 'aquarium'
include Aquarium::Aspects

Aspect.new :after, :calls_to => :write, :in_types => /FImg4R/ do |jp, o, *args|
  p "written #{args[0]}"
end

=begin
require 'aquarium'

class FImg4R
  include Aquarium::DSL
  after :calls_to => :write, :in_type => :FImg4R do |jp, o, *args|
    p "written #{args[0]}"
  end
end
=end