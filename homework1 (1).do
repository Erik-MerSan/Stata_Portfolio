use "\\cnsdisk.austin.utexas.edu\home\emm4376\Downloads\mrc_table1-2.dta"

summarize par_median k_median

corr par_median k_median

keep super_opeid name state par_median k_median

tempfile d1

save `d1', replace

use "\\cnsdisk.austin.utexas.edu\home\emm4376\Downloads\mrc_table10.dta"

keep super_opeid public exp_instr_pc_2000

table public
summarize exp_instr_pc_2000

merge 1:1 super_opeid using `d1'

keep if _merge==3
drop if exp_instr_pc_2000==. | k_median==. | par_median==.
drop if exp_instr_pc_2000==0

summarize

local vars "k_median par_median exp_instr_pc_2000"
foreach var of local vars {
  generate log`var' = log(`var')
}

reg logk_median logexp_instr_pc_2000

scatter logk_median logexp_instr_pc_2000 || lfit logk_median logexp_instr_pc_2000

reg logk_median logexp_instr_pc_2000 logpar_median

reg logexp_instr_pc_2000 logpar_median
predict pred_logexp_instr_pc_2000
predict resid_logexp_instr_pc_2000, residuals
summarize resid_logexp_instr_pc_2000

regress logk_median resid_logexp_instr_pc_2000

xtset public
xtreg logk_median logexp_instr_pc_2000 logpar_median, fe

use "\\cnsdisk.austin.utexas.edu\home\emm4376\Downloads\LibraryCheckoutData.dta"

sum checkouts if checkoutyear==2005
sum checkouts if checkoutyear==2006
sum checkouts if checkoutyear==2007

count if missing(subjects)

table checkoutyear if missing(subjects)

drop if missing(subjects)
drop if missing(title)
drop if missing(checkoutyear)

gen title_oprah=strpos(title, "oprah")>0
regress checkouts title_oprah

gen subject_mystery=strpos(subjects, "mystery")>0
regress checkouts subject_mystery


gen subject_thriller= strpos(subjects,"thriller")>0
gen subject_suspense= strpos(subjects,"suspense")>0
keep if subject_thriller==1 | subject_mystery==1 | subject_suspense==1

drop if missing(checkouts)
drop if checkouts==0

