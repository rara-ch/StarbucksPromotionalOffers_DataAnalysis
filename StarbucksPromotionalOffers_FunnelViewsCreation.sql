/* This is the creation of the funnel that shows the number of times a customer received, viewed, and completed an individual offer.
   Upon my first time creating this table, I realised that a customer could complete an offer without viewing it. Therefore, I 
   I restricted the table to only have non-null completed values if the viewed stage was also non-null. This ensures that the
   that the analysis is focused on how successful offers were in bringing people into Starbucks. Moreover, I will create a funnel
   table at the granularity of customer and offer. The former will help analyse funnel trends across customer segments. The latter
   will help analyse funnel trends accross channel distributions. */

CREATE VIEW funnel_cm AS ( 									-- Create view
WITH distinct_offers_received AS (							-- CTE that counts the amount of times a customer received any individual offer
			SELECT 	 customer_id, offer_id,
					 COUNT(*) as num_received
			FROM 	 offers_received
			GROUP BY customer_id, offer_id
),
	   distinct_offers_viewed AS (							-- CTE that counts the amount of times a customer viewed any individual offer
			SELECT 	 customer_id, offer_id,
					 COUNT(*) AS num_viewed
			FROM 	 offers_viewed
			GROUP BY customer_id, offer_id
),
	distinct_offers_completed AS (							-- CTE that counts the amount of times a customer completed any individual offer
			SELECT 	 customer_id, offer_id,
					 COUNT(*) AS num_completed
			FROM 	 offers_completed
			GROUP BY customer_id, offer_id
),
   offers_raw_funnel_level_cm AS (							-- Left join the tables to create the funnel. A left join will ensure that a value is null if that stage is not reached. 
			SELECT	 dor.customer_id, dor.offer_id, dor.num_received, dov.num_viewed, doc.num_completed
			FROM 	 distinct_offers_received dor LEFT JOIN distinct_offers_viewed dov
					 ON dor.customer_id = dov.customer_id AND dor.offer_id = dov.offer_id
												  LEFT JOIN distinct_offers_completed doc 
					 ON dor.customer_id = doc.customer_id AND dor.offer_id = doc.offer_id
)
SELECT 	 customer_id, offer_id, num_received, num_viewed,   -- Make it so that num_completed is non-null if num_viewed is non-null.
		 CASE WHEN num_completed IS NOT NULL AND num_viewed IS NULL THEN NULL ELSE num_completed END as num_completed
FROM   	 offers_raw_funnel_level_cm
);

-- I will now create a view which aggregates the funnel above, which is at the granularity of customer to the granularity of offer.
DROP VIEW IF EXISTS funnel_offer;
CREATE VIEW funnel_offer AS (
WITH offers_funnel_totals AS (								-- For each offer, this CTE counts the number of times each stage was reached by a customer.
		SELECT 	 offer_id,
				 COUNT(num_received) as total_received_cm,
				 COUNT(num_viewed) as total_viewed_cm,
				 COUNT(num_completed) as total_completed_cm
		FROM 	 funnel_cm
		GROUP BY 1
)															-- This joins the offers table to get more info on each offer and creates columns that tell us the percentage conversion rate through the funnel.
SELECT	 oft.offer_id, o.offer_type, o.difficulty, o.reward, o.duration, o.web, o.email, o.mobile, o.social, oft.total_received_cm,
		 oft.total_viewed_cm / oft.total_received_cm as viewed_percentage,
         total_viewed_cm,
         oft.total_completed_cm / oft.total_viewed_cm as completed_percentage_from_view,
         oft.total_completed_cm / oft.total_received_cm as completed_percentage_from_received,
         total_completed_cm
FROM 	 offers_funnel_totals oft INNER JOIN offers o
		 ON oft.offer_id = o.offer_id
);
 