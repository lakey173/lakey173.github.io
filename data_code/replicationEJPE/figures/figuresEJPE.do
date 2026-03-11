clear all 

glo path "C:\Dropbox\covid\replicationEJPE\"
cd "$path\figures"


/*
generate maps 
download the county shapfile from Census of Bereau: 
https://www.census.gov/geographies/mapping-files/time-series/geo/carto-boundary-file.2017.html
The file name: cb_2017_us_county_500k.zip  
*/
grmap, activate 

** First Step: prepare the variables used to generate the map
use "$path\data\estimationDataset.dta", clear
	
drop if fipstate == "15" 
* exclude the state Hawaii

loc votingVars "d_pres2020RepShare_2party d_pres2016RepShare_2party"	
loc tradeWarVars "TS3_US TS3_R agSubs_mfp_pw"
loc healthInsurance "d_healthInsurance healthInsurance"
loc covidVars "d_UR_oct cases_ave cases_oct_ave_adj cases_14dayAve_adj_max deaths_ave deaths_oct_ave_adj deaths_14dayAve_adj_max mei_ave mei_oct_ave mei_14dayAve_cases_adj_max mei_14dayAve_deaths_adj_max visits_relative_cumulative visits_change_relative_oct visits_rel_cases14_adj visits_rel_deaths14_adj meat restot"	
	
keep county_fips county stateAbb votesPres2020Total `votingVars' `tradeWarVars' `healthInsurance' 	`covidVars'
	
rename county_fips fips
	
save "map.dta", replace
	

	
** Get the US county shapefile ready	
spshape2dta "cb_2017_us_county_500k.shp", saving("usacounties") replace

use "usacounties.dta", clear

g fips = STATEFP + COUNTYFP

keep _ID _CX _CY GEOID fips

mmerge fips using "map.dta",type(1:1)
	* All non m=3 are m=1 and all are AK, HI or non-states (e.g. GU, PR, ...)
keep if _m==3
drop _m
	
xtset, clear
spset, modify shpfile(usacounties_shp)



********************************************************************************
***************************** PAPER GRAPHS *************************************
********************************************************************************


****************
*** Figure 1 ***
****************

loc fig2vars "`votingVars' `tradeWarVars' d_healthInsurance"
format (`fig2vars') %12.1f

foreach v in `fig2vars' {
grmap `v', clnumber(9) fcolor(Blues)		
		
gr_edit .legend.Edit, style(rows(2)) style(cols(0)) keepstyles 
gr_edit .legend.Edit, style(labelstyle(size(8-pt)))
// legend edits

gr_edit .style.editstyle aspect_pos(north) editcopy
gr_edit .style.editstyle declared_ysize(2.5) editcopy
gr_edit .SetAspectRatio 0.58
gr_edit .style.editstyle declared_xsize(3.75) editcopy
// Graph edits

gr_edit .legend.DragBy -13 0
// legend reposition

graph export "`v'.png", as(png) replace
}


*******************************
*** Figure 1 (same cutoffs) ***
*******************************

loc fig2varsAlt "d_pres2016RepShare_2party TS3_R agSubs_mfp_pw"
loc d_pres2016RepShare_2party_cut "-8.1 -3.3 -2.2 -1.5 -0.9 -0.3 0.3 0.9 2.0 24.3"
loc TS3_R_cut "0 0.1 0.3 0.4 0.6 0.8 1.1 1.4 2.1 22.9"
loc agSubs_mfp_pw_cut "0 0.1 0.3 0.4 0.6 0.8 1.1 1.4 2.1 15.9"

 
foreach v in `fig2varsAlt' {
grmap `v', clmethod(custom) clbreaks(``v'_cut') fcolor(Blues)
		
gr_edit .legend.Edit, style(rows(2)) style(cols(0)) keepstyles 
gr_edit .legend.Edit, style(labelstyle(size(8-pt)))
// legend edits

gr_edit .style.editstyle aspect_pos(north) editcopy
gr_edit .style.editstyle declared_ysize(2.5) editcopy
gr_edit .SetAspectRatio 0.58
gr_edit .style.editstyle declared_xsize(3.75) editcopy
// Graph edits

gr_edit .legend.DragBy -13 0
// legend reposition

graph export "`v'Alt.png", as(png) replace
}



****************
*** Figure 2 ***
****************

loc fig1vars "deaths_ave cases_ave"
format (`fig1vars') %12.1f

foreach v in `fig1vars' {
grmap `v', clnumber(9) fcolor(Blues) ///
name(`v', replace)
		
gr_edit .legend.Edit, style(rows(2)) style(cols(0)) keepstyles 
gr_edit .legend.Edit, style(labelstyle(size(8-pt)))
// legend edits

gr_edit .style.editstyle aspect_pos(north) editcopy
gr_edit .style.editstyle declared_ysize(2.5) editcopy
gr_edit .SetAspectRatio 0.45
gr_edit .style.editstyle declared_xsize(5) editcopy
// Graph edits

gr_edit .legend.DragBy -11 0
// legend reposition
		
graph export "`v'.png", as(png) replace
}


*****************
*** Figure A1 ***
*****************

