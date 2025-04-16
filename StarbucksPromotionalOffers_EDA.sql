-- This is an exporatory data analysis of the starbucks promotional offers

USE starbucks_promotions_db;

-- How many offers were received and how many different customers received the offers? 
SELECT 	 COUNT(*) as total_offers_received,
		 COUNT(DISTINCT customer_id) as distinct_customers
FROM 	 offers_received;
-- A total of 76,277 offers were sent out to 16994 different customers.

-- Did customers receive the same offer multiple times?
SELECT 	 customer_id, offer_id,
		 COUNT(*) as num_received
FROM 	 offers_received
GROUP BY customer_id, offer_id
ORDER BY COUNT(*) DESC;
-- Customers received the same offer multiple times. Customers seem to be sent offers at random.

-- What is the funnel percentage for each offer?
SELECT 	 *
FROM 	 funnel_offer;

-- What is the funnel percentage for each type of offer?
SELECT 	 offer_type,								-- A query that averages out the funnel to the granularity of offer type
		 ROUND(AVG(difficulty), 2) as avg_difficulty,
         ROUND(AVG(reward), 1) as avg_reward,
         ROUND(AVG(duration), 1) as avg_duration,
         ROUND(AVG(total_received_cm)) as avg_total_received_cm,
         ROUND(AVG(viewed_percentage) * 100, 1) as avg_viewed_percentage,
         ROUND(AVG(completed_percentage_from_view) * 100, 1) as avg_completed_percentage_from_view,
         ROUND(AVG(completed_percentage_from_received) * 100, 1) as completed_percentage_from_received
FROM 	 funnel_offer
GROUP BY offer_type;

-- What is the difference in viewing between offers distributed through social channel vs not distributed through social channel
SELECT 	 social,									
		 ROUND(AVG(total_received_cm)) as avg_cm_received,
         ROUND(AVG(viewed_percentage) * 100, 1) as avg_viewed_percentage,
         ROUND(AVG(total_viewed_cm)) as avg_cm_viewed
FROM	 funnel_offer
GROUP BY social; 

-- Does it matter what offer type? (small sample for non-social distribution channel) 
SELECT 	 social, offer_type,
		 ROUND(AVG(total_received_cm)) as avg_cm_received,
         ROUND(AVG(viewed_percentage) * 100, 1) as avg_viewed_percentage
FROM	 funnel_offer
GROUP BY social, offer_type
ORDER BY offer_type, social; 

-- Do any of the other channels have any sort of significant difference?
SELECT 	 web, -- Small sample for non-web distribution offers
		 ROUND(AVG(total_received_cm)) as avg_cm_received,
         ROUND(AVG(viewed_percentage) * 100, 1) as avg_viewed_percentage,
         ROUND(AVG(total_viewed_cm)) as avg_cm_viewed
FROM	 funnel_offer
GROUP BY web; 

SELECT 	 mobile, -- Small sample for non-mobile distribution offers (only one and that offer did not have social either)
		 ROUND(AVG(total_received_cm)) as avg_cm_received,
         ROUND(AVG(viewed_percentage) * 100, 1) as avg_viewed_percentage,
         ROUND(AVG(total_viewed_cm)) as avg_cm_viewed
FROM	 funnel_offer
GROUP BY mobile; 

-- Create a temporary table that shows the funnel at the offer level seperated by gender.
CREATE TEMPORARY TABLE funnel_offer_gender AS (
WITH gender_offers_funnel_totals AS (
		SELECT   fcm.offer_id, c.gender,
				 COUNT(num_received) as total_received_cm,
				 COUNT(num_viewed) as total_viewed_cm,
				 COUNT(num_completed) as total_completed_cm
		FROM 	 funnel_cm fcm INNER JOIN customers c
				 ON fcm.customer_id = c.customer_id
		WHERE 	 c.gender IS NOT NULL
		GROUP BY fcm.offer_id, c.gender
)
SELECT   goft.offer_id, goft.gender, o.offer_type, o.difficulty, o.reward, o.duration, o.web, o.email, o.mobile, o.social, goft.total_received_cm,
		 goft.total_viewed_cm / goft.total_received_cm as viewed_percentage,
         goft.total_completed_cm / goft.total_viewed_cm as completed_percentage_from_view,
         goft.total_completed_cm / goft.total_received_cm as completed_percentage_from_received
FROM 	 gender_offers_funnel_totals goft INNER JOIN offers o
		 ON goft.offer_id = o.offer_id
ORDER BY goft.offer_id, goft.gender
);

