# Starbucks Promotional Offers Data Analysis
## Objectives
Starbucks is a global coffee shop chain, founded in 1971 in the United States. The company released a total of 300K+ rows of anonymised data on its events, customers, and promotional offers across a 30 day period. This project investigates this data in order to uncover critical insights that will improve Starbucks' marketing success. Specifically, insights and recommendations are provided in the following areas:

- The performance of offers throughout the 30 day time period.
- The effectiveness of different distribution channels in exposing members to offers.
- How different customer demographics (e.g., age, income, gender, membership signup date) engage with offers.

An interactive Tableau Dashboard can be found [here](https://public.tableau.com/views/StarbucksPromotionalOffersDashboard/Dashboard?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link).

The Python code utilised to clean, analyse, and model the data can be found [here](https://github.com/rara-ch/StarbucksPromotionalOffers_DataAnalysis/tree/main/PythonNotebooks).

The SQL code utilised to create views and analyse the data can be found [here](https://github.com/rara-ch/StarbucksPromotionalOffers_DataAnalysis/tree/main/SQLFiles)

## Data
![ERM](data/StarbucksPromotionalOffers_RawERM.png)
![Data Dictionary](data/StarbucksPromotionalOffers_RawDataDictionary.png)

The data source can be found [here](https://www.kaggle.com/datasets/ihormuliar/starbucks-customer-data).
## Executive Summary
Throughout the 30 day period, completions of offers steadily increased, likely because offers were sent out more frequently in the second half of the 30 day period. The variety of offers sent out and the rate that these offers were viewed remained consistent throughout. The most impactful attribute that increased the rate an offer was viewed was whether it was distributed through social media or not. This impactfullness was especially apparent for the company's young adult demographic. Buy One, Get One (BOGO) and discount offers were redeemed at similar rates throughout the 30 day period when the duration of the offer is standardised. However, although BOGO offers increased average spend per transaction, the amount lost in reduced prices was much more significant, leading to conclusions that discount offers were more successful. 

In terms of customer demographics, males and younger members engaged with offers at a lower rate than their respective demographic counterparts. The date that a customer became a member and their income level demonstrated no clear connection to how they engaged with offers.

Below is the Tableau dashboard, which can be found [here](https://public.tableau.com/views/StarbucksPromotionalOffersDashboard/Dashboard?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link).

![Dashboard](StarbucksOffersFunnel_Dashboard.png)
## Insights
### Performance Trends:
- **Each occassion offers were sent out, the total number of offers completed increased by an average of 1192 from the day before**. Offers were sent out on 6 occassions. Specifically, on days 0, 7, 14, 17, and 21. Each offer was sent out an average of 1271 times per occassion with little variance.

- **Although highly volitile, offers were completed at an increasing statistically significant (p = 0.04) rate of 26.5 more completions per day throughout the 30 day period**. Since other possible causes remained unchanged, this increase is most likely due to offers being sent out more frequently in the later half of the month than in the first half of the month. As stated above, days that offers were sent out increased the number of offers completed by an average of 1192 compared to the day before. Therefore, completions increased significantly on days offers were released before trailing off in the following days.

![OffersCompletedbyDay](ReportImages/OffersCompletedbyDay.png)

- **Discount offers were completed more than BOGO (buy one, get one) offers by 2180 throughout the 30 day period**. This is likely because although BOGO offers would do better than discount offers in the short term (on release days), the number of BOGO offers completed reduced at a faster rate than discount offers completed in following days. However, this trend is due to discount offers having a longer average duration of 8.5 days compared to 6 days. When only the offers with the same duration are considered, BOGO and discount offers perform very similarily throughout the 30 days.

![OffersCompletedbyOfferType](ReportImages/OffersCompletedbyOfferType.png)

- On average, customers would spend more when redeeming a BOGO offer compared to a discount offer by $1 after the total price has been reduced. However, the company loses an average of $4.38 more when a customer redeems a BOGO offer compared to a discount offer. Standardising for differences in the number of times each offer was redeemed, this led to **BOGO offers losing the company a total of $67,916.72 ($61,691 not standardised) more in reduced prices than discount offers and bringing in only $13,162.44 more (-$28,536 not standardised) than discount offers**.

### Distribution Effeciency:
- Offers that were **distributed through social media were viewed at a rate of 94.5%** compared to a **rate of 52.5% when not distributed through social media**.

![PercentageViewedOffers](ReportImages/PercentageViewedOffers.png)

- The impact of social media for distribution success is especially significant for the company's younger demographic **(20s & 30s), who view offers at a rate of 96.3% when the offer is distributed through social media versus 32.9% when it is not**.

![ReportImages/ViewedPercentageAgeSocialMedia](ReportImages/ViewedPercentageAgeSocialMedia.png)

### Customer Demographic Trends:
- On average, **Starbucks sends its offers to 38% more males compared to females**. This is despite the fact that **females engage with offers at a 10% higher rate than males**. Offers are viewed at a similar rate for both genders, indicating that females were more likely than males to redeem an offer after viewing it. 
  
  ![GenderOfferEngagement](ReportImages/GenderOfferEngagement.png)
- Younger people complete offers after viewing them at the lowest rate as the 20s, 30s, and 40s age groups have the three lowest completion rates from view at 48.3%, 48.4% and 54.3% respectively. The 20s, 30s, and 40s complete offers at the lowest rate after view independent of if the offer is distributed through the social media or not.

- The year a customer became a member and income both demonstrate no clear impact on customers' engagement with offers.

## Recommendations
Based on the uncovered insights, the following recommendations have been provided:
- **Distributing offers through social media is essential**, especially if the company wants to target the young adult demographic. Offers distributed with social media get **viewed at a rate of 94.5% compared to 52.5%**. The offers that get viewed more, get completed more. Hence, to ensure optimisation of future offers, they should be distributed through social media.
  
- Females redeem offers at a 10% higher rate than males. Therefore, **the marketing team should consider a targeted campaign towards the female demographic to increase the number of female members. This would allow the company's offers to reach more females, who have a greater likelyhood of redeeming an offer**. Alternatively, the marketing team could attempt to increase the redemption rate of offers sent to males to ensure the company's customer base remains balanced. 
  
- The biggest increases in offers redeemed occur the same days that offers are released, which is an **average increase of 1192**. Therefore, **one easy way to increase the amount of offers redeemed is to increase the amount of times offers are sent out**.
  
- With discount and BOGO offers performing very similarily throughout the 30 day period, BOGO offers lose the company significantly more money in price reductions than discount offers. Although BOGO offers tend to increase total amount spent by customers on average, this increase is small. **A financial analyst should investigate how much BOGO offers reduce profits and decide if BOGO offers should remain going forward**.
