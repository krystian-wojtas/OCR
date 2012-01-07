RUBY=ruby
JRUBY=java -jar ../jruby/jruby-complete.jar
LIBS=-I FImg4R/ -I lib/aquarium-0.4.4/lib

FIMG4R=FImg4R/FImg4R_Core_Iterable.rb FImg4R/FImg4R_Core_Settings.rb FImg4R/FImg4R_Core.rb
FIMG4R_LAB=FImg4R/FImg4R_Simple.rb FImg4R/FImg4R_Tools.rb
DEP=$(FIMG4R) $(FIMG4R_LAB)

all: raport

#runs
r: #lab.rb
	cd ..; $(RUBY) $(LIBS) run/run.rb 1

j: #lab.rb
	cd ..; $(JRUBY) $(LIBS) run/run.rb 1

#tests
tr: #../test/test.rb test/lab_test.rb
	rm out/*
	cd ..; $(RUBY) $(LIBS) test/test.rb 1

tj: #../test/test.rb test/lab_test.rb
	rm out/*
	cd ..; $(JRUBY) $(LIBS) test/test.rb 1

#tests patterns
trp: tr
	cp out/* patterns/

tjp: tj
	cp out/* patterns/

#report
rep: j
	make -C report
	mv report/report.pdf ../reports
