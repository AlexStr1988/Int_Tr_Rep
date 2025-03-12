* In this file I deal with the data structuring for regressions. For this purpose, I use 4 different files which were prepared using Excel.
*These 4 files contain information on Exports (exp), Imports (imp), Output (out), Production Index (prod_in).
* The following steps represent the data structuring steps.

*1. Working with exports first

import excel using "C:\Users\strek\Desktop\TTU Studies\2025\Spring\International Trade\Replication\stata\initial\OECD_data.xlsx", clear firstrow

* Making names of column names in lower letters
ds
foreach var in `r(varlist)' {
    rename `var' `=lower("`var'")'
}

* Making names of each country name and partner name in lower letters
replace cou = lower(cou)
replace flw = lower(flw)
replace par = lower(par)

drop reportingcountry


*Working with the string data 
encode cou, generate(country)
encode flw, generate(flw1)
encode par, generate(par1)
encode industry, generate(ind1)
*encode industry, generate(ind_des)


* Aggregating exports for each country
collapse (sum) obs_value, by(country industry par1)


*Renaming industries to make them shorter
replace industry = "agr" if industry == "Agriculture, forestry and fishing [A]"
replace industry = "man" if industry == "Manufacturing [C]"
replace industry = "min" if industry == "Mining and quarrying [B]"
replace industry = "pu" if industry == "Electricity, gas, steam and air conditioning supply [D]"

*Renaming exports
rename obs_value exp


*Multiplying each data point in exp by 1000 to get value in dollars:
replace exp = exp * 1000


*Saving the file with aggregated exports
save "C:\Users\strek\Desktop\TTU Studies\2025\Spring\International Trade\Replication\stata\initial\OECD_Exports_Aggregated1.dta", replace


*2. Working with the file on productivity index from the previous step (making it suitable for merging the files)
import excel using "C:\Users\strek\Desktop\TTU Studies\2025\Spring\International Trade\Replication\stata\PDLresults.xlsx", clear firstrow

*Deliting unnessasary data columns
drop bus con dwe fin oth pub tra trd

*Re-formating country names in lower letters
replace Country = lower(Country)

*Re-formatting the string data
encode Country, generate(country)

*Formatting data for future reshaping from the wide to a long format
rename(agr man min pu) (obs_valagr obs_valman obs_valmin obs_valpu)


*Fromatting for the long format
reshape long obs_val, i(country) j(industry) string

*Renaming for future convenience
rename obs_val prod_in


*Merging two files - Exports+Prod index
merge m:m country industry using "C:\Users\strek\Desktop\TTU Studies\2025\Spring\International Trade\Replication\stata\initial\OECD_Exports_Aggregated1.dta"

drop _merge
drop Country

*saving the final 
save "C:\Users\strek\Desktop\TTU Studies\2025\Spring\International Trade\Replication\stata\initial\OECD_Exp_In1.dta", replace



*3. Working with Imports data
import excel using "C:\Users\strek\Desktop\TTU Studies\2025\Spring\International Trade\Replication\stata\initial\OECD_imports.xlsx", clear firstrow

* Making names of column names in lower letters
ds
foreach var in `r(varlist)' {
    rename `var' `=lower("`var'")'
}

* Making names of each country name and partner name in lower letters
replace cou = lower(cou)
replace flw = lower(flw)
replace par = lower(par)


*Working with the string data 
encode cou, generate(country)
encode flw, generate(flw1)
encode par, generate(par1)
encode industry, generate(ind1)
*encode industry, generate(ind_des)


* Aggregating exports for each country
collapse (sum) obs_value, by(country industry par1)


*Renaming industries to make them shorter
replace industry = "agr" if industry == "Agriculture, forestry and fishing [A]"
replace industry = "man" if industry == "Manufacturing [C]"
replace industry = "min" if industry == "Mining and quarrying [B]"
replace industry = "pu" if industry == "Electricity, gas, steam and air conditioning supply [D]"

*Renaming exports
rename obs_value imp

*Multiplying each data point in imp by 1000 to get value in dollars:
replace imp = imp * 1000

*Merging two files - Exports/Prod index + Imports
merge m:m country industry using "C:\Users\strek\Desktop\TTU Studies\2025\Spring\International Trade\Replication\stata\initial\OECD_Exp_In1.dta"

drop _merge

save "C:\Users\strek\Desktop\TTU Studies\2025\Spring\International Trade\Replication\stata\initial\OECD_Exp_PIn_Imp1.dta", replace