-- Are there any insights?
SELECT 	 *
FROM 	 funnel_offer_gender;
-- Starbucks send more offers to M than F. However, F view more offers than M.

-- Change the level of granularity to just gender. What are the trends?
SELECT 	 gender,
		 ROUND(AVG(total_received_cm)) as avg_cm_received,
         ROUND(AVG(viewed_percentage) * 100, 1) as avg_viewed_percentage,
         ROUND(AVG(total_received_cm) * AVG(viewed_percentage)) as avg_num_viewed,
         ROUND(AVG(completed_percentage_from_view) * 100, 1)  as avg_completed_percentage_from_view,
         ROUND(AVG(total_received_cm) * AVG(viewed_percentage) * AVG(completed_percentage_from_view)) as avg_num_completed,
         ROUND(AVG(completed_percentage_from_received) * 100, 1) as avg_completed_percentage_from_received
FROM 	 funnel_offer_gender
GROUP BY gender;

-- Create a temporary table that shows the funnel at the offer level seperated by age group.
CREATE TEMPORARY TABLE funnel_offer_age AS (
WITH gender_offers_funnel_totals AS (
		SELECT   fcm.offer_id, 
				 ROUND(c.age, -1) as age_group,
				 COUNT(num_received) as total_received_cm,
				 COUNT(num_viewed) as total_viewed_cm,
				 COUNT(num_completed) as total_completed_cm
		FROM 	 funnel_cm fcm INNER JOIN customers c
				 ON fcm.customer_id = c.customer_id
		WHERE 	 c.age IS NOT NULL
		GROUP BY fcm.offer_id, ROUND(c.age, -1)
)
SELECT   goft.offer_id, goft.age_group, o.offer_type, o.difficulty, o.reward, o.duration, o.web, o.email, o.mobile, o.social, goft.total_received_cm,
		 goft.total_viewed_cm / goft.total_received_cm as viewed_percentage,
         goft.total_completed_cm / goft.total_viewed_cm as completed_percentage_from_view,
         goft.total_completed_cm / goft.total_received_cm as completed_percentage_from_received
FROM 	 gender_offers_funnel_totals goft INNER JOIN offers o
		 ON goft.offer_id = o.offer_id
ORDER BY goft.offer_id, goft.age_group
);

-- Change the level of granularity to just age. What are the trends?
WITH funnel_age_gran AS (
		SELECT 	 age_group,
				 ROUND(AVG(total_received_cm)) as avg_cm_received,
				 ROUND(AVG(viewed_percentage) * 100, 1) as avg_viewed_percentage,
				 ROUND(AVG(completed_percentage_from_view) * 100, 1)  as avg_completed_percentage_from_view,
				 ROUND(AVG(completed_percentage_from_received) * 100, 1) as avg_completed_percentage_from_received
		FROM 	 funnel_offer_age
		GROUP BY age_group
		ORDER BY age_group
)
SELECT 	 age_group, avg_cm_received,
		 RANK() OVER(ORDER BY avg_cm_received DESC) as received_rank,
         avg_viewed_percentage,
         RANK() OVER(ORDER BY avg_viewed_percentage DESC) as viewed_percentage_rank,
         avg_completed_percentage_from_view,
         RANK() OVER(ORDER BY avg_completed_percentage_from_view DESC) as completed_percentage_from_view_rank
FROM 	 funnel_age_gran;

-- Could not distributing the offers through social channel be why the funnel does the worst for 20s and 30s?
WITH funnel_age_gran_w_social AS (
		SELECT 	 age_group, social,
				 ROUND(AVG(total_received_cm)) as avg_cm_received,
				 ROUND(AVG(viewed_percentage) * 100, 1) as avg_viewed_percentage,
                 ROUND(AVG(completed_percentage_from_view) * 100, 1)  as avg_completed_percentage_from_view
		FROM 	 funnel_offer_age
		GROUP BY age_group, social
)
SELECT 	 age_group, social, avg_cm_received, avg_viewed_percentage,
         RANK() OVER(PARTITION BY social ORDER BY avg_viewed_percentage DESC) as viewed_percentage_rank,
         avg_completed_percentage_from_view,
         RANK() OVER(PARTITION BY social ORDER BY avg_completed_percentage_from_view DESC) as completed_percentage_from_view_rank