loc fig1vars "deaths_ave cases_ave cases_oct_ave_adj cases_14dayAve_adj_max deaths_oct_ave_adj deaths_14dayAve_adj_max"
format (`fig1vars') %12.1f

foreach v in `fig1vars' {
grmap `v', clnumber(9) fcolor(Blues)		
		
gr_edit .legend.Edit, style(rows(2)) style(cols(0)) keepstyles 
gr_edit .legend.Edit, style(labelstyle(size(8-pt)))
// legend edits

gr_edit .style.editstyle aspect_pos(north) editcopy
gr_edit .style.editstyle declared_ysize(2.5) editcopy
gr_edit .SetAspectRatio 0.58
gr_edit .style.editstyle declared_xsize(3.75) editcopy
// Graph edits

gr_edit .legend.DragBy -13 0
// legend reposition


graph export "`v'_Appendix.png", as(png) replace
}


*****************
*** Figure A2 ***
*****************

loc fig1vars "mei_ave visits_relative_cumulative d_UR_oct"
format (`fig1vars') %12.1f

foreach v in `fig1vars' {
grmap `v', clnumber(9) fcolor(Blues)		
		
gr_edit .legend.Edit, style(rows(2)) style(cols(0)) keepstyles 
gr_edit .legend.Edit, style(labelstyle(size(8-pt)))
// legend edits

gr_edit .style.editstyle aspect_pos(north) editcopy
gr_edit .style.editstyle declared_ysize(2.5) editcopy
gr_edit .SetAspectRatio 0.58
gr_edit .style.editstyle declared_xsize(3.75) editcopy
// Graph edits

gr_edit .legend.DragBy -13 0
// legend reposition


graph export "`v'.png", as(png) replace
}

clear all 

* Daily mean mei across counties
use "$path\data\socialDistancing.dta", replace
collapse (mean) mei_14dayAve, by(dt)
 
generate t = date(dt, "YMD")
format %td t
tsset t

	tsline mei_14dayAve, /// 
		ytitle("MEI (14 Day Average)") ///
		ylabel(20 0 -20 -40 -60 -80 -100) ///
		xtitle(" ") ///
		tlabel(01jan2020 01feb2020 01mar2020 01apr2020 01may2020 01jun2020 01jul2020 01aug2020  01sep2020 01oct2020, format(%tdm)) /// 
		title("Mobility and Egagement Index") ///
		subtitle("Mean Across Counties") ///
		tline(12mar2020)

gr_edit .style.editstyle declared_ysize(2.5) editcopy
gr_edit .style.editstyle declared_xsize(3.75) editcopy
		
		
		graph export "MEI.png", as(png) replace




* Monthly mean relative foot traffic across counties
use "$path\data\footTraffic.dta", clear
collapse (mean) visits_change_relative1 visits_change_relative2 visits_change_relative3 visits_change_relative4 visits_change_relative5 visits_change_relative6 visits_change_relative7 visits_change_relative8 visits_change_relative9 visits_change_relative10

gen index =1
reshape long visits_change_relative, i(index) j(t)
drop index
tostring t, replace
forval i=1/10{
	replace t = "2020-`i'-01" if t == "`i'" 
}
generate date = date(t, "YMD")
format %tdmyy date
tsset date

	tsline visits_change_relative, ///
		ytitle("YoY Growth Relative to Jan-Feb") ///
		ylabel(0.2 0.4 0.6 0.8 1 1.2) ///
		xtitle(" ") ///
		tlabel(01jan2020 01feb2020 01mar2020 01apr2020 01may2020 01jun2020 01jul2020 01aug2020  01sep2020 01oct2020, format(%tdm)) ///
		title("Foot Traffic Cumulative Relative Growth") ///
		subtitle("Mean Across Counties") 

gr_edit .style.editstyle declared_ysize(2.5) editcopy
gr_edit .style.editstyle declared_xsize(3.75) editcopy
	
		graph export "FootTraffic.png", as(png) replace


* Monthly mean change in UR across counties
use "$path\data\unemployment.dta", clear
foreach t in 01 02 03 04 05 06 07 08 09 10 {
gen dUR_`t'_janFeb=unemploymentRate`t'20-(1/2)*(unemploymentRate0120+unemploymentRate0220)
}
collapse (mean) dUR_01_janFeb dUR_02_janFeb dUR_03_janFeb dUR_04_janFeb dUR_05_janFeb dUR_06_janFeb dUR_07_janFeb dUR_08_janFeb dUR_09_janFeb dUR_10_janFeb

gen index=1
rename (dUR_01_janFeb dUR_02_janFeb dUR_03_janFeb dUR_04_janFeb dUR_05_janFeb dUR_06_janFeb dUR_07_janFeb dUR_08_janFeb dUR_09_janFeb dUR_10_janFeb)(dUR1 dUR2 dUR3 dUR4 dUR5 dUR6 dUR7 dUR8 dUR9 dUR10)
reshape long dUR, i(index) j(t)
drop index
tostring t, replace
forval i=1/10{
	replace t = "2020-`i'-01" if t == "`i'" 
}
generate date = date(t, "YMD")
format %tdmyy date
tsset date

	tsline dUR, ///
		ytitle("Change Relative to Jan-Feb") ///
		ylabel(-2 0 2 4 6 8 10) ///
		xtitle(" ") ///
		tlabel(01jan2020 01feb2020 01mar2020 01apr2020 01may2020 01jun2020 01jul2020 01aug2020 01sep2020 01oct2020, format(%tdm)) ///
		title("Unemployment Rate Change in 2020") ///
		subtitle("Mean Across Counties") 

gr_edit .style.editstyle declared_ysize(2.5) editcopy
gr_edit .style.editstyle declared_xsize(3.75) editcopy
		
		graph export "Unemployment.png", as(png) replace


