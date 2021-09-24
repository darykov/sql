SELECT id
   FROM table
LIMIT 15;

--------------------------------------------------------------------------------------------

SELECT w.occurred_at, w.channel, a.name, a.primary_poc
FROM web_events w
JOIN accounts a
ON a.id = w.id
WHERE a.name = 'Walmart';

SELECT r.name region_name, s.name salesRep_name, a.name account_name
FROM sales_reps s
JOIN region r
ON r.id = s.region_id
JOIN accounts a
ON a.sales_rep_id = s.id
ORDER BY a.name;

SELECT r.name region_name, o.id order_id, a.name account_name, o.total_amt_usd/(o.total + 0.01) unit_price
FROM orders o
JOIN accounts a
ON o.account_id = a.id
JOIN sales_reps s
ON a.sales_rep_id = s.id
JOIN region r
ON r.id = s.region_id;

------------------------------------------------------------------------

SELECT r.name region_name, s.name sales_rep_name, a.name account_name
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a 
ON a.sales_rep_id = s.id
WHERE r.name = 'Midwest'
ORDER BY a.name

SELECT r.name region_name, s.name sales_rep_name, a.name account_name
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a 
ON a.sales_rep_id = s.id
WHERE r.name = 'Midwest' AND s.name LIKE 'S%'
ORDER BY a.name

SELECT r.name region_name, s.name sales_rep_name, a.name account_name
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a 
ON a.sales_rep_id = s.id
WHERE r.name = 'Midwest' AND s.name LIKE '%K%'
ORDER BY a.name

SELECT r.name region_name, a.name account_name, o.total_amt_usd/(o.total + 0.01) unit_price
FROM orders o
JOIN accounts a
ON o.account_id = a.id
JOIN sales_reps s
ON a.sales_rep_id = s.id
JOIN region r
ON r.id = s.region_id
WHERE standard_qty > 100;

SELECT r.name region_name, a.name account_name, o.total_amt_usd/(o.total + 0.01) unit_price
FROM orders o
JOIN accounts a
ON o.account_id = a.id
JOIN sales_reps s
ON a.sales_rep_id = s.id
JOIN region r
ON r.id = s.region_id
WHERE standard_qty > 100 AND poster_qty >50
ORDER BY unit_price DESC;

SELECT DISTINCT w.channel, a.id
FROM accounts a 
JOIN web_events w
ON a.id = w.account_id
WHERE a.id = 1001

SELECT w.occurred_at, a.name, o.total, o.total_amt_usd
FROM accounts a 
JOIN web_events w
ON a.id = w.account_id
JOIN orders o
ON a.id = o.account_id
WHERE w.occurred_at BETWEEN '2015-01-01' AND '2016-01-01'

-------------------------------------------------------------------------------

SELECT AVG(standard_amt_usd)/AVG(standard_qty) standard, AVG(gloss_amt_usd)/AVG(gloss_qty) gloss, 
AVG(poster_amt_usd)/AVG(poster_qty) poster, AVG(standard_qty) avstd, AVG(gloss_qty) avgls, AVG(poster_qty) avpos
FROM orders

------------------------------------------------------------------------------------
--GROUP BY QUIZ
------------------------------------------------------------------------------------
SELECT a.name, o.occurred_at
FROM accounts a
JOIN orders o
ON a.id = o.account_id
ORDER BY occurred_at
LIMIT 1;

---------------------------------------------------------------------

SELECT sum(o.total), a.name
FROM orders o
JOIN accounts a 
ON a.id = o.account_id
GROUP BY a.name;

SELECT w.channel, a.name, w.occurred_at
FROM web_events w
JOIN accounts a 
ON a.id = w.account_id
ORDER BY w.occurred_at DESC
LIMIT 1;

SELECT channel, count(channel)
FROM web_events
GROUP BY channel;

SELECT a.primary_poc
FROM web_events w
JOIN accounts a 
ON w.account_id = a.id
ORDER BY w.occurred_at
LIMIT 1;

SELECT a.name, MIN(o.total_amt_usd)
FROM orders o
JOIN accounts a 
ON o.account_id = a.id
GROUP BY a.name

SELECT r.id, count(*)
FROM sales_reps s
JOIN region r 
ON s.region_id = r.id
GROUP BY r.id

SELECT COUNT(w.channel), s.name, w.channel
FROM web_events w
JOIN accounts a
ON a.id = w.account_id
JOIN sales_reps s
ON s.id=a.sales_rep_id
GROUP BY s.name, w.channel
ORDER BY COUNT(w.channel) DESC

SELECT COUNT(w.channel), r.name, w.channel
FROM web_events w
JOIN accounts a
ON a.id = w.account_id
JOIN sales_reps s
ON s.id=a.sales_rep_id
JOIN region r
ON r.id = s.region_id
GROUP BY r.name, w.channel
ORDER BY COUNT(w.channel) DESC

--------------------------------------------------------------------------------
-- HAVING
--------------------------------------------------------------------------------

SELECT s.name, COUNT(a.id)
FROM accounts a 
JOIN sales_reps s
ON a.sales_rep_id = s.id
GROUP BY s.name
HAVING COUNT(a.id) > 5

