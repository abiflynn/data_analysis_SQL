#Explore the Magist Tables

#1. How many orders are there in the dataset?
SELECT COUNT(*) 
AS orders_count 
FROM orders;

#2. Are orders actually delivered? (Total orders by status - total time period)
SELECT order_status, COUNT(*) 
AS orders 
FROM orders 
GROUP BY order_status;

#2a. Are orders actually delivered? (Total orders by status - 2018 Only)
SELECT order_status, COUNT(*) 
AS orders 
FROM orders 
WHERE order_purchase_timestamp >= '2018-01-01 00:00:00' 
AND order_purchase_timestamp <= '2018-12-31 23:59:59' 
GROUP BY order_status;

#2b. Are orders actually delivered? (Check total orders 2018 Only)
SELECT COUNT(*) 
AS orders_count 
FROM orders 
WHERE order_purchase_timestamp >= '2018-01-01 00:00:00' 
AND order_purchase_timestamp <= '2018-12-31 23:59:59';

#3. Is Magist having user growth? (Customer count by month and year)
SELECT YEAR(order_purchase_timestamp) 
AS year_, 
MONTH(order_purchase_timestamp) 
AS month_, COUNT(customer_id) 
FROM orders GROUP BY year_ , month_ 
ORDER BY year_ , month_;

#3a. Is Magist having user growth? (Customer count by year only)
SELECT YEAR(order_purchase_timestamp) 
AS year_, COUNT(customer_id) 
FROM orders GROUP BY year_ 
ORDER BY year_;

#4. How many products are there in the products table? (Total count of products 32,951)
SELECT COUNT(DISTINCT product_id) 
AS products_count 
FROM products;

#5. Which are the categories with most products? (Only includes German Names for Product Categories)
SELECT product_category_name, COUNT(DISTINCT product_id) 
AS n_products 
FROM products 
GROUP BY product_category_name 
ORDER BY COUNT(product_id) DESC;

#5a. Which are the categories with most products? (Includes a join to get the english category names)
SELECT product_category_name_english, COUNT(product_id) 
FROM products 
LEFT JOIN product_category_name_translation 
ON product_category_name_translation.product_category_name=products.product_category_name 
GROUP BY product_category_name_english;

#6. How many of those products were present in actual transactions?
SELECT COUNT(DISTINCT product_id) 
AS n_products 
FROM order_items; 

#6a. How many of those products were present in actual transactions? (Order quantity from tech related categories and percent mixes) - ??HOW TO GET TO NUMBER OF PRODUCTS ORDERED FROM TECH CATEGORIES -DISTINCT
SELECT product_category_name_translation.product_category_name_english, COUNT(order_id) AS Order_quantity , (COUNT(order_id) / (SELECT COUNT(*)  FROM order_items)*100) AS Percentage
FROM products
RIGHT JOIN order_items
ON products.product_id = order_items.product_id
JOIN product_category_name_translation
ON products.product_category_name = product_category_name_translation.product_category_name
WHERE product_category_name_english in ('telephony', 'computers_accessories', 'electronics', 'computers', 'audio')
GROUP BY product_category_name_translation.product_category_name_english
ORDER BY COUNT(order_id) DESC; 

#7. What’s the price for the most expensive and cheapest products? - Cheapest £.0.85 / Most Expensive £6735
SELECT MIN(price) 
AS cheapest, MAX(price) 
AS most_expensive 
FROM order_items;

#7a. What’s the price for the most expensive and cheapest products? - (By tech relevant categories including average prices)
SELECT product_category_name_english, 
MAX(price) 
AS highest, MIN(price) 
AS lowest, AVG(price) AS average
FROM product_category_name_translation 
INNER JOIN products 
ON product_category_name_translation.product_category_name=products.product_category_name 
INNER JOIN order_items 
ON products.product_id=order_items.product_id 
WHERE product_category_name_english in ('telephony', 'computers_accessories', 'electronics', 'computers', 'audio')
GROUP BY product_category_name_english;

#8. What are the highest and lowest payment values? - Cheapest £.0 / Most Expensive £13,664
SELECT MAX(payment_value) 
AS highest, MIN(payment_value) 
AS lowest 
FROM order_payments;

#Answer Business Questions 

#In relation to the products: 
#1. What categories of tech products does Magist have? ('telephony', 'computers_accessories', 'electronics', 'computers', 'audio')
SELECT product_category_name_english, COUNT(product_id) 
FROM products 
LEFT JOIN product_category_name_translation 
ON product_category_name_translation.product_category_name=products.product_category_name 
GROUP BY product_category_name_english;

#2. How many products of these tech categories have been sold (within the time window of the database snapshot)? / What percentage does that represent from the overall number of products sold?
SELECT product_category_name_translation.product_category_name_english, COUNT(order_id) AS Order_quantity , (COUNT(order_id) / (SELECT COUNT(*)  FROM order_items)*100) AS Percentage
FROM products
RIGHT JOIN order_items
ON products.product_id = order_items.product_id
JOIN product_category_name_translation
ON products.product_category_name = product_category_name_translation.product_category_name
WHERE product_category_name_english in ('telephony', 'computers_accessories', 'electronics', 'computers', 'audio')
GROUP BY product_category_name_translation.product_category_name_english
ORDER BY COUNT(order_id) DESC; 

