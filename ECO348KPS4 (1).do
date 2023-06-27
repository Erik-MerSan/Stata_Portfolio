use "\\cnsdisk.austin.utexas.edu\home\emm4376\Downloads\LotteryExample.dta"

regress test_score attends

regress test_score attends ability parent_income

ivregress 2sls test_score (attends = lottery), r

regress test_score lottery, r
regress attends lottery, r

tab high_ability
ivregress 2sls alt_score (attends = lottery), r
regress alt_score lottery, r
regress attends lottery, r
