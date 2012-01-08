require "#{ARGV[0]}/test/LabTest"

class LabTestRun
  
  def run()
    LabTest.new.run("lena256.jpg")    
  end
end