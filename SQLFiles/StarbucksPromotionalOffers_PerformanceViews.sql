/*  This is the creation of an offer performance view by offer */

DROP VIEW IF EXISTS offerID_performance;
CREATE VIEW offerID_performance AS 
WITH offerID_totals AS (
SELECT	 offer_id,
		 ROUND(COUNT(offer_id)) as num_completed,
		 ROUND(SUM(discounted_amount)) as total_discounted_amount, 
		 ROUND(SUM(due_amount)) as total_due_amount, 
		 ROUND(SUM(reward)) as total_cm_saved_amount
FROM 	 offers_completed
GROUP BY offer_id
)
SELECT 	 t.offer_id, t.num_completed, o.offer_type, t.total_discounted_amount, t.total_due_amount, t.total_cm_saved_amount, o.difficulty, o.reward, o.duration
FROM		 offerID_totals t INNER JOIN offers o
				 ON t.offer_id = o.offer_id
ORDER BY total_discounted_amount DESC;

/*  This is the creation of an offer performance view by offer type (without informational since you 
	cannot complete an informational offer) */
SELECT 	 offer_type,
				 AVG(num_completed) as mean_num_completed,
				 ROUND(AVG(total_discounted_amount)) as mean_discount,
				 ROUND(AVG(total_due_amount)) as mean_due,
				 ROUND(AVG(total_cm_saved_amount)) as mean_cm_saved,
				 AVG(difficulty),
				 AVG(reward),
				 AVG(duration)
FROM     offerID_performance
GROUP BY offer_type;