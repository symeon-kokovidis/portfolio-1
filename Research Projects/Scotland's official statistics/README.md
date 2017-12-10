### Predicting House Prices in Scotland using official statistics

## Description of the scenario

The aim of this study is to predict the mean house prices of 2001 data zones in Scotland for 2012. 
Our datasets are retrieved from the official statistics portal of Scotland: http://statistics.gov.scot/ .
Datasets may refer to the current year (2012) or to recent past years (2009-2011).
Numerous features have been retrieved, in an exhaustive way, in order to have an abundance of data to estimate our response (mean house prices of 2012).
Several state-of-the-art machine learning methods have been applied in order to reduce that number of features. 
In our case Lasso seemed to offer the best results.
In addition, we have performed repeated simulations in order to have a robust selection of features, not influenced from different sampling methods. 
Then having our new datasets, including only the most descriptive features, we will move to several fitting methods.

## Methodology
### Step 1: Dataset selection

In this first step, we explored the available datasets, measures, dimensions & granularities which can be found in the statistics portal of Scotland. 

Some examples of dimensions are the: gender, reference period, type of dwelling, type of benefit, age group.

Granularity refers to the levels of depth for each dataset. Some examples are the: country, Council Areas, Electoral Wards, Data Zones. 

Data Zones, which has 6500 observations, is our preferable granularity level.






In addition, in order to better specify the extent of our scenario we had to introduce some specific criteria for our scenario. By introducing these criteria we would be able to:

1.	Avoid any faulty assumptions
2.	Restrict the bounds of our problem; specify the depth of detail and have a clear timespan
3.	Determine the most appropriate measures for our features

**Criterion 1**

Excluding datasets: Council tax bands

During our criteria selection we considered that there may be datasets which are truly correlated with our response, the house sales prices. For this reason, we inferred that the dataset of Council Tax Bands should be excluded from our extraction. 

Council Tax Bands dataset contains data about the number or proportion (in terms of total number of houses) which belong to a specific council tax band for an area. However, these measures are actually derived from the value of houses and for this reason would be unwise use them in our scenarios.

the number of houses according to their value.

**Criterion 2**

2001 data zones (6505 observations) : granularity

We have chosen the most descriptive level which is the 2001 data zones.  

The great number of observations will help to : 
1. Avoid the curse high-dimensionality (have less observation rather than features)
2. Create a more robust model
3. Predict prices for a specific district or neighborhood. 

**Criterion 3**

Year : current and recent past years
Also we would like to determine whether current and past data could add to the prediction of the house prices for 2012. For this reason, we retrieved data for both current (2012) and recent years (2009-2011).

**Criterion 4**

Measure Units:  ratio and exclusion of the count
	
We have chosen as our main measure unit for our datasets the ratio. Ratio is an indicator which returns normalized data. In contrast, count is a measure which can be biased from the different size of an area or other conditions. 

Thus, our data extraction was restricted among these criteria and then all possible data were retrieved, through an exhaustive way.
To achieve this, we focused our exploration in our 2001 data zones - geographic group. Then, we started exploring each dataset to find available data that meet our criteria. Where data were available for different years and measures, all of them were finally extracted. 

### Step 2: Feature extraction

At this step we extract multiple features from every dataset. These features can be later used in the creation of the predictor models.

For instance, let’s have a deeper look in the “Age of First Time Mothers” dataset: If we explore the available dimensions of this dataset we will find out that those are the “reference period” and “age” dimension.

The dimension “age” distinct (or classifies) the measure into three categories: 

1.	mothers under 19
2. mothers over 35 
3. total number of mothers. (there is no ratio measure) 


By this, we will be able to finally extract more than three features; we will extract all the possible combinations with measure type ratio (criterion 4 from step one) for all the available years (criterion 3). Considering all these, we will finally come up with: 

2 (the two first categories) x 1 (measure type ratio) x 4 (reference periods) 
=8 features.

The same procedure has been followed also for the rest datasets.


### Step 3: Feature Selection

In order to reduce the number of features we have used the Lasso (least absolute shrinkage and selection operator), which is a regression analysis method.

