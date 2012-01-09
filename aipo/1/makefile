RUBY=ruby
JRUBY=java -jar ../jruby/jruby-complete.jar
LIBS=-I FImg4R/ -I lib/aquarium-0.4.4/lib
LIBST=$(LIBS) -I test/

FIMG4R=FImg4R/FImg4R_Core_Iterable.rb FImg4R/FImg4R_Core_Settings.rb FImg4R/FImg4R_Core.rb
FIMG4R_LAB=FImg4R/FImg4R_Simple.rb FImg4R/FImg4R_Tools.rb
DEP=$(FIMG4R) $(FIMG4R_LAB)

all: report

#runs
r: Lab.rb
	cd ..; $(RUBY) $(LIBS) run/run.rb 1

j: Lab.rb
	cd ..; $(JRUBY) $(LIBS) run/run.rb 1

#tests
tr: #../test/test.rb test/LabTestRun_compare.rb
	cd ..; $(RUBY) $(LIBST) test/LabTestRun_compare.rb 1

tj: #../test/test.rb test/LabTestRun_compare.rb
	cd ..; $(JRUBY) $(LIBST) test/LabTestRun_compare.rb 1

#tests patterns
trp:
	cd ..; $(RUBY) $(LIBST) test/LabTestRun_patterns.rb 1

tjp:
	cd ..; $(JRUBY) $(LIBST) test/LabTestRun_patterns.rb 1

#report
re:
	make -C report
	cp report/report.pdf ../reports/report1.pdf
	
rer: r re
	
rej: j re