#3. What’s the average price of the products being sold?
SELECT product_category_name_english, 
AVG(price) AS average
FROM product_category_name_translation 
INNER JOIN products 
ON product_category_name_translation.product_category_name=products.product_category_name 
INNER JOIN order_items 
ON products.product_id=order_items.product_id 
WHERE product_category_name_english in ('telephony', 'computers_accessories', 'electronics', 'computers', 'audio')
GROUP BY product_category_name_english;

#4. Are expensive tech products popular?
SELECT product_category_name_english, 
AVG(price) AS average,COUNT(order_id)
FROM product_category_name_translation 
INNER JOIN products 
ON product_category_name_translation.product_category_name=products.product_category_name 
INNER JOIN order_items 
ON products.product_id=order_items.product_id 
WHERE product_category_name_english in ('telephony', 'computers_accessories', 'electronics', 'computers', 'audio')
GROUP BY product_category_name_english;

#In relation to the sellers:
#1. How many months of data are included in the magist database? (25 Months)
SELECT YEAR(order_purchase_timestamp) 
AS year_, 
MONTH(order_purchase_timestamp) 
AS month_, COUNT(customer_id) 
FROM orders GROUP BY year_ , month_ 
ORDER BY year_ , month_;

#2. How many sellers are there? (3095 sellers) How many Tech sellers are there? What percentage of overall sellers are Tech sellers?
SELECT COUNT(seller_id) FROM sellers;

#2a. How many Tech sellers are there? (630 Tech Sellers)
SELECT product_category_name_english, COUNT(DISTINCT seller_id)
FROM order_items
INNER JOIN products 
ON products.product_id=order_items.product_id
INNER JOIN product_category_name_translation 
ON product_category_name_translation.product_category_name=products.product_category_name 
WHERE product_category_name_english in ('telephony', 'computers_accessories', 'electronics', 'computers', 'audio')
GROUP BY product_category_name_english;

#2b. What percentage of overall sellers are Tech sellers? HOW DO I WRITE THE PERCENTAGE IN HERE (ANSWER 20.4%) NOT WRITE 
SELECT COUNT(DISTINCT seller_id), (COUNT(DISTINCT seller_id) / (SELECT COUNT(*)  FROM order_items)*100) AS Percentage
FROM order_items
INNER JOIN products 
ON products.product_id=order_items.product_id;

#3. What is the total amount earned by all sellers? 
SELECT SUM(price)
FROM order_items;

#3a. What is the total amount earned by all Tech sellers?
SELECT product_category_name_english, SUM(price), (SUM(price) / (SELECT SUM(price)  FROM order_items)*100) AS Percentage 
FROM order_items
INNER JOIN products 
ON products.product_id=order_items.product_id
INNER JOIN product_category_name_translation 
ON product_category_name_translation.product_category_name=products.product_category_name 
WHERE product_category_name_english in ('telephony', 'computers_accessories', 'electronics', 'computers', 'audio')
GROUP BY product_category_name_english;

#4. Can you work out the average monthly income of all sellers?
SELECT SUM(price), (SUM(price) / COUNT(DISTINCT seller_id)) AS revenue_per_seller, (SUM(price) / COUNT(DISTINCT seller_id)/(25)) AS monthly_earnings_per_seller
FROM order_items;

#4a. Can you work out the average monthly income of Tech sellers?
SELECT product_category_name_english, SUM(price), (SUM(price) / COUNT(DISTINCT seller_id)) AS revenue_per_seller, (SUM(price) / COUNT(DISTINCT seller_id)/(25)) AS monthly_earnings_per_seller
FROM order_items
INNER JOIN products 
ON products.product_id=order_items.product_id
INNER JOIN product_category_name_translation 
ON product_category_name_translation.product_category_name=products.product_category_name 
WHERE product_category_name_english in ('telephony', 'computers_accessories', 'electronics', 'computers', 'audio')
GROUP BY product_category_name_english;

# In relation to the delivery time:
#1. What’s the average time between the order being placed and the product being delivered? (12.5 Days) 
SELECT AVG(datediff(order_purchase_timestamp, order_delivered_customer_date)) FROM orders;

#1a. average time between estimated and delivered date (11.9 Days) 
SELECT AVG(datediff(order_delivered_customer_date, order_estimated_delivery_date)) FROM orders;

#1b. difference in delivered vs estimated by tech relevant categories
SELECT product_category_name_english, AVG(datediff(order_delivered_customer_date, order_estimated_delivery_date))
FROM orders
INNER JOIN order_items
ON orders.order_id=order_items.order_id
INNER JOIN products 
ON products.product_id=order_items.product_id
INNER JOIN product_category_name_translation 
ON product_category_name_translation.product_category_name=products.product_category_name 
WHERE product_category_name_english in ('telephony', 'computers_accessories', 'electronics', 'computers', 'audio')
GROUP BY product_category_name_english;

#2. How many orders are delivered on time vs orders delivered with a delay? Total = 96476 orders delivered 
SELECT COUNT(datediff(order_delivered_customer_date, order_estimated_delivery_date))
FROM orders; 

#2. How many orders are delivered on time vs orders delivered with a delay? 90750 Orders delivered =1 or less days after estimation (94%) and 5726 delivered over 1 days after estimation (5.9%)
#PERCENTAGES ARE NOT PULLING CORRECT  
SELECT COUNT(datediff(order_delivered_customer_date, order_estimated_delivery_date)), 
(COUNT(datediff(order_delivered_customer_date, order_estimated_delivery_date)) / (SELECT COUNT(*)  FROM orders)*100) AS Percentage
FROM orders 
WHERE datediff(order_delivered_customer_date, order_estimated_delivery_date) >1;

#3. Is there any pattern for delayed orders, e.g. big products being delayed more often?
SELECT product_category_name_english, AVG(datediff(order_delivered_customer_date, order_estimated_delivery_date)) AS average_diff_est_delivered
FROM orders
INNER JOIN order_items
ON orders.order_id=order_items.order_id
INNER JOIN products 
ON products.product_id=order_items.product_id
INNER JOIN product_category_name_translation 
ON product_category_name_translation.product_category_name=products.product_category_name 
GROUP BY product_category_name_english
ORDER BY average_diff_est_delivered ASC;

#Playing around with the weigth to see if there is a pattern for large products 
SELECT count(o.order_id) AS number_of_orders,
CASE
    WHEN timestampdiff(day, order_estimated_delivery_date, order_delivered_customer_date) < 1 then 'ON_time'
    ELSE 'delayed'
    END AS delivery_date_check,
CASE
    WHEN product_weight_g > 19999 THEN 'VERY HEAVY 20kg+'
    WHEN product_weight_g BETWEEN 10000 AND 19999 THEN 'HEAVY 10kg+'
    WHEN product_weight_g BETWEEN 5000 AND 9999 THEN 'MEDIUM 5kg+'
    ELSE 'LIGHT <5kg'
    END AS weight_categories
FROM
    orders o
RIGHT JOIN
    order_items oi
ON
    o.order_id=oi.order_id
RIGHT JOIN
    products p
ON
    oi.product_id=p.product_id
GROUP BY
    delivery_date_check, weight_categories
ORDER BY
    weight_categories DESC;

SELECT delivery_status, COUNT(*)
FROM 
(SELECT TIMESTAMPDIFF (DAY, order_estimated_delivery_date,order_delivered_customer_date),
CASE 
WHEN (TIMESTAMPDIFF (DAY, order_estimated_delivery_date,order_delivered_customer_date)) > 0 THEN "delivered with a delay"
WHEN (TIMESTAMPDIFF (DAY, order_estimated_delivery_date,order_delivered_customer_date)) = 0 THEN "delivered on time"
ELSE "delivered earlier"
END delivery_status
FROM orders) AS delivery_table
GROUP BY delivery_status;

#Average freight value by tech category
SELECT product_category_name_english, 
AVG(freight_value) AS average
FROM product_category_name_translation 
INNER JOIN products 
ON product_category_name_translation.product_category_name=products.product_category_name 
INNER JOIN order_items 
ON products.product_id=order_items.product_id
WHERE product_category_name_english in ('telephony', 'computers_accessories', 'electronics', 'computers', 'audio')
GROUP BY product_category_name_english;

SELECT count(o.order_id) AS number_of_orders,
CASE
    WHEN timestampdiff(day, order_estimated_delivery_date, order_delivered_customer_date) < 1 then 'ON_time'
    ELSE 'delayed'
    END AS delivery_date_check,
CASE
    WHEN product_weight_g > 19999 THEN 'VERY HEAVY 20kg+'
    WHEN product_weight_g BETWEEN 10000 AND 19999 THEN 'HEAVY 10kg+'
    WHEN product_weight_g BETWEEN 5000 AND 9999 THEN 'MEDIUM 5kg+'
    ELSE 'LIGHT <5kg'
    END AS weight_categories
FROM
    orders o
RIGHT JOIN
    order_items oi
ON
    o.order_id=oi.order_id
RIGHT JOIN
    products p
ON
    oi.product_id=p.product_id
GROUP BY
    delivery_date_check, weight_categories
ORDER BY
    weight_categories DESC;

SELECT SUM(price) FROM order_items;

SELECT SUM(payment_value) FROM order_payments;

SELECT SUM(price + freight_value) FROM order_items;

SELECT SUM(order_item_id) FROM order_items;

SELECT state, 
COUNT(order_item_id) AS count_orders, 
(COUNT(order_item_id) / (SELECT COUNT(*)  FROM order_items)*100) AS Percentage
FROM geo
INNER JOIN sellers
ON geo.zip_code_prefix=sellers.seller_zip_code_prefix
INNER JOIN order_items 
ON sellers.seller_id=order_items.seller_id
GROUP BY state;

SELECT state, 
COUNT(order_item_id) AS count_orders
FROM geo
INNER JOIN sellers
ON geo.zip_code_prefix=sellers.seller_zip_code_prefix
INNER JOIN order_items 
ON sellers.seller_id=order_items.seller_id;
