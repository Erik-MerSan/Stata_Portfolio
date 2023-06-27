use "/Users/emm4376/Downloads/ClassSizeRKD.dta"

keep if cohsize < 80

generate above40 = cohsize > 40
generate center40 = (cohsize != 40)

regress num_classrooms above40##center40 if abs(cohsize) <= 40, cluster(coh_id)
regress classize above40##center40 if abs(cohsize) <= 40, cluster(coh_id)

regress avgscore above40##center40 if abs(cohsize) <= 40, cluster(coh_id)

use "/Users/emm4376/Downloads/SpeedDiscount.dta"

regress discount white lenient white##lenient i.year, a(countynum) r

regress discount female##lenient i.year, a(countynum) r
regress discount c.age##lenient i.year, a(countynum) r 
regress discount above25k##lenient i.year, a(countynum) r
regress discount anytix##lenient i.year, a(countynum) r
areg discount blackmale##lenient blackfemale##lenient hispmale##lenient hispfemale##lenient whitefemale##lenient i.year, a(countynum) r
