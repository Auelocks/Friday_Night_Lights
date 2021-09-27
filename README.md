# Friday_Night_Lights

## Contents
- [Project Objective](#objective)
- [Files](#files)
- [Team Protocols](#team-communication-protocols)
- [Overview of the Project](#overview)
- [Dataset](#dataset)
- [Machine Learning Model](#machine-learning-model)
- [K-Means Clustering](#k-means)

## Objective
Use machine learning to determine key factors for successfully producing wells in the Permian Basin via a quantitative & statistical analysis of producing horzitonal wells.

## Files
### Python Code
- MB_WellDistCalc.ipynb - Python code for calculating well spacing from lat-long data
- Permian_ML_Model_Final - Python code that contains the final machine learning models
- Permian_KMeans - Python code that uses K-means algorithm for determining rock type from geologic inputs

### Input Data
- Resources\FNL_DataSet_For_Import.csv - File with most of the data inputs
- Resources\Well Distance_Recalc.csv - Calculated well spacing output
- Resources\FNL_Well Data Schema.sql - Schema for main SQL database creation
- Resources\FNL_Distance Data Schema.sql - Schema for distance table creation
- Resources\Join_Update_Query.sql - Query to join main data table and distance table
- Resources\k_means_output.csv - Output file with K-Means results

Other miscellaneous queries for table creation and join are also present in the Resouces folder

### Dashboard and Slides Link
- Dashboard: [Friday Night Ligts Dashboard](https://public.tableau.com/app/profile/david.mcadoo/viz/Group9FridayNightLightsDashboard/Dashboard2?publish=yes)
- Slides: [FNL Slide Deck](https://docs.google.com/presentation/d/1jJQ8uUfvLbrSyeU119UbeOl3c2PDQfh82_HQJHRISkI/edit#slide=id.gf2f1268256_3_112)

## Overview

For decades, scientists and engineers have studied complex geology, reservoir properties and various production strategies to identify factors most associated with successful reservoir production.  This study is designed to evaluate a large dataset of reservoir properties along with historical well production data to build a machine-learning model that can be used to determine optimal number of wells and completion (or "frac") design for successful long-term production. Production is determined by gross EUR (Expected Ultimate Recovery) which is a forecast of the maximum recoverable production over the life of the well. 
 
## Dataset

Data for the project is sourced from IHS Enerdeq which includes:
(1) Header data: several well identifiers and location information for the wells
(2) Independent input variables: well length (also called lateral length), proppant and fluid volume (frac design), well spacing (distance between wells), geologic parameters like porosity and oil saturation that determine the amount of oil present initially (original oil in place)
(3) Dependent variable - Oil EUR (forecasted from historical oil production data) which is the maximum amount of oil recoverable from a given well.

Well spacing was calculated using lat-long data with a separate Python code developed for this purpose.

All static data is stored using PostgreSQL where tables are imported from CSV files and joined into a primary table with all well data using the unique well id.


## Machine Learning Model
### Model Overview
The independent variable list is made up of several continuous numeric variables and at least two categorcial variables. The dependent variable (EUR) is a continuous variable. Based on an assessment of the dataset, the team chose to start with a multiple linear regression (MLR) model. The goal of MLR is to model the linear relationship between the independent variables and one or more dependent response variables. 

### Data Cleaning
The team followed a structured data preprocessing effort to eliminate unwanted variables (ID, names etc.) and also remove rows that did not contain key input variables or the response variable. Also, the team employed min and max cutoffs on both input and response variables based on professional experience and proficiency with the subject. A histogram and box plot of the response variable shows a small population of outliers that were eventually eliminated. While this resulted in several rows being eliminated, the final dataset contained over 6000 rows of fully populated data. 

![Histogram](Resources/Model_Output_Images/OilRF_Histogram.png)

![Box Plot](Resources/Model_Output_Images/OilRF_BoxPlot.png)


### Variable Selection
Step 1: The team started by cross-plotting each of the independent variables against the response variable to observe any discernible correlation. However, the complex nature of oilfield geology and the presence of multiple explanatory variables resulted in little to no observable correlation between variables.
Step 2: The next step was to cross-plot independent variables against each other to ensure there are no multi-collinearity issues. Some variables were eliminated this way. For example, frac fluid volume and proppant volume were strongly correlated and hence proppant was excluded from the list (see image below).

![Fluid-Proppant](Resources/Model_Output_Images/Fluid_vs_Proppant.png)


Step 3: Encoding of categorical variables (see secion on encoding below)
Step 4: The next step was to generate statistics and p-values on the independent variables to determine statistically significant variables and check for potential collinearity issues. The results of an ordinary least squares (OLS) model are shown below.

![OLS](Resources/Model_Output_Images/OLS_Regression_Results.png)

It can be seen that the p-values of most variables are less than 0.05, indicating that they are statistically significant. Some variables with high p-values were omitted in the final model. A statement in the footnote suggests multicollinearity issues based on the smallest eigen value. However, the  team was unable to determine the variables that could be the cause of this issue.
Step 5: The next step was to create train and test datasets and run the regression model. The results  of the model are shown below.

![Linear Regression](Resources/Model_Output_Images/Lin_Reg_Results.png)

The mean percentage error in the model is 27%, suggesting a poor quality dataset or presence of other independent variables that have not been accounted for. The latter is a more plausible explanation, as several geologic parameters were not available to the team from the public realm. Plot below shows an r^2 of 0.4 for values predicted by the model compared to the actual.

![Actual_Predicted](Resources/Model_Output_Images/Actual_vs_Predicted.png)

Step 6: Several efforts were made to improve the model results by incorporating rock typing using K-Means clustering (see section on K-Means) as a separate variable and also building separate models for each of the different rock types. However, none of these efforts seemed ot improve the model quality or output.

### Categorical Variable Treatment
Since machine learning algorithms cannot operate directly on label data, they need to be converted into numeric data. The team pursued various alternatives to encode the two categorical variables present - Landing Zone (which indicates the subsurface vertical location where the well is drilled) and County (which segregates the wells geographically). 

#### Label Encoding
The first attempt was to label encode the categorical variables. With unsatisfactory results from this attempt, the team switched to One-Hot encoding.

#### One-Hot Encoding
In One-Hot encoding, a binary variable is added in place of each category of the categorical variable. There were a total of 14 dummy variables created for landing zone and county.

### K-Means Clustering
Oil and gas geology follows complex patterns that are dependeent on the depositional systems that were responsible for the formation of the reservoir in question. The team used K-Means clustering to group similar "rock types" in an effort to subdivide the dataset that represents the entire basin. The rock typing was done using key variables like posority, clay volume etc. that determine how rocks vary geologically. A cluster plot of TVD vs GOR is shown below. These two key geologic variables largely influence the ultimate recovery from any given well. 

![K-Means](Resources/Model_Output_Images/K_Means_Clusters.png)

However, the rock type model did not yield results as expected. This was attributed to the lack of other key variables that determine rock type and the potential correlation between the variables used for rock typing and those that were used as inputs in the regression models.

### Other Regression Models
A few other linear and non-linear models like Gradient Boosting and Random Forest regression were attempted in an effort to improve the data. However, the results from the original model were found to give similar results as compared the other models trialed.

### Dashboard
Using Tableau public, we were able to visualize the chaotic and disorganized data set. When grouped by either EUR or landing zone, no discernable trend can be established at the state or even county view. 
