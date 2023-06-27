use "/Users/emm4376/Downloads/BraceroData.dta"

generate post = (year > 1962)

sum yearly_mex_frac if treated == 0 & post == 0
sum yearly_mex_frac if treated == 1 & post == 0
sum yearly_mex_frac if treated == 0 & post == 1
sum yearly_mex_frac if treated == 1 & post == 1

regress yearly_mex_frac post, cluster(state)

ssc install binscatter

binscatter yearly_mex_frac year, by(treated) discrete linetype(connect) xline(1962 1965)

areg yearly_mex_frac ib1961.year##treated,  cluster(state) a(state) 

ssc install coefplot
coefplot ,vertical keep(*.year#1.treated) omit base rename(*.year#1.treated="") ///
xlabel(,angle(45)) nolabels color(black) plotregion(color(white)) graphregion(color(white)) ///
ytitle("Mexican Fraction of Seasonal Workers") xtitle("Year") xline(8 11, lpattern(dash)) ///
level(95) ylabel(-0.6(.2)0.6) yscale(r(-.6,.6))

/// for realwage_hourly
sum realwage_hourly if treated == 0 & post == 0
sum realwage_hourly if treated == 1 & post == 0
sum realwage_hourly if treated == 0 & post == 1
sum realwage_hourly if treated == 1 & post == 1

regress realwage_hourly post, cluster(state)

binscatter realwage_hourly year, by(treated) discrete linetype(connect) xline(1962 1965)

areg realwage_hourly ib1961.year##treated,  cluster(state) a(state) 

coefplot ,vertical keep(*.year#1.treated) omit base rename(*.year#1.treated="") ///
xlabel(,angle(45)) nolabels color(black) plotregion(color(white)) graphregion(color(white)) ///
ytitle("Hourly Real Wage") xtitle("Year") xline(8 11, lpattern(dash)) ///
level(95) ylabel(-0.6(.2)0.6) yscale(r(-.6,.6))

/// for domestic_seasonal

sum domestic_seasonal if treated == 0 & post == 0
sum domestic_seasonal if treated == 1 & post == 0
sum domestic_seasonal if treated == 0 & post == 1
sum domestic_seasonal if treated == 1 & post == 1

regress domestic_seasonal post, cluster(state)

binscatter domestic_seasonal year, by(treated) discrete linetype(connect) xline(1962 1965)

areg domestic_seasonal ib1961.year##treated,  cluster(state) a(state) 

coefplot ,vertical keep(*.year#1.treated) omit base rename(*.year#1.treated="") ///
xlabel(,angle(45)) nolabels color(black) plotregion(color(white)) graphregion(color(white)) ///
ytitle("US Domestic Seasonal Employed") xtitle("Year") xline(8 11, lpattern(dash)) ///
level(50) ylabel(-10000(5000)10000) yscale(r(-10000,10000))

/// for tomatoes_total
regress tomatoes_total post, cluster(state)

/// for asparagus_total 
regress asparagus_total post, cluster(state)

clear
use "\\cnsdisk.austin.utexas.edu\home\emm4376\Downloads\Tomatoes.dta" 

binscatter tomato_mech year, by(state) discrete linetype(connect) xline(1962 1965)