Thanks to this method, we have managed to reduce the number of features significantly, actually over 80%. This has proved very helpful, as we have kept only the important features (which add value in our estimations). In addition, a reduced number of features can help us to better interpret our results.

In addition, we have conducted several repeated experiments (n=100) with random sampling in order to determine which of our final datasets are those which can better predict the house sales for each data zone.

Finally we came up with three datasets which namely are:

1. 2012 Ratio features - 2012 House Prices Mean
2. 2009-2011 Ratio features - 2012 House Prices Mean
3. 2009-2012 Ratio features - 2012 House Prices Mean


##Results

### Data Selection
The datasets that have been retrieved are shown below

| Dataset                                                 | Type  |       | Year |      |      |      | Special subsets or notes          | 
|---------------------------------------------------------|-------|-------|------|------|------|------|-----------------------------------| 
|                                                         | Ratio | Count | 2009 | 2010 | 2011 | 2012 |                                   | 
| Ante-Natal Smoking                                      | X     | X     |      | X    | X    | X    | Reference Period 20xx-20(xx+2)    | 
| Age of First Time Mothers                               | X     | X     | X    | X    | X    | X    | Reference Period 20xx-20(xx+2)    | 
| Attendance Allowance                                    |       | X     |      |      |      | X    |                                   | 
| Births                                                  |       | X     |      |      |      | X    |                                   | 
| Breastfeeding                                           | X     | X     | X    | X    | X    | X    |                                   | 
| DTP/Pol/Hib Immunisation                                | X     | X     | X    | X    | X    | X    |                                   | 
| Deaths                                                  |       | X     |      |      |      | X    |                                   | 
| Disability Living Allowance                             | X     |       | X    | X    | X    | X    | Reference Period 20xx-Q1,Q2,Q3,Q4 | 
| Dwellings by Number of Rooms                            | X     |       | X    | X    | X    | X    |                                   | 
| Dwellings per Hectare                                   | X     |       | X    | X    | X    | X    |                                   | 
| Dwellings by Type                                       | X     |       | X    | X    | X    | X    |                                   | 
| Employment & Support Allowance                          | X     | X     | X    | X    | X    | X    | Reference Period 20xx-Q1,Q2,Q3,Q4 | 
| Fire                                                    | X     | X     | X    | X    | X    | X    |                                   | 
| Hospital Admissions                                     | X     | X     | X    | X    | X    | X    |                                   | 
| Household Estimates                                     | X     | X     | X    | X    | X    | X    |                                   | 
| Income & Poverty Modelled Estimates                     | X     |       | X    | X    | X    | X    | Reference Period 20xx/20(xx+1)    | 
| Measles Mumps Rubella (MMR) Immunisation                |       | X     | X    | X    | X    | X    |                                   | 
| Low Birthweight                                         | X     | X     | X    | X    | X    | X    |                                   | 
| Measles Mumps Rubella (MMR) Immunisation                | X     | X     | X    | X    | X    | X    |                                   | 
| Income Support Claimants                                |       |       | X    | X    | X    | X    |                                   | 
| Job Seeker_s Allowance                                  | X     |       | X    | X    | X    | X    |                                   | 
| Incapacity Benefit & Severe Disablement Claimants       | X     | X     | X    | X    | X    | X    | Reference Period 20xx-Q1,Q2,Q3,Q4 | 
| Population living in close proximity to a derelict site | X     |       | X    | X    | X    | X    |                                   | 
| School Attendance Rate                                  |       | X     | X    | X    | X    | X    |                                   | 
| Pension Credits                                         | X     | X     | X    | X    | X    | X    | Reference Period 20xx-Q1,Q2,Q3,Q4 | 
| School Leaver Destinations Initial                      | X     | X     | X    | X    | X    | X    | Reference Period 20xx/20(xx+1)    | 
| School Pupil Census                                     |       | X     |      |      |      | X    |                                   | 
| Travel times to key services by car or public transport |       | X     |      |      |      | X    |                                   | 
| Working Age Claimants of Key Benefits                   | X     |       | X    | X    | X    | X    | Reference Period 20xx-Q1,Q2,Q3,Q4 | 