FROM 	 funnel_age_gran_w_social
ORDER BY social, completed_percentage_from_view_rank;

-- Create a temporary table that shows the funnel at the offer level seperated by income group. 
CREATE TEMPORARY TABLE funnel_offer_income AS (
WITH gender_offers_funnel_totals AS (
		SELECT   fcm.offer_id, 
				 ROUND(c.income, -4) as income_group,
				 COUNT(num_received) as total_received_cm,
				 COUNT(num_viewed) as total_viewed_cm,
				 COUNT(num_completed) as total_completed_cm
		FROM 	 funnel_cm fcm INNER JOIN customers c
				 ON fcm.customer_id = c.customer_id
		WHERE 	 c.income IS NOT NULL
		GROUP BY fcm.offer_id, ROUND(c.income, -4)
)
SELECT   goft.offer_id, goft.income_group, o.offer_type, o.difficulty, o.reward, o.duration, o.web, o.email, o.mobile, o.social, goft.total_received_cm,
		 goft.total_viewed_cm / goft.total_received_cm as viewed_percentage,
         goft.total_completed_cm / goft.total_viewed_cm as completed_percentage_from_view,
         goft.total_completed_cm / goft.total_received_cm as completed_percentage_from_received
FROM 	 gender_offers_funnel_totals goft INNER JOIN offers o
		 ON goft.offer_id = o.offer_id
ORDER BY goft.offer_id, goft.income_group
); 

-- Change the level of granularity to just income. What are the trends?
WITH funnel_income_gran AS (
		SELECT 	 income_group,
				 ROUND(AVG(total_received_cm)) as avg_cm_received,
				 ROUND(AVG(viewed_percentage) * 100, 1) as avg_viewed_percentage,
				 ROUND(AVG(completed_percentage_from_view) * 100, 1)  as avg_completed_percentage_from_view,
				 ROUND(AVG(completed_percentage_from_received) * 100, 1) as avg_completed_percentage_from_received
		FROM 	 funnel_offer_income
		GROUP BY income_group
)
SELECT 	 income_group, avg_cm_received,
		 RANK() OVER(ORDER BY avg_cm_received DESC) as received_rank,
         avg_viewed_percentage,
         RANK() OVER(ORDER BY avg_viewed_percentage DESC) as viewed_percentage_rank,
         avg_completed_percentage_from_view,
         RANK() OVER(ORDER BY avg_completed_percentage_from_view DESC) as completed_percentage_from_view_rank
FROM 	 funnel_income_gran;

-- ------------------------------------------------------------------------------------------------------------------------------------------------
-- Create a temporary table that shows the funnel at the offer level seperated by income group. 
CREATE TEMPORARY TABLE funnel_offer_bmo AS (
WITH gender_offers_funnel_totals AS (
		SELECT   fcm.offer_id, 
				 YEAR(became_member_on) as year_bmo,
				 COUNT(num_received) as total_received_cm,
				 COUNT(num_viewed) as total_viewed_cm,
				 COUNT(num_completed) as total_completed_cm
		FROM 	 funnel_cm fcm INNER JOIN customers c
				 ON fcm.customer_id = c.customer_id
		GROUP BY fcm.offer_id, YEAR(became_member_on)
)
SELECT   goft.offer_id, goft.year_bmo, o.offer_type, o.difficulty, o.reward, o.duration, o.web, o.email, o.mobile, o.social, goft.total_received_cm,
		 goft.total_viewed_cm / goft.total_received_cm as viewed_percentage,
         goft.total_completed_cm / goft.total_viewed_cm as completed_percentage_from_view,
         goft.total_completed_cm / goft.total_received_cm as completed_percentage_from_received
FROM 	 gender_offers_funnel_totals goft INNER JOIN offers o
		 ON goft.offer_id = o.offer_id
ORDER BY goft.offer_id, goft.year_bmo
); 

-- Change the level of granularity to just the year customers became members. What are the trends?
SELECT 	 year_bmo,
		 ROUND(AVG(total_received_cm)) as avg_cm_received,
         ROUND(AVG(viewed_percentage) * 100, 1) as avg_viewed_percentage,
         ROUND(AVG(completed_percentage_from_view) * 100, 1)  as avg_completed_percentage_from_view,
         ROUND(AVG(completed_percentage_from_received) * 100, 1) as avg_completed_percentage_from_received
FROM 	 funnel_offer_bmo
GROUP BY year_bmo
ORDER BY year_bmo;