*4. Working with RD data
import excel using "C:\Users\strek\Desktop\TTU Studies\2025\Spring\International Trade\Replication\stata\initial\OECD_RD.xlsx", clear firstrow

* Making names of column names in lower letters
ds
foreach var in `r(varlist)' {
    rename `var' `=lower("`var'")'
}

* Making names of each country name and partner name in lower letters
replace cou = lower(cou)


*Working with the string data 
encode cou, generate(country)


*Renaming industries to make them shorter
replace industry = "agr" if industry == "Agriculture, forestry and fishing"
replace industry = "man" if industry == "Manufacturing"
replace industry = "min" if industry == "Mining and quarrying"
replace industry = "pu" if industry == "Electricity, gas, steam and air conditioning supply; Water supply; sewerage, waste management and remediation activities"

*Renaming exports
rename obs_value rd

*Multiplying each data point in imp by 1000 to get value in dollars:
replace rd = rd * 1000000

drop cou

*Summing up the "duplicates" for industries
collapse (sum) rd, by(country industry)

*Merging two files - Exports/Prod index + Imports
merge m:m country industry using "C:\Users\strek\Desktop\TTU Studies\2025\Spring\International Trade\Replication\stata\initial\OECD_Exp_PIn_Imp1.dta"

drop _merge

save "C:\Users\strek\Desktop\TTU Studies\2025\Spring\International Trade\Replication\stata\initial\OECD_Exp_PIn_Imp_RD1.dta", replace


*5. Working with Output data
import excel using "C:\Users\strek\Desktop\TTU Studies\2025\Spring\International Trade\Replication\stata\initial\OECD_Out.xlsx", clear firstrow

* Making names of column names in lower letters
ds
foreach var in `r(varlist)' {
    rename `var' `=lower("`var'")'
}

* Making names of each country name and partner name in lower letters
replace cou = lower(cou)


*Working with the string data 
encode cou, generate(country)


*Renaming industries to make them shorter
replace industry = "agr" if industry == "Agriculture, forestry and fishing"
replace industry = "man" if industry == "Manufacturing"
replace industry = "min" if industry == "Mining and quarrying"
replace industry = "pu" if industry == "Electricity, gas, steam and air conditioning supply"

*Renaming exports
rename obs_value out

*Multiplying each data point in imp by 1000 to get value in dollars:
replace out = out * 1000000

drop cou


*Merging two files - Exports/Prod index/RD + Output
merge m:m country industry using "C:\Users\strek\Desktop\TTU Studies\2025\Spring\International Trade\Replication\stata\initial\OECD_Exp_PIn_Imp_RD1.dta"

drop _merge
encode industry, generate(indus)
drop industry

save "C:\Users\strek\Desktop\TTU Studies\2025\Spring\International Trade\Replication\stata\initial\OECD_Final1.dta", replace


*Generating required variables
gen ipr = imp/(out+imp-exp)
gen cor_exp = exp/(1-ipr)

gen log_exp = ln(exp)
gen log_imp = ln(imp)
gen log_cor_exp = ln(cor_exp)
gen log_rd = ln(rd)
gen log_out = ln(out)
gen log_prod_in = ln(prod_in)



*Creating dummy variables
*tabulate country, generate(c_dummy)
*tabulate par1, generate(par_dummy)
*tabulate indus, generate(in_dummy)	
*drop c_dummy
*drop par_dummy in_dummy

*Cleaning up the data space:
drop exp imp prod_in rd out cor_exp

*foreach var1 of varlist c_dummy* {
		*foreach var2 of varlist i_dummy* {
			*quietly: generate alpha`var1'`var2'=`var1'*`var2'
			*}
		*}

			*foreach var1 of varlist in_dummy* {
		*foreach var2 of varlist i_dummy* {
			*quietly: generate beta`var1'`var2'=`var1'*`var2'
		*}
	*}


*Regressing OLS log_exp
eststo: quietly regress log_exp i.country##i.par1 i.indus##i.par1 log_prod_in

*Regressing OLS log_cor_exp
eststo: quietly regress log_cor_exp i.country##i.par1 i.indus##i.par1 log_prod_in

*Regressing IV:

eststo: quietly ivregress 2sls log_exp i.country##i.par1 i.indus##i.par1 (log_prod_in = log_rd) , robust first noomitted

eststo: quietly ivregress 2sls log_cor_exp i.country##i.par1 i.indus##i.par1 (log_prod_in = log_rd), robust first noomitted
	
*Outputting the table with results	
esttab using Table_3_results.csv, replace r2 se keep(log_prod_in)



