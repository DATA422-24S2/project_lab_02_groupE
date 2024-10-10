# Introduction
This project analyzes population density data for various Central Business Districts (CBDs) in New Zealand using telecommunications data. The goal is to visualize population trends and create maps for Auckland, Wellington, and Christchurch. The project utilizes R for data cleaning, analysis, and visualization. The purpose of this project is to provide insights for the appropriate period to do roadworks in Auckland, Wellington and Christchurch.

The project aims to answer these key questions:
• Does it make sense to plan roadworks for school holidays in CBD areas ?
• Which days are best if roadworks must be completed during the day ?
• Are there any geographical differences between CBDs we must be aware of ?

# Technologies
This project was created using:
R Version 4.4.1 
RStudio

# Setup
To run this project, you must download all the files within the github repository 
https://github.com/DATA422-24S2/project_lab_02_groupE.git # Repository link
Clone the repository
- Go to the repository on GitHub and copy the repository URL.
- In RStudio, go to `File > New Project > Version Control > Git`.
- Paste the repository URL and select a local folder to clone the repository.


# Data sources
The data used was provided by the DATA201/422 teachers and tutors.
sa2_2023.csv contains Statistical area codes with their area names

sa2_ta_concord_2023.csv contains Statistical area codes with their area names and Territorial area codes with their area names

sp_data.csv.gz contains Spark telecommunications data that must be cleaned

subnational_pop_ests.csv contains the obversation values (population) of each SA2 code

urban_rural_to_indicator_2023.csv contains urban codes, their area names and whether they are Rural or Urban settlements

urban_rural_to_sa2_concord_2023.csv contains the SA2 codes and their area names, the corresponding urban codes and their settlement types

vf_data.parquet contains Vodafone telecommunications data that must be cleaned

![image](https://github.com/user-attachments/assets/62bbfffc-befb-41a7-9328-3a4bac71ef1b)

Data from StatNZ was used to generate maps for CBD regions via their SA2 Codes. The link is as follows: https://datafinder.stats.govt.nz/layer/111227-statistical-area-2-2023-generalised/

# Scripts overview
### All these scripts should be ran. run.R contains all of the necessary scripts to run
## 1. Importing necessary packages
Before we start with the project, the necessary packages must be imported to ensure the project works correctly

00_initialise.R is responsible for importing the packages we need. Run this function
## 2. Importing files
01_import.R imports all of the required files by sourcing 'read' and 'initialise' files. The files get read and put in a dataframe.
The rscripts being sourced in this file read the raw datasets and return them in a usable dataframe for future use.

## 3. Cleaning the data
02_clean.R is responsible for cleaning the data by removing any extra columns, duplicated values, na values etc.
  
David Ewing (82171165 – dew59 ),  is responsible for cleaning the telecommunications data. We remove any duplicates and NA values within the data.

Telecommunication data require functions to retrieve the data from different formats (parquet and gz)

Example: The sourced file 002_clean_files removes any NA values and ensures the necessary columns are named, and others are removed

## 4. Analysing the data
03_analyse.R helps with getting the necessary data to do analysis with. It involves getting the correct SA2 Codes for the required CBD's; Auckland, Wellington and Christchurch.

This script runs a function to join the celldata coming from the sp and vf data with the SA2 data to make ggplots.

The rscripts that obtain the SA2 codes for each individual CBD e.g 001_auckland_cbd_df.R require a shapefile which can be downloaded from the StatNZ website (provided in the Data Sources section)

## 5. Visualising the data
04_visualise.R is where all of the visualisations for graphs occur using the data from the analyzed files. Maps are created in this file. To call it, copy the line of code below the source functions. To see how it looks, just remove the hashtags in the 04_visualise.R file.

Maps created: A leaflet map is created to show the general boundary of the CBD. This also allows the user to see what the boundary looks like in an actual interactive map.

A ggplot map is created to show the SA2 regions contained within the boundary along with their code. 

Example of the scripts being ran: 000_auckland_cbd.R takes the CBD data from the previous script ran (03_analyse.R) and creates a ggplot map based on the SA2 codes

## 6. Exporting the data
05_export.R exports the data to ...

# Contributors
David Ewing

Ann Benji

Brayden Davies

Matthew Madriaga

