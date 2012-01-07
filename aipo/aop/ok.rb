require 'aquarium'
#TODO rename Lab_ok
class Lab
  include Aquarium::DSL
  after :calls_to => :run, :in_type => :Lab do |jp, o, *args|
    p "ok"
  end
end