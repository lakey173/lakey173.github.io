*************************************************************************************
* The 2020 US Presidential election and Trump's wars on trade and health insurance	*
* James Lake and Jun Nie   								            *
*************************************************************************************

PLEASE CITE AS:
Please cite as “Lake, J. & Nie, J. (2023), “The 2020 US Presidential election and Trump's wars on trade and health insurance”, European Journal of Political Economy.

Note: Only changes from version 1 replication package published 7 Dec 2022 are the paths in 
	- lines 12, 14 and 23 of [estimation]/regressionsEJPE.do 
      - line 16 of [figures]/figuresEJPE.do 

INSTRUCTIONS FOR USE OF ONLINE DATA REPOSITORY:

The main directory contains the following files and folders:

- [data]: 		Contains estimationDataset.dta used to run the regressions and generate tables and figures. Also contains footTraffic.dta, socialDistancing.dta
			and unemployment.dta used to generate figures.
- [estimation]: 	Contains regressions_EJPE.do which generates all regression tables using [data]/estimationDataset.dta. 
			Tables will be saved in [estimation] in the log file tradeWarCovid_v0.9_EJPE.log. 
			Table 4 is in the excel file Table4.xlsx and refers to various excel files in this folder created from regressions_EJPE.do. 
			You will need to update the path in the cells in Table4.xlsx to pull in the data from the various excel files.
- [figures]: 	Contains figuresEJPE.do that generates all figures in the paper using estimationDataset.dta, footTraffic.dta, socialDistancing.dta
			and unemployment.dta.
			Figures will be saved in [figures].
			Also contains figuresEJPE.docx which contains all figures from the paper.
			Also contains cb_2017_us_county_500k.shp and cb_2017_us_county_500k.dbf used to make the map graphs using the command - grmap -  
- readme.txt

To replicate the entire paper:

1. Run [estimation]/regressions_EJPE.do
	- You will need to update the path on line 12. 
	- The summary statistics table (Table A1) and the regression tables (Tables 3, 5-8, and A2) will be sent to the log file [estimation]\tradeWarCovid_v0.9_EJPE.log.
	- The counterfacutuals table (Table 4) is [estimations]\Table4.xslx and uses various excel files created by regressions_EJPE.do and stored in [estimation].
	  You will need to update the path in the cells of Table4.xslx.

2. Run [figures]\figuresEJPE.do.
	- You will need to update the path in line 3.
	- The figures will be stored in [figures].
	- A pre-existing copy of all figures is stored in figuresEJPE.docx
