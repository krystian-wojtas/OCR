require "#{ARGV[0]}/test/LabTest"
require 'aop/Lab_ok.rb'
require 'aop/FImg4R_write.rb'

class LabTestRun
  
  def run()
    LabTest.new.run("lena256.jpg")    
  end
end