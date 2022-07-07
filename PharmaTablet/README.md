# Case Study Pharmaceutical Tablet Production Process: Root Cause Analysis
Clear Plastic is made by heating and stirring a monomer in a batch reactor until it polymerises.  When the reaction is complete the molten polymer is granulated and packed.  The plant makes 3 batches per day 24/7. 
![Tablet Process](https://github.com/paulvanmol/PolymerCase/blob/main/images/PharmaceuticalTabletManufacturingProcess.png?raw=true)
The following data was collected: 
Y's (outputs)
Dissolution (to predict)
specification limit Dissolution >70:
##Discover the Tablet data
1.	Open Manage Data: http://server.demo.sas.com/SASDataExplorer/
2.	Select the import tab: local files: d:\workshop\Tablet_data_2.xlsx 
3.	Import the Tablet_Data_2 in the public cas library
4.	In Discover Data, select the Discovery Agents
5.	Select public and Action Run Now to discover all Public data
6.	Select Overview and search for the tablet data
7.	Select columns and look at Distribution, histograms and boxplots. 
8.	What does the Accept/reject tell you: how many tablet Lot No are rejected
9.	Check Dissolution: boxplot what is the minimum value 
##Explore the Tablet Data:
1.	Create Histograms & Barcharts in SAS Visual Analytics
a.	Histograms for numeric fields
b.	Bar Charts for categorical fields 
c.	X Axis label remove
d.	Graph no automatic title
e.	Save Template histogram to objects as Histogram_notitle
f.	Save Template barchart to objects as barchart_notitle
g.	Add multiple histograms and barcharts for the different data items to one page
h.	Add Automatic Interactions between all objects
2.	Look at the Data Item Accept/Reject and the value of Dissolutions
##Explain Dissolution: What are the most important factors?
4.	Automatic Explanation of Dissolution: what are the most important factors that have influence on Dissolution?
a.	Answer: Milltime, Screen size, …?
5.	Scatter plot of Dissolution and Milltime
a.	Add a fitline (Quadratic or Cubic or Best fit)
6.	Add a page with scatterplots of Mill Time and Dissolution and use the filters to check the differences by Screen size: 
7.	Boxplot of Dissolution by Screen Size (ideally an ANOVA in SAS Studio)
a.	Make duplicate of Screen Size as Category data item
b.	Add Boxplot of Dissolution by Screensize
8.	Linear Regression of Dissolution and all other Data items
a.	Create a partition ID variable (80 % training and 20 % Validation, stratified by Accept/reject)
b.	Target: Dissolution
c.	All other variables: except API Lot No and Accept Reject
10.	Create Pipeline Model from Linear Regression 
a.	Create Pipeline>Add to New Project
a.	Experiment with Intermediate Pipeline template for Interval variable
- Dissolution is the Target variable which is interval not Category
- The Intermediate pipeline template applies some best practices like missing value imputation, variable selection and then creates several other models: 
b.	Compare models: the best model is still the Linear Regression
c.	Download the Score code of the Linear Regression Model: 