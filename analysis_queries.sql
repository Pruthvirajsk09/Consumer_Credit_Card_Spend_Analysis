-- -- Q1. What is the average credit limit?

SELECT 
    ROUND(AVG(credit_limit), 2) AS avg_credit
FROM
    customers;

-- Q2. Which type of credit card is most commonly held by customers?

SELECT 
    card_type, COUNT(card_type) AS frequency
FROM
    customers
GROUP BY card_type
ORDER BY frequency DESC
LIMIT 1;

-- Q3. What is the average age of credit card holders?

SELECT 
    ROUND(AVG(age), 2) AS avg_age
FROM
    customers;

-- Q4. What is the most common spending category?

SELECT 
    product_type, COUNT(product_type) AS frequency
FROM
    spend
GROUP BY product_type
ORDER BY frequency DESC
LIMIT 1;


-- Q5. Show the month-wise spend across the years in descending order.

SELECT 
    TO_CHAR(date, 'Month') AS month_name,
    SUM(amount) AS total_amt
FROM
    spend
GROUP BY month_name
ORDER BY total_amt DESC;


-- Q6. What is the average spend per category?

SELECT 
    product_type, AVG(amount) AS avg_amount
FROM
    spend
GROUP BY product_type;


-- Q7. What is the average no. of transactions per month?

SELECT 
    TO_CHAR(date, 'month') AS month, COUNT(*) AS total_trans
FROM
    spend
GROUP BY month;


-- Q8. List the top 5 cities with the highest amount spent along with their no. of transactions.

SELECT 
    city, COUNT(*) AS trans_counts, SUM(amount) AS amt_spent
FROM
    customers cs
        JOIN
    spend sp ON cs.customer_id = sp.customer_id
GROUP BY city
ORDER BY SUM(amount) DESC
LIMIT 5;


-- Q9. List the card types and the amount spent with them over the years.

SELECT 
    card_type, SUM(amount) AS amt_spent
FROM
    customers cs
        JOIN
    spend sp ON cs.customer_id = sp.customer_id
GROUP BY card_type;


-- Q10. Which is the most commonly used credit card type?

SELECT 
    card_type, COUNT(*) AS total_trans
FROM
    customers cs
        JOIN
    spend sp ON cs.customer_id = sp.customer_id
GROUP BY card_type
ORDER BY total_trans DESC;

-- Q11. What is the average no. of days a customer pays off their credit card bill?

WITH bill AS (
  SELECT spend.customer_id, 
         MAX(spend.date) AS spend_date, 
         MAX(repayment.date) AS repayment_date, 
         ABS((MAX(repayment.date) - MAX(spend.date))::int) AS days
  FROM spend
  JOIN customers ON customers.customer_id = spend.customer_id
  JOIN repayment ON repayment.customer_id = customers.customer_id
  GROUP BY 1
)
SELECT ROUND(AVG(days)) AS avg_days
FROM bill;

-- Q12. Show the customer base city-wise in descending order.

SELECT 
    city, COUNT(customer_id) AS total_customers
FROM
    customers
GROUP BY city
ORDER BY total_customers DESC;


-- Q13. What is the spending range of each customer?

select customer_id,concat(min(amount) ,'-', max(amount)) as range from spend group by customer_id;


