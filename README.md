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
- **Offers that were distributed through social media were viewed at a rate of 94.5% Starbucks compared to a rate of 52.5% when not distributed through social media**.

![PercentageViewedOffers](ReportImages/PercentageViewedOffers.png)

- This distinction is especially true for the company's younger demographic **(20s & 30s), who view offers at a rate of 96.3% when the offer is distributed through social media versus 32.9% when it is not**.

![ReportImages/ViewedPercentageAgeSocialMedia](ReportImages/ViewedPercentageAgeSocialMedia.png)

### Customer Demographic Trends:
- A higher proportion of the offers were sent to males compared to females although females completed offers at a higher rate.
- Younger members (20s and 30s) engage with offers at the lowest rate out of any age group, especially when the offer is not distributed on social media.
- Although buy-one-get-one (BOGO) offers are easier and more rewarding than discount offers, discount offers were completed at a 12% higher rate than BOGO offers. However, discount offers went for 2.5 days longer than BOGO offers on average.

## Recommendations
- Prioritise distributing offers through social media to ensure offers are seen by the maximum number of members and to increase engagement of the younger demographic.
- Use targeted advertising campaigns to attract more female members.
- Release more BOGO and discount offers that go for the same duration so we can more accurately assess the success of each offer type.
