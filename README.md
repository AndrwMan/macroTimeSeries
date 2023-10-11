# macroTimeSeries : Macroeconomic Time Series analysis
2 papers involving modeling and inference on macroeconomic data. The first describes the process of selecting appropriate ARMA model specifications to fit a country's economic data. It does so by analyzing autocorrelation and partial autocorrelation components in the data and evaluates the goodness of fit using Akaike and Bayesian info criteria. Additionally, the paper assesses the assumptions of the ARMA model by examining the residuals. 
The second justifies and applies of Vector Autogression to determine causality between economic indicators of a country. It does so by specifying a model that captures the interdependencies between indicators and analyzes the impact of shocks to one indicator on the other with Impulse response functions. Additionally, vary parameters and evaluate results to determine if our conclusion would change.

## Motivation
* Complete projects that involve all 3 components of data science: computer science (programming), statistics (time series), and domain knowledge (economic data)
* Pratice with data science scripting lang that is not python
* Eventually set up the R Markdown (R analog to Jupyter Notebooks)
* Exposure to writing academic papers

## Usage 
The current project initialization process involves the following: 

### Project Creation
0. 
1. Ensure that all data is in the same directory where .R file is. Then just open RStudio > "File" > "New Project" > "Existing Directory" > Navigate to & select "<boxJenkins/vecAR dir>". Rproj and other artifacts will be created.   
2. Ctrl + A > "Run" to run all.

### Dependency Installation
* Not needed the `library(<lib>))` statements will get the needed packages the first time code is ran. 

### Configuration
* In boxJenkins.R:
  * Modify `models` list to the models you want to test. 
  * Modify `selected_model <- models[[<desiredIdx>]]` where <desiredIdx> is the (best) model you want to see the plots for.
* In vecAR.R:
  *    

## License
**Copyright (c) [Andrew Man] [2019-2023]. All Rights Reserved.**
