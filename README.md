# Introduction
This project analyzes population density data for various Central Business Districts (CBDs) in New Zealand using telecommunications data. The goal is to visualize population trends and create maps for Auckland, Wellington, and Christchurch. The project utilizes R for data cleaning, analysis, and visualization.

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
## 1. Importing Data
Before we start with the project, the data gets imported into R.
XXXX is responsible for importing the data we need. Some require functions inorder to read the data as they are not all in CSV files

## 2. Cleaning Data
XXXX is responsible for cleaning the telecommunications data. We remove any duplicates and NA values within the data.
XXXX cleans the data by also removing any unecessary columns and data points that aren't relevant to the CBD

## 3. Creating visualizations
XXXX creates maps using leaflet which shows the Central Business district areas according to the internet
XXXX uses Data from StatNZ to help show the specific SA2 codes the Central Business District is comprised of
XXXX creates bar charts to visually show the cellphone data within a particular Statistical Area #WORK ON THIS#
XXXX creates a line graph which shows the trends of the cellphone data over time #WORK ON THIS#

# Contributors


