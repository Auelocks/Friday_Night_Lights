# Friday_Night_Lights

## Contents
- [Project Objective](#overview)
- [Files](#files)
- [Team Protocols](#team-communication-protocols)
- [Overview of the Project](#overview)
- [Results](#results)
- [Summary](#summary)


## Objective
Use machine learning to determine key factors for successfully producing wells in the Permian Basin via a quantitative & statistical analysis of producing horzitonal wells.

## Files
### Python Code
- MB_WellDistCalc.ipynb - Python code for calculating well spacing from lat-long data
- Permian_ML_Model_OHE_NL_RF_Corr - Python code that contains the final machine learning models
- Permian_ML_Model_OHE_KMeans_RockType - Python code that uses K-means algorithm for determining rock type from geologic inputs
- Permian_ML_Model_Latest_With_RockType - Python code that incorporates rock type calulcted from K-means into the machine learning model

### Input Data
- Resources\FNL_DataSet_For_Import.csv - File with most of the data inputs
- Resources\Well Distance_Recalc.csv - Calculated well spacing output
- Resources\FNL_Well Data Schema.sql - Schema for main SQL database creation
- Resources\FNL_Distance Data Schema.sql - Schema for distance table creation
- Resources\Join_Update_Query.sql - Query to join main data table and distance table

Other miscellaneous queries for table creation and join are also present in the Resouces folder

## Team Communication Protocols

The project was the result of work from four team members who worked remotely.  The team utilized Google Meet and Slack for communication and any scripts or files are delivered through this GitHub repository.

## Overview

For decades, scientists and engineers have studied  complex geology, reservoir properties and various production strategies to identify factors most associated with successful reservoir production.  This study is designed to evaluate a large dataset of reservoir properties along with historical well production data to build a machine-learning model that can be used to determine optimal number of wells and completion (or "frac") design for successful long-term production. Production is determined by gross EUR (Expected Ultimate Recovery) which is a forecast of the maximum recoverable production over the life of the well. 
 
## Dataset

Data for the project is sourced from IHS Enerdeq which includes:
(1) Header data: several well identifiers and location information for the wells
(2) Independent input variables: well length (also called lateral length), proppant and fluid volume (frac design), well spacing (distance between wells), geologic parameters like porosity and oil saturation that determine the amount of oil present initially (original oil in place)
(3) Dependent variable - Oil EUR (forecasted from historical oil production data)

Well spacing was calculated using lat-long data with a separate Python code developed for this purpose.


## Machine Learning Model

A linear regression model is used to investigate the relationships between well data features and the estimated ultimate recovery for gases and oils in the Permian basin data.
