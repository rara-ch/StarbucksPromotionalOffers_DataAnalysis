# Starbucks Promotional Offers Data Analysis
## Objectives
Starbucks is a global coffee shop chain, founded in 1971 in the United States. The company released a total of 300K+ rows of anonymised data on its events, customers members, and promotional offers across a 30 day period. This project investigates this data in order to uncover critical insights that will improve Starbucks' marketing success. Specifically, insights and recommendations are provided in the following areas:
- How different customer demographics (e.g., age, income, gender, membership signup date) engage with offers.
- The effectiveness of different distribution channels in exposing members to offers.

An interactive Tableau Dashboard can be found [here](https://public.tableau.com/views/StarbucksPromotionalOffersDashboard/Dashboard?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link).

The Python code utilised to clean the raw data can be found [here](https://github.com/rara-ch/starbucks_promotional_offers_analysis/blob/main/StarbucksPromotionalOffers_DataCleaning.ipynb).

## Data
![ERM](data/StarbucksPromotionalOffers_RawERM.png)
![Data Dictionary](data/StarbucksPromotionalOffers_RawDataDictionary.png)

The data source can be found [here](https://www.kaggle.com/datasets/ihormuliar/starbucks-customer-data).
## Executive Summary
Below is the Tableau dashboard, which can be found [here](https://public.tableau.com/views/StarbucksPromotionalOffersDashboard/Dashboard?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link).

![Dashboard](StarbucksOffersFunnel_Dashboard.png)
## Insights
### Performance Trends:
- **Each occassion offers were sent out, the total number of offers completed increased by an average of 1192 from the day before**. Offers were sent out on 6 occassions. Specifically, on days 0, 7, 14, 17, and 21. Each offer was sent out an average of 1271 times per occassion with little variance.
- **Although highly volitile, offers were completed at an increasing statistically significant (p = 0.04) rate of 26.5 more completions per day throughout the 30 day period**. Since other possible causes remained unchanged, this increase is most likely due to offers being sent out more frequently in the later half of the month than in the first half of the month. As stated above, days that offers were sent out increased the number of offers completed by an average of 1192 compared to the day before. Therefore, completions increased significantly on days offers were released before trailing off significantly in the coming days.

![OffersCompletedbyDay](ReportImages/OffersCompletedbyDay.png)

- **Discount offers were completed more than BOGO (buy one, get one) offers by 2180 throughout the 30 day period**. This is likely because although BOGO offers would do better than discount offers in the short term (on release days), the number of BOGO offers completed reduced at a faster rate than discount offers completed in following days.

![OffersCompletedbyOfferType](ReportImages/OffersCompletedbyOfferType.png)

### Distribution Effeciency:
- Offers that were distributed through social media were viewed by almost all Starbucks’ members (94.5%). For comparison, roughly half (52.5%) of members viewed offers that were not distributed through social media.

![PercentageViewedOffers](ReportImages/PercentageViewedOffers.png)

### Customer Demographic Trends:
- A higher proportion of the offers were sent to males compared to females although females completed offers at a higher rate.
- Younger members (20s and 30s) engage with offers at the lowest rate out of any age group, especially when the offer is not distributed on social media.
- Although buy-one-get-one (BOGO) offers are easier and more rewarding than discount offers, discount offers were completed at a 12% higher rate than BOGO offers. However, discount offers went for 2.5 days longer than BOGO offers on average.

## Recommendations
- Prioritise distributing offers through social media to ensure offers are seen by the maximum number of members and to increase engagement of the younger demographic.
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

Since some columns were in the form of lists and dictionaries, I decided to use Python to clean and wrangle the data. I cleaned the offers and customers tables before cleaning the events table and splitting it into four separate tables for each type of event. These were offers_received, offers_viewed, offers completed, and transactions. I then exported these tables into MySQL so I could more easily manipulate them.
### 3. MySQL Analysis
[StarbucksPromotionalOffers_FunnelViewsCreation.sql](https://github.com/rara-ch/starbucks_promotional_offers_analysis/blob/main/StarbucksPromotionalOffers_FunnelViewsCreation.sql)

[StarbucksPromotionalOffers_EDA.sql](https://github.com/rara-ch/starbucks_promotional_offers_analysis/blob/main/StarbucksPromotionalOffers_EDA.sql)

Upon my initial analysis in MySQL, I found that customers could receive, view, and complete the offer at any stage multiple times. I also found that customers could complete an offer without viewing it. Therefore, I restricted my analysis to focus on only the completed offers that were viewed in order to ensure that I analysed how offers brought people into Starbucks. I also restricted my analysis to the customer level. In other words, I ignored how many times a customer received, viewed, or completed a single offer and instead only focuses on whether they did complete the stage or not. I then joined the offers_received, offers_viewed, offers_completed tables to create a funnel on the customer and offer level. I then did some exploratory data analysis on different customer dimensions and the funnel to find any actionable insights.
