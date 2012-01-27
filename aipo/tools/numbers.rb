ip = "192.168.0.1"

if( ip.match(/((\d+).?)+/).nil? )
  puts "Not an IP address"
  exit
end

numbers = ip.scan(/(\d+).?/).
  flatten.
  map{|n| n.to_i }

puts numbers.inspect
