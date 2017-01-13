data cancer;
infile 'C:\Users\100175130\Desktop\breast-cancer-wisconsin.csv' dsd;
input Id CThick SUnif ShUnif MAdhes EpSize BNuc BChrom NNuc Mit Class;
run;

title "listing of dataset";
proc print data=cancer;
run;

proc univariate data = cancer;
var CThick SUnif ShUnif MAdhes EpSize BNuc BChrom NNuc Mit;
run;


proc corresp data=cancer dimens=1 observed short;
   title 'Contingency Table SUnif ShUnif';
   ods select observed;
   tables SUnif, ShUnif;
run;


proc corresp data=cancer dimens=1 observed short;
   title 'Contingency Table SUnif BChrom';
   ods select observed;
   tables SUnif, BChrom;
run;


proc corresp data=cancer dimens=1 observed short;
   title 'Contingency Table SUnif EpSize';
   ods select observed;
   tables SUnif, EpSize;
run;


proc corresp data=cancer dimens=1 observed short;
   title 'Contingency Table ShUnif BChrom';
   ods select observed;
   tables ShUnif, BChrom;
run;

proc sgscatter data=cancer;
	matrix CThick SUnif ShUnif MAdhes EpSize BNuc BChrom NNuc Mit/ diagonal=(histogram);
run;

* Shows a strong positive correlation between SUnif and ShUnif;
proc gplot data=cancer;
	title "Scatterplot SUnif*ShUnif";
	plot SUnif*ShUnif;
run;

* Shows a relatively strong positive correlation between SUnif and BChrom;
proc gplot data=cancer;
	title "Scatterplot SUnif*BChrom";
	plot SUnif*BChrom;
run;

* Shows a relatively strong positive correlation between SUnif and EpSize;
proc gplot data=cancer;
	title "Scatterplot SUnif*EpSize";
	plot SUnif*EpSize;
run;

* Shows a relatively strong positive correlation between ShUnif and BChrom;
proc gplot data=cancer;
	title "Scatterplot ShUnif*BChrom";
	plot ShUnif*BChrom;
run;

proc freq data=cancer;
	tables CThick SUnif ShUnif MAdhes EpSize BNuc BChrom NNuc Mit;
run;

proc corr data=cancer cov;
	var CThick SUnif ShUnif MAdhes EpSize BNuc BChrom NNuc Mit;
run;

