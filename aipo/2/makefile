RUBY=ruby
JRUBY=java -jar ../jruby/jruby-complete.jar
LIBS=-I FImg4R/ -I lib/aquarium-0.4.4/lib

all: raport

#runs
r: #lab.rb
	cd ..; $(RUBY) $(LIBS) run/run.rb 2

j: #lab.rb
	cd ..; $(JRUBY) $(LIBS) run/run.rb 2

#tests
tr: #../test/test.rb test/lab_test.rb
	rm out/*
	cd ..; $(RUBY) $(LIBS) test/test.rb 2

tj: #../test/test.rb test/lab_test.rb
	rm out/*
	cd ..; $(JRUBY) $(LIBS) test/test.rb 2

#tests patterns
trp: tr
	cp out/* patterns/

tjp: tj
	cp out/* patterns/

#raport
raport: j
	make -C sprawko
	mv sprawko/sprawko.pdf .
