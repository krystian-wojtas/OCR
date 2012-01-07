require "#{ARGV[0]}/Lab"
require 'aop/ok.rb'
require 'aop/processed.rb'
require 'aop/timer.rb'

Lab.new.run("lena256.jpg")
#Lab.new.run("lena.jpg")