require 'aquarium'
include Aquarium::Aspects

start_time = nil

Aspect.new :before, :calls_to => :run, :in_types => /Lab/ do |join_point, object, *args|
  start_time = Time.new
end

Aspect.new :after, :calls_to => :run, :in_types => /Lab/ do |join_point, object, *args|
  end_time = Time.new
  File.open("log/time/#{ARGV[0]}", 'w') {|f| f.write( (end_time - start_time).to_s + "\n" ) }
end