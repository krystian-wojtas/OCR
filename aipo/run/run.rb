require "#{ARGV[0]}/Lab"
#require "#{ARGV[0]}/aspects" #if exists?
#same global aspects
#require 'aop/Lab_ok.rb'
#require 'aop/Lab_timer.rb'
#require 'aop/FImg4R_write.rb'

Lab.new.run('Maria.jpg', "Maria_")
#Lab.new.run('lena256.jpg', '')
#Lab.new.run('lena.jpg', '')
