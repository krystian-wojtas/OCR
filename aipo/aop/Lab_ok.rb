require 'aop/Lab_aspects'

class Lab
  
  after :calls_to => :run, :in_types => [:Lab, :LabTest] do |jp, o, *args|
    p "ok"
  end
  
end