# Starbucks Promotional Offers Data Analysis
This is a data analyst portfolio project that aims to explore how different customer demographics engage with Starbucks promotional offers and analyse the effectiveness of various channels for viewing offers. My end goal is to use data storytelling and visualisation to provide Starbucks actionable insights to improve offer engagement and distribution.

## Data
The [data](https://www.kaggle.com/datasets/ihormuliar/starbucks-customer-data) was sourced from kaggle and contains three tables named offers (portfolio.csv), customers (profile.csv), and events (transcript.csv). The data dictionary for all three tables can be found [here](https://github.com/rara-ch/starbucks_promotional_offers_analysis/blob/main/data/starbucks_data_dictionary.csv).

## Objectives
- Explore how different customer demographics (e.g., age, income, gender, membership signup date) engage with offers.
- Analyse the effectiveness of various channels for viewing offers.

## Key Insights
- Offers that were distributed through the social channel were viewed by almost all Starbucks’ members (94.5%). For comparison, roughly half (52.5%) of members viewed offers that were not distributed through the social channel.
- A higher proportion of the offers were sent to males compared to females although females completed offers at a higher rate.
- Younger members (20s and 30s) engage with offers at the lowest rate out of any age group, especially when the offer is not distributed through the social channel.
- Although BOGO offers are easier and more rewarding than discount offers, discount offers were completed at a 12% higher rate than BOGO offers. However, discount offers went for 2.5 days longer than BOGO offers on average.

## Key Recommendations
- Prioritise distributing offers through the social channel to ensure offers are seen by the maximum number of members and to increase engagement of the younger demographic.
- Use targeted advertising campaigns to attract more female members.
- Release more BOGO and discount offers that go for the same duration so we can more accurately assess the success of each offer type.

## Methodology
### Plan
1.	**Create a Scope**: Define the project's objectives, key questions, and what insights you aim to derive from the data.
2.	**Clean Data in Python**: Preprocess and clean the data using Python, handling missing values, duplicates, and ensuring correct formats.
3.  **Export Data to SQL for Some Analysis**: Export the cleaned data to a SQL database for efficient querying, aggregation, and analysis.
4.  **Create a Dashboard in Tableau**: Build an interactive dashboard in Tableau to showcase insights and trends in a visually appealing way.
5.  **Write a Final Report**: Compile a clear and concise report that summarizes your findings, insights, and actionable recommendations.
   
### 1. Scope
Utilising ChatGPT and viewing the data, I came up with two main areas and five sub-areas for analysis:
#### Main Objectives
- Explore how different customer demographics (e.g., age, income, gender, membership signup date) engage with offers.
- Analyse the effectiveness of various channels for viewing offers.
#### Sub-Objectives
-	Do customers of certain age groups, income levels, or gender engage more with specific offers?
-	What channels are most effective for different types of offers?

I decided that for the main objectives, I would create an interactive dashboard that would assist Starbucks' business executives to see the performance of any specific offers in addition to my recommendations. For the sub-objects, I planned to create a visualistion report with my key conclusions and recommendations.
### 2. Cleaning and Wrangling
[StarbucksPromotionalOffers_DataCleaning.ipynb](https://github.com/rara-ch/starbucks_promotional_offers_analysis/blob/main/StarbucksPromotionalOffers_DataCleaning.ipynb)

Since some columns were in the form of lists and dictionaries, I decided to use Python to clean and wrangle the data. I cleaned the offers and customers tables before cleaning the events table and splitting it into four seperate tables for each type of event. These were offers_received, offers_viewed, offers completed, and transactions. I then exported these tables into MySQL so I could more easily minipulate them.
### 3. MySQL Analysis
[StarbucksPromotionalOffers_FunnelViewsCreation.sql](https://github.com/rara-ch/starbucks_promotional_offers_analysis/blob/main/StarbucksPromotionalOffers_FunnelViewsCreation.sql)

[StarbucksPromotionalOffers_EDA.sql](https://github.com/rara-ch/starbucks_promotional_offers_analysis/blob/main/StarbucksPromotionalOffers_EDA.sql)

Upon my initial analysis in MySQL, I found that customers could receive, view, and complete the offer at any stage multiple times. I also found that customers could complete an offer without viewing it. Therefore, I restricted my analysis to focus on only the completed offers that were viewed in order to ensure that I analysed how offers brought people into Starbucks. I also resticted my analysis to the customer level. In other words, I ignored how many times a customer received, viewed, or completed a single offer and instead only focuses on whether they did complete the stage or not. I then joined the offers_received, offers_viewed, offers_completed tables to create a funnel on the customer and offer level. I then did some exporatory data analysis on different customer dimensions and the funnel to find any actionble insights.
### 4. Tableau Dashboard
[StarbucksPromotionalOffers Dashboard](https://public.tableau.com/views/StarbucksPromotionalOffersDashboard/Dashboard?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

![Starbucks Promotional Offers Dashboards](C:\Users\chitk\OneDrive\Documents\Data_Analytics_Portfolio\Starbucks_Rewards_Offers\Dashboard_Images)

I created an interactive dashboard in Tableau for main objectives.

### 5. Report
This Markdown file is my report.
