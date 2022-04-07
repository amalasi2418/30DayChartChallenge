This JIRINEC_MORPHOMETRICS_readme.txt file was generated on 2021-07-07 by Vitek Jirinec


GENERAL INFORMATION

1. Title of Dataset: Morphological consequences of climate change for resident birds in intact Amazonia

2. Author Information
	A. Principal Investigator Contact Information
		Name: Vitek Jirinec
		Institution: Louisiana State University
		Address: Baton Rouge, Louisiana, USA
		Email: vjirin1@lsu.edu

	B. Associate or Co-investigator Contact Information
		Name: Philip Stouffer
		Institution: Louisiana State University
		Address: Baton Rouge, Louisiana, USA
		Email: pstouffer@lsu.edu

	C. Alternate Contact Information
		Name: Thomas Lovejoy
		Institution: George Mason University
		Address: Fairfax, Virginia, USA
		Email: tlovejoy@gmu.edu

3. Date of data collection: 1979 to 2019

4. Geographic location of data collection: 2° 24' 21" S, 59° 52' 25" W

5. Information about funding sources that supported the collection of the data: Please see publication.


SHARING/ACCESS INFORMATION

1. Licenses/restrictions placed on the data: NA

2. Links to publications that cite or use the data: TBD

3. Links to other publicly accessible locations of the data: NA

4. Links/relationships to ancillary data sets: NA

5. Was data derived from another source? Yes.
	A. If yes, list source(s): Climate data derived from the global EU Copernicus ERA5 climate reanalysis (https://cds.climate.copernicus.eu).

6. Recommended citation for this dataset: Jirinec et al. 2021. Morphological consequences of climate change for resident birds in intact Amazonia.


DATA & FILE OVERVIEW

1. File List: Jirinec_etal_morphometrics.csv

2. Relationship between files, if important: NA

3. Additional related data collected that was not included in the current data package: NA

4. Are there multiple versions of the dataset? No


METHODOLOGICAL INFORMATION

1. Description of methods used for collection/generation of data: For general methods overview, see https://doi.org/10.1093/condor/duaa005

2. Methods for processing the data: This dataset contains data used to analyze morphological trends in primary forest. The entire BDFFP bird dataset contains additional captures (fragments, secondary forest), and more details about each capture.

3. Instrument- or software-specific information needed to interpret the data: NA

4. Standards and calibration information, if appropriate: NA

5. Environmental/experimental conditions: Various. Data collected over 40 years.

6. Describe any quality-assurance procedures performed on the data: Records missing both mass and wing measurements, or with mass or wing measurements greater or less than 4 SD from the mean value for the species, were considered errors (identification or measurement) and were dropped.

7. People involved with sample collection, processing, analysis and/or submission: Please see publication for details.

DATA-SPECIFIC INFORMATION FOR: Jirinec_etal_morphometrics.csv

1. Number of variables: 23

2. Number of cases/rows: 15415

3. Variable List: 
species: scientific name
guild: ecological foraging guild
stratum: forest stratum generally occupied
spMeanMass: mean mass for this species across this dataset
spMeanWing: mean wing for this species across this dataset
spMeanMW: mean of mass:wing ratio for this species across this dataset
bn: band number
age: Wolfe-Ryder-Pyle (WRP) age classification system codes
age_group: simplified age categories: juvenile, adult, unknown
timestamp: capture time (YYYY-MM-DD HH:MM:SS) in the local timezone (Manaus, Brazil)
year: year of capture
mass: bird mass (g)
wing: wing chord length (mm)
mw: ratio of mass and wing measurements, if both available
mass_scaled: scaled mass for HMSC models
wing_scaled: scaled wing for HMSC models
mw_scaled: scaled mw for HMSC models
temp_lag0_dry: mean temperature (deg C) for season of capture (dry season)
temp_lag1_wet: mean temperature (deg C) for previous season (wet season)
temp_lag2_dry: mean temperature (deg C) for previous year's dry season
precip_lag0_dry: total precipitation (mm) for season of capture (dry season)
precip_lag1_wet: total precipitation (mm) for previous season (wet season)
precip_lag2_dry: total precipitation (mm) for previous year's dry season

4. Missing data codes: Missing values are "NA".

5. Specialized formats or other abbreviations used: 
<guild>:
AAF: army-ant followers
AW: ant-woodcreeper
GI: gap insectivore
HB: hummingbird
MF: midstory frugivore
MI: midstory insectivore
NGI near-ground insectivore
RI: riparian insectivore
TI: terrestrial insectivore
UF: understory frugivore
UI: understory insectivore
WC: woodcreeper

<stratum>:
MS: midstory
UN: understory
NG: near-ground
TE: terrestrial