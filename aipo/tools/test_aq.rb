class Foo
	def bar
		p 'aaa'
	end
end

foo = Foo.new
foo.bar

require 'rubygems'
require 'aquarium'
include Aquarium::Aspects

Aspect.new :after, :calls_to => :bar, :in_types => /Foo/ do |join_point, object, *args| p 'ttt' end

foo.bar
