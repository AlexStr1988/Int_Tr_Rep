# ECO 5365: Replication Results for Assignment 1.

## Stata do-files for getting the results 
The replication consists of two Stata files - the first one for getting results for normalized productivity across countries and sectors, another for data management, and running regressions for the final results.

## Step 1
Identify a convenient directory on your laptop and put all related files from GitHub to it.

## Step 2
Open **1. Table 2 replication.do** and update the directory pathways for input and output files. 
This file includes a Stata code which will replicate Table 2 from the paper. 
A **PDLresults.xlsx** file will appear as an output of the code, and it will be further used in the Stata file for replication in Table 3 from the paper.

## Step 3
Open **2.1  Working on OECD data .do** and update the directory pathways for input and output files.  This file utilizes the output from **PDLresults.xlsx** and other related xlsx files with data on exports, imports, R&D, etc. among 22 countries according to the paper. 
The code will perform all necessary data management manipulations and, eventually, will create the **Table_3_results.csv** file which contains results on OLS and IV regressions.

## Step 4
Open **Strekalov_Int_Tr_Rep_Replication Tables.pdf** file to see the replication tables with the results. These tables are presented in a convenient way that were created using LaTex.

## Please note that more detailed information on the steps performed during data management and regression analysis are in the Stata do-file **2.1  Working on OECD data .do**
