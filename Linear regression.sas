/*IMPORT DATA*/
proc import datafile="/home/u62868661/Datasets/Linear regression/Album Sales.csv"
dbms=csv
out=df
replace;
run;

/*DESCRIPTIVE TABLE*/
proc means data=df chartype mean std min max median n range vardef=df clm 
		alpha=0.05 q1 q3 qrange qmethod=os;
	var adverts sales airplay attract;
run;

/*HISTOGRAMS*/
proc univariate data=df vardef=df noprint;
	var adverts sales airplay attract;
	histogram adverts sales airplay attract / normal(noprint) kernel;
	inset mean std min max median n range q1 q3 qrange / position=nw;
run;

/*CORRELATION ANALYSIS*/
proc corr data=df pearson spearman kendall rank plots=matrix;
	var adverts airplay attract sales;
	with adverts airplay attract sales;
run;

/*SIMPLE LINEAR REGRESSION MODELS*/
proc reg data=df alpha=0.05 plots(only)=(diagnostics residuals partial 
		fitplot observedbypredicted);
	model sales=adverts / clb vif spec;
run;
proc reg data=df alpha=0.05 plots(only)=(diagnostics residuals partial 
		fitplot observedbypredicted);
	model sales=airplay / clb vif spec;
run;
proc reg data=df alpha=0.05 plots(only)=(diagnostics residuals partial 
		fitplot observedbypredicted);
	model sales=attract / clb vif spec;
run;
	
/*MULTIPLE FORCED-ENTRY LINEAR REGRESSION MODEL*/
proc reg data=df alpha=0.05 plots(only)=(diagnostics residuals 
		observedbypredicted);
	model sales=adverts airplay attract / clb vif spec;
run;