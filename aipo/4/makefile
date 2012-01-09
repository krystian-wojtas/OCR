RUBY=ruby
JRUBY=java -jar ../jruby/jruby-complete.jar
LIBS=-I FImg4R/ -I lib/aquarium-0.4.4/lib
LIBST=$(LIBS) -I test/

all: report

#runs
r: #lab.rb
	cd ..; $(RUBY) $(LIBS) run/run.rb 4

j: #lab.rb
	cd ..; $(JRUBY) $(LIBS) run/run.rb 4

#tests
tr: #../test/test.rb test/LabTestRun_compare.rb
	cd ..; $(RUBY) $(LIBST) test/LabTestRun_compare.rb 4

tj: #../test/test.rb test/LabTestRun_compare.rb
	cd ..; $(JRUBY) $(LIBST) test/LabTestRun_compare.rb 4

#tests patterns
trp:
	cd ..; $(RUBY) $(LIBST) test/LabTestRun_patterns.rb 4

tjp:
	cd ..; $(JRUBY) $(LIBST) test/LabTestRun_patterns.rb 4

#report
re:
	make -C report
	cp report/report.pdf ../reports/report4.pdf
	
rer: r re
	
rej: j re
