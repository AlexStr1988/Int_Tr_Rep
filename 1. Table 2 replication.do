import excel using "C:\Users\strek\Desktop\TTU Studies\2025\Spring\International Trade\Replication\stata\initial\PDL1.xlsx", clear firstrow

foreach var of varlist agr bus con dwe fin man min oth pu pub tra trd {
    gen `var'1 = 1/`var'
}


foreach var of varlist agr1 bus1 con1 dwe1 fin1 man1 min1 oth1 pu1 pub1 tra1 trd1 {
    gen `var'1 = `var'/ agr1
}

rename (agr11 bus11 con11 dwe11 fin11 man11 min11 oth11 pu11 pub11 tra11 trd11) (Agriculture Business Construction Real_estate Finance Manufacturing Mining Other_services Utilities Government Transport Trade)

foreach var in Agriculture Business Construction Real_estate Finance Manufacturing Mining Other_services Utilities Government Transport Trade {
    replace `var' = round(`var', 0.01)
    format `var' %9.2f
}

export delimited Country Agriculture Business Construction Real_estate Finance Manufacturing Mining Other_services Utilities Government Transport Trade using "C:\Users\strek\Desktop\TTU Studies\2025\Spring\International Trade\Replication\stata\PDLresults.tex", replace

*esttab using "C:\Users\strek\Desktop\TTU Studies\2025\Spring\International Trade\Replication\stata\PDLresults.tex", ///
    cells("Country Agriculture Business Construction Real_estate Finance Manufacturing Mining Other_services Utilities Government Transport Trade") ///
    replace ///
    tex ///



*estout using "C:\Users\strek\Desktop\TTU Studies\2025\Spring\International Trade\Replication\stata\PDLresults.tex", ///
    cells("Country Agriculture Business Construction Real_estate Finance Manufacturing Mining Other_services Utilities Government Transport Trade") ///
    replace ///
    tex ///
    booktabs

