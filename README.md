# Starbucks Promotional Offers Data Analysis
This is a data analyst portfolio project that aims to explore how different customer demographics engage with Starbucks promotional offers and analyse the effectiveness of various channels for viewing offers. My end goal is to use data storytelling and visualisation to provide Starbucks actionable insights to imporve offer engagement and distribution.

## Data
The [data](https://www.kaggle.com/datasets/ihormuliar/starbucks-customer-data) was sourced from kaggle and contains three tables named offers (portfolio.csv), customers (profile.csv), and events (transcript.csv). The data dictionary for all three tables can be found [here](https://github.com/rara-ch/starbucks_promotional_offers_analysis/blob/main/data/starbucks_data_dictionary.csv).

## Plan
1.	**Create a Scope**: Define the project's objectives, key questions, and what insights you aim to derive from the data.
2.	**Clean Data in Python**: Preprocess and clean the data using Python, handling missing values, duplicates, and ensuring correct formats.
3.  **Export Data to SQL for Some Analysis**: Export the cleaned data to a SQL database for efficient querying and aggregation.
4.  **Use Python for EDA**: Conduct exploratory data analysis in Python, creating visualizations and calculating key metrics.
5.  **Create a Dashboard in Tableau**: Build an interactive dashboard in Tableau to showcase insights and trends in a visually appealing way.
6.  **Write a Final Report**: Compile a clear and concise report that summarizes your findings, insights, and actionable recommendations.
   
## Scope
Utilising ChatGPT and viewing the data, I came up with two main areas and five sub-areas for analysis:
#### Main Objectives
- Explore how different customer demographics (e.g., age, income, gender, membership signup date) engage with offers.
- Analyse the effectiveness of various channels for viewing offers.
#### Sub-Objectives
-	Which offer types are most likely to lead to transactions?
-	Do customers of certain age groups, income levels, or gender engage more with specific offers?
-	What channels are most effective for different types of offers?
-	Is there a correlation between difficulty of an offer and its redemption rate?
-	From a financial perspective, what offers performed the best?

I decided that for the main objectives, I would create an interactive dashboard that would assist Starbucks' business executives in improving promotional offer engagement in addition to my recommendations. For the sub-objects, I planned to create a visualistion report with my key conclusions and recommendations.
## Cleaning and Wrangling
Since some columns were in the form of lists and dictionaries, I decided to use Python to clean and wrangle the data, which can be found [here](https://github.com/rara-ch/starbucks_promotional_offers_analysis/blob/main/starbucks_promotional_offers_analysis_cleaning.ipynb). I cleaned the offers and customers tables before cleaning the events table and splitting it into four seperate tables for each type of event. These were offers_received, offers_viewed, offers completed, and transactions. I then exported these tables into MySQL so I could more easily minipulate them.
## MySQL Analysis
Upon my initial analysis in MySQL, I found that customers could receive, view, and complete the offer at any stage multiple times. I also found that customers could complete an offer without viewing. Therefore, I restricted my analysis to focus on only the completed offers that were viewed in order to ensure that I analysed how offers brought people into Starbucks. I also resticted my analysis to the customer level. In other words, I ignored how many times a customer received, viewed, or completed a single offer and instead only focuses on whether they did complete the stage or not. I then joined the offers_received, offers_viewed, offers_completed tables to create a funnel on the customer and offer level. The table can be found (here)[]. I then did some exporatory data analysis on different customer dimensions and the funnel to find any actionble insights.
## Tableau Dashboard
I created an interactive dashboard in Tableau for main objectives, which can be found [here](https://public.tableau.com/views/StarbucksPromotionalOffersDashboard/Dashboard?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)
## Report