SELECT a.name, COUNT(o.id)
FROM accounts a 
JOIN orders o 
ON a.id = o.account_id
GROUP BY a.name
HAVING COUNT(o.id) > 20

SELECT s.name, COUNT(a.id)
FROM accounts a 
JOIN sales_reps s
ON a.sales_rep_id = s.id
GROUP BY s.name
ORDER BY COUNT(a.id) DESC
LIMIT 1

SELECT a.name, SUM(o.total_amt_usd)
FROM accounts a 
JOIN orders o 
ON a.id = o.account_id
GROUP BY a.name
HAVING SUM(o.total_amt_usd) > 30000

SELECT a.name, SUM(o.total_amt_usd)
FROM accounts a 
JOIN orders o 
ON a.id = o.account_id
GROUP BY a.name
HAVING SUM(o.total_amt_usd) < 1000

SELECT a.name, SUM(o.total_amt_usd)
FROM accounts a 
JOIN orders o 
ON a.id = o.account_id
GROUP BY a.name
ORDER BY SUM(o.total_amt_usd) DESC
LIMIT 1

SELECT a.name, SUM(o.total_amt_usd)
FROM accounts a 
JOIN orders o 
ON a.id = o.account_id
GROUP BY a.name
ORDER BY SUM(o.total_amt_usd) 
LIMIT 1

SELECT a.name, COUNT(w.channel), w.channel
FROM accounts a 
JOIN web_events w 
ON a.id = w.account_id
GROUP BY a.name, w.channel
HAVING w.channel = 'facebook' AND COUNT(w.channel) > 6

SELECT a.name, COUNT(w.channel), w.channel
FROM accounts a 
JOIN web_events w 
ON a.id = w.account_id
GROUP BY a.name, w.channel
HAVING w.channel = 'facebook'
ORDER BY COUNT(w.channel) DESC
LIMIT 1

SELECT a.name, COUNT(w.channel), w.channel
FROM accounts a 
JOIN web_events w 
ON a.id = w.account_id
GROUP BY a.name, w.channel
ORDER BY COUNT(w.channel) DESC

------------------------------------------------
-- DATE FUNCTIONS
---------------------------------------------------

SELECT DATE_TRUNC('year', occurred_at), SUM(total_amt_usd)
FROM orders
GROUP BY 1
ORDER BY 2 DESC

SELECT DATE_PART('month', occurred_at), SUM(total_amt_usd)
FROM orders
GROUP BY 1
ORDER BY 2 DESC

SELECT DATE_TRUNC('year', occurred_at), SUM(total)
FROM orders
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1

SELECT DATE_PART('month', occurred_at), SUM(total)
FROM orders
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1

SELECT DATE_TRUNC('year', o.occurred_at), DATE_PART('month', o.occurred_at), SUM(o.gloss_amt_usd)
FROM orders o
JOIN accounts a 
ON a.id = o.account_id
GROUP BY 2
HAVING a.name = 'Walmart'
ORDER BY 3 DESC

--------------------------------------------------------------
--- CASE
----------------------------------------------------------------


SELECT account_id, total_amt_usd, 
CASE WHEN total_amt_usd < 3000 THEN 'Small' 
ELSE 'Large' END as Level
FROM orders


SELECT SUM(total), 
CASE WHEN total >= 2000 THEN 'At Least 2000'
	  WHEN total < 2000 AND total >= 1000 THEN 'Between 1000 and 2000'
     ELSE 'Less than 1000' END as Level
FROM orders
GROUP BY Level

SELECT a.name, SUM(total_amt_usd),
CASE WHEN SUM(total_amt_usd) > 200000 THEN 'greater than 200,000'
     WHEN SUM(total_amt_usd) < 200000 AND    SUM(total_amt_usd)>=100000 THEN '200,000 and 100,000' ELSE 'Less than 100,000' END AS Level
FROM orders o
JOIN accounts a
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY SUM(total_amt_usd) DESC

SELECT a.name, SUM(total_amt_usd),
CASE WHEN SUM(total_amt_usd) > 200000 THEN 'greater than 200,000'
     WHEN SUM(total_amt_usd) < 200000 AND    SUM(total_amt_usd)>=100000 THEN '200,000 and 100,000' ELSE 'Less than 100,000' END AS Level
FROM orders o
JOIN accounts a
ON a.id = o.account_id
WHERE o.occurred_at BETWEEN '2016-01-01' AND '2018-01-01'
GROUP BY a.name
ORDER BY SUM(total_amt_usd) DESC

SELECT s.name, COUNT(*) AS tot_orders,
		  CASE WHEN COUNT(*) > 200 THEN 'Top'
        ELSE 'not' END as top_or_not
FROM sales_reps s
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON a.id = o.account_id
GROUP BY s.name
ORDER BY tot_orders DESC


SELECT s.name, COUNT(*) AS tot_orders, SUM(o.total_amt_usd),
		CASE WHEN COUNT(*) > 200 OR SUM(o.total_amt_usd) > 750000  THEN 'top'
        WHEN COUNT(*) > 150 OR SUM(o.total_amt_usd) > 500000  THEN 'middle'
        ELSE 'low' END as level
FROM sales_reps s
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON a.id = o.account_id
GROUP BY s.name
ORDER BY SUM(o.total_amt_usd) DESC












