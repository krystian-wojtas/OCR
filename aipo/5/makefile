RUBY=ruby
JRUBY=java -jar ../jruby/jruby-complete.jar
LIBS=-I FImg4R/ -I lib/aquarium-0.4.4/lib

all: report

#runs
r: #lab.rb
	cd ..; $(RUBY) $(LIBS) run/run.rb 5

j: #lab.rb
	cd ..; $(JRUBY) $(LIBS) run/run.rb 5

#tests
tr: #../test/test.rb test/lab_test.rb
	rm out/*
	cd ..; $(RUBY) $(LIBS) test/test.rb 5

tj: #../test/test.rb test/lab_test.rb
	rm out/*
	cd ..; $(JRUBY) $(LIBS) test/test.rb 5

#tests patterns
trp: tr
	cp out/* patterns/

tjp: tj
	cp out/* patterns/

#report
re:
	make -C report
	cp report/report.pdf ../reports/report5.pdf
	
rer: r re
	
rej: j re
