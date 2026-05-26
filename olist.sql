-- ============================================================
--        OLIST BRAZILIAN E-COMMERCE — SQL ANALYSIS
--        Dataset  : https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce
--        Tool     : PostgreSQL
--        Author   : Subhash
--        Purpose  : Portfolio Project — Data Analyst
--============================================================


--============================================================
--                  SECTION 1: TABLE SETUP
--============================================================

-- TABLE 1: CUSTOMERS
CREATE TABLE customers (
    customer_id              VARCHAR(50) PRIMARY KEY,
    customer_unique_id       VARCHAR(50),
    customer_zip_code_prefix VARCHAR(10),
    customer_city            VARCHAR(100),
    customer_state           VARCHAR(5)
);

-- TABLE 2: GEOLOCATION
CREATE TABLE geolocation (
    geolocation_zip_code_prefix VARCHAR(10),
    geolocation_lat             DECIMAL(18,15),
    geolocation_lng             DECIMAL(18,15),
    geolocation_city            VARCHAR(100),
    geolocation_state           VARCHAR(5)
);

-- TABLE 3: SELLERS
CREATE TABLE sellers (
    seller_id              VARCHAR(50) PRIMARY KEY,
    seller_zip_code_prefix VARCHAR(10),
    seller_city            VARCHAR(100),
    seller_state           VARCHAR(5)
);

-- TABLE 4: PRODUCTS
CREATE TABLE products (
    product_id                 VARCHAR(50) PRIMARY KEY,
    product_category_name      VARCHAR(100),
    product_name_length        INT,
    product_description_length INT,
    product_photos_qty         INT,
    product_weight_g           INT,
    product_length_cm          INT,
    product_height_cm          INT,
    product_width_cm           INT
);

-- TABLE 5: ORDERS
CREATE TABLE orders (
    order_id                      VARCHAR(50) PRIMARY KEY,
    customer_id                   VARCHAR(50),
    order_status                  VARCHAR(50),
    order_purchase_timestamp      TIMESTAMP,
    order_approved_at             TIMESTAMP,
    order_delivered_carrier_date  TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP
);

-- TABLE 6: ORDER ITEMS
CREATE TABLE order_items (
    order_id            VARCHAR(50),
    order_item_id       INT,
    product_id          VARCHAR(50),
    seller_id           VARCHAR(50),
    shipping_limit_date TIMESTAMP,
    price               DECIMAL(10,2),
    freight_value       DECIMAL(10,2)
);

-- TABLE 7: PAYMENTS
CREATE TABLE payments (
    order_id             VARCHAR(50),
    payment_sequential   INT,
    payment_type         VARCHAR(50),
    payment_installments INT,
    payment_value        DECIMAL(10,2)
);

-- TABLE 8: REVIEWS
CREATE TABLE reviews (
    review_id               VARCHAR(50),
    order_id                VARCHAR(50),
    review_score            INT,
    review_comment_title    VARCHAR(100),
    review_comment_message  TEXT,
    review_creation_date    TIMESTAMP,
    review_answer_timestamp TIMESTAMP
);

-- TABLE 9: PRODUCT CATEGORY TRANSLATION
CREATE TABLE product_category_translation (
    product_category_name         VARCHAR(100),
    product_category_name_english VARCHAR(100)
);

-- TABLE 10: BRAZIL STATES (Reference Table)
-- Objective : Maps 2-letter state codes to full state names.
--             Used across multiple queries to improve readability.
CREATE TABLE brazil_states (
    state_code VARCHAR(5)   PRIMARY KEY,
    state_name VARCHAR(100) NOT NULL
);

INSERT INTO brazil_states (state_code, state_name) VALUES
    ('AC', 'Acre'),
    ('AL', 'Alagoas'),
    ('AP', 'Amapá'),
    ('AM', 'Amazonas'),
    ('BA', 'Bahia'),
    ('CE', 'Ceará'),
    ('DF', 'Distrito Federal'),
    ('ES', 'Espírito Santo'),
    ('GO', 'Goiás'),
    ('MA', 'Maranhão'),
    ('MT', 'Mato Grosso'),
    ('MS', 'Mato Grosso do Sul'),
    ('MG', 'Minas Gerais'),
    ('PA', 'Pará'),
    ('PB', 'Paraíba'),
    ('PR', 'Paraná'),
    ('PE', 'Pernambuco'),
    ('PI', 'Piauí'),
    ('RJ', 'Rio de Janeiro'),
    ('RN', 'Rio Grande do Norte'),
    ('RS', 'Rio Grande do Sul'),
    ('RO', 'Rondônia'),
    ('RR', 'Roraima'),
    ('SC', 'Santa Catarina'),
    ('SP', 'São Paulo'),
    ('SE', 'Sergipe'),
    ('TO', 'Tocantins');


-- ============================================================
--                SECTION 2: DATA VALIDATION
-- ============================================================

-- Row count check for all tables
SELECT 'customers' AS table_name, COUNT(*) AS total_rows FROM customers
UNION ALL
SELECT 'orders',COUNT(*) FROM orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL
SELECT 'products',COUNT(*) FROM products
UNION ALL
SELECT 'sellers',COUNT(*) FROM sellers
UNION ALL
SELECT 'payments',COUNT(*)  FROM payments
UNION ALL
SELECT 'reviews', COUNT(*) FROM reviews
UNION ALL
SELECT 'geolocation',  COUNT(*)  FROM geolocation
UNION ALL
SELECT 'product_category_translation', COUNT(*)  FROM product_category_translation
UNION ALL
SELECT 'brazil_states',  COUNT(*) FROM brazil_states;

-- Quick preview of orders table
SELECT * FROM orders LIMIT 10;


--=============================================================
--           SECTION 3: ORDER ANALYSIS (Q1 – Q5)
--=============================================================

---------------------------------------------------------------
-- Q1. Order Status Distribution
-- Objective : Understand how orders are distributed across
--             different statuses to monitor fulfillment health.
-- Tables    : orders
---------------------------------------------------------------
SELECT
    order_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;


---------------------------------------------------------------
-- Q2. Undelivered Orders Breakdown
-- Objective : Identify which non-delivered statuses exist
--             and how many orders fall under each.
-- Tables    : orders
---------------------------------------------------------------
SELECT
    order_status,
    COUNT(*) AS total_orders
FROM orders
WHERE order_status != 'delivered'
GROUP BY order_status
ORDER BY total_orders DESC;


---------------------------------------------------------------
-- Q3. Total Undelivered Orders Count
-- Objective : Get a single number for undelivered orders
--             to track overall operational risk.
-- Tables    : orders
---------------------------------------------------------------
SELECT COUNT(*) AS not_delivered_orders
FROM orders
WHERE order_status != 'delivered';


---------------------------------------------------------------
-- Q4. Monthly Order Volume Trend
-- Objective : Track how order volume changes month over month
--             to identify growth or seasonal patterns.
-- Tables    : orders
---------------------------------------------------------------
SELECT
    EXTRACT(YEAR FROM order_purchase_timestamp) AS year,
    EXTRACT(MONTH FROM order_purchase_timestamp) AS month,
    COUNT(*) AS total_orders
FROM orders
GROUP BY year, month
ORDER BY year, month;


---------------------------------------------------------------
-- Q5. Top 3 Busiest Months
-- Objective : Identify peak order months for inventory
--             and logistics planning.
-- Tables    : orders
---------------------------------------------------------------
SELECT
    EXTRACT(YEAR FROM order_purchase_timestamp) AS year,
    EXTRACT(MONTH FROM order_purchase_timestamp) AS month,
    COUNT(*) AS total_orders
FROM orders
GROUP BY year, month
ORDER BY total_orders DESC
LIMIT 3;


---============================================================
--           SECTION 4: CUSTOMER ANALYSIS (Q6 – Q7)
---============================================================

-- ------------------------------------------------------------
-- Q6. Customer Distribution by State (Top 5)
-- Objective : Find which states have the most customers
--             to guide regional marketing strategies.
-- Tables    : customers, brazil_states
-- Note      : customer_unique_id used to avoid double-counting
--             the same customer across multiple orders.
---------------------------------------------------------------
SELECT
    bs.state_name  AS state,
    COUNT(DISTINCT c.customer_unique_id) AS total_customers
FROM customers c
JOIN brazil_states bs 
ON c.customer_state = bs.state_code
GROUP BY bs.state_name
ORDER BY total_customers DESC
LIMIT 5;


---------------------------------------------------------------
-- Q7. Orders with Customer State 
-- Objective : Combine order data with customer location
--             to enable geographic order analysis.
-- Tables    : orders, customers, brazil_states
---------------------------------------------------------------
SELECT
    o.order_id,
    o.order_status,
    o.order_purchase_timestamp,
    bs.state_name AS customer_state
FROM orders o
JOIN customers c    
ON o.customer_id = c.customer_id
JOIN brazil_states bs 
ON c.customer_state = bs.state_code
LIMIT 10;


---============================================================
--       SECTION 5: REVENUE & DELIVERY ANALYSIS (Q8 – Q9)
---============================================================

---------------------------------------------------------------
-- Q8. Revenue and Orders by State (Top 5)
-- Objective : Identify the highest revenue-generating states
--             to prioritize regional business strategies.
-- Tables    : orders, customers, order_items, brazil_states
-- Note      : Revenue = product price only (freight excluded).
---------------------------------------------------------------

SELECT
    bs.state_name  AS state,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM orders o
JOIN customers c    
ON o.customer_id = c.customer_id
JOIN order_items oi 
ON o.order_id = oi.order_id
JOIN brazil_states bs 
ON c.customer_state = bs.state_code
GROUP BY bs.state_name
ORDER BY total_revenue DESC
LIMIT 5;


---------------------------------------------------------------
-- Q9. Average Delivery Time by State (Top 10 Fastest)
-- Objective : Measure logistics efficiency per state to
--             identify regions with delivery challenges.
-- Tables    : orders, customers, brazil_states
---------------------------------------------------------------

SELECT
    bs.state_name AS state,
    ROUND(AVG( EXTRACT(EPOCH FROM (o.order_delivered_customer_date - o.order_purchase_timestamp)) / 86400), 1) AS avg_delivery_days
FROM orders o
JOIN customers c    
ON o.customer_id = c.customer_id
JOIN brazil_states bs 
ON c.customer_state = bs.state_code
WHERE o.order_status = 'delivered' AND o.order_delivered_customer_date IS NOT NULL
GROUP BY bs.state_name
ORDER BY avg_delivery_days ASC
LIMIT 10;


-- ============================================================
--           SECTION 6: PAYMENT ANALYSIS (Q10)
-- ============================================================

---------------------------------------------------------------
-- Q10. Payment Type Analysis
-- Objective : Understand customer payment preferences to
--             optimize the checkout experience.
-- Tables    : payments
-- Note      : COUNT(DISTINCT order_id) used because one order
--             can have multiple payment rows (installments).
---------------------------------------------------------------
SELECT
    payment_type,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(payment_value), 2) AS total_payment_value
FROM payments
GROUP BY payment_type
ORDER BY total_payment_value DESC;


---============================================================
--       SECTION 7: PRODUCT & CATEGORY ANALYSIS (Q11, Q14, Q15)
-- ============================================================

-------------------------------------------------------------------
-- Q11. Average Review Score by Product Category (Top 10)
-- Objective : Identify the highest-rated product categories
--             to understand what customers value most.
-- Tables    : reviews, order_items, products,
--             product_category_translation
--------------------------------------------------------------
SELECT
    pct.product_category_name_english AS category_name,
    ROUND(AVG(r.review_score), 2)     AS avg_review_score,
    COUNT(r.review_id)                AS total_reviews
FROM reviews r
JOIN order_items oi 
ON r.order_id             = oi.order_id
JOIN products p     ON oi.product_id          = p.product_id
JOIN product_category_translation pct
                    ON p.product_category_name = pct.product_category_name
GROUP BY pct.product_category_name_english
ORDER BY avg_review_score DESC
LIMIT 10;



----------------------------------------------------------------
-- Q14. Product Categories with Most Late Deliveries (Top 10)
-- Objective : Find categories most affected by late deliveries
--             to improve supply chain performance.
-- Tables    : orders, order_items, products,
--             product_category_translation
-- Definition: Late = actual delivery date > estimated date
-------------------------------------------------------------------
SELECT
    pct.product_category_name_english AS category_name,
    COUNT(*)  AS late_deliveries,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS late_percentage
FROM orders o
JOIN order_items oi 
ON o.order_id = oi.order_id
JOIN products p     
ON oi.product_id = p.product_id
JOIN product_category_translation pct
ON p.product_category_name = pct.product_category_name
WHERE o.order_status = 'delivered' AND o.order_delivered_customer_date > o.order_estimated_delivery_date
GROUP BY pct.product_category_name_english
ORDER BY late_deliveries DESC
LIMIT 10;


--------------------------------------------------------------
-- Q15. Top 10 Best-Selling Product Categories
-- Objective : Identify top revenue-driving categories for
--             inventory planning and marketing focus.
-- Tables    : orders, order_items, products,
--             product_category_translation
------------------------------------------------------------------

SELECT
    pct.product_category_name_english AS category_name,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM orders o
JOIN order_items oi 
ON o.order_id =   oi.order_id
JOIN products p     
ON oi.product_id = p.product_id
JOIN product_category_translation pct
ON p.product_category_name = pct.product_category_name
WHERE o.order_status = 'delivered'
GROUP BY pct.product_category_name_english
ORDER BY total_orders DESC, total_revenue DESC
LIMIT 10;


--=============================================================
--         SECTION 8: REVENUE TREND ANALYSIS (Q12)
--=============================================================

--=------------------------------------------------------------
-- Q12. Monthly Revenue Trend (2016,2017 & 2018)
-- Objective : Track revenue growth over time to identify
--             business momentum and seasonal patterns.
-- Tables    : orders, order_items
---=------------------------------------------------------------
SELECT
    DATE_TRUNC('month', o.order_purchase_timestamp) AS order_month,
    ROUND(SUM(oi.price), 2)                         AS total_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
  AND EXTRACT(YEAR FROM o.order_purchase_timestamp) IN (2016,2017, 2018)
GROUP BY order_month
ORDER BY order_month;


---============================================================
--           SECTION 9: SELLER ANALYSIS (Q13)
---============================================================

---------------------------------------------------------------
-- Q13. Top 10 Best-Performing Sellers
-- Objective : Identify high-revenue sellers to recognize
--             top partners and study success patterns.
-- Tables    : orders, order_items, sellers, brazil_states
---------------------------------------------------------------

SELECT
    oi.seller_id,
    s.seller_city,
    bs.state_name AS seller_state,
    ROUND(SUM(oi.price), 2)  AS total_revenue,
    COUNT(DISTINCT oi.order_id)  AS total_orders
FROM orders o
JOIN order_items oi  
ON o.order_id = oi.order_id
JOIN sellers s       
ON oi.seller_id = s.seller_id
JOIN brazil_states bs 
ON s.seller_state  = bs.state_code
WHERE o.order_status = 'delivered'
GROUP BY oi.seller_id, s.seller_city, bs.state_name
ORDER BY total_revenue DESC, total_orders DESC
LIMIT 10;


---============================================================
--         SECTION 10: BEHAVIORAL ANALYSIS (Q16 – Q18)
---============================================================

---------------------------------------------------------------
-- Q16. Review Score vs Delivery Time
-- Objective : Analyze if faster delivery leads to better
--             reviews — a key customer satisfaction insight.
-- Tables    : orders, reviews
---------------------------------------------------------------
SELECT
    r.review_score,
    ROUND(AVG( EXTRACT(EPOCH FROM ( o.order_delivered_customer_date - o.order_purchase_timestamp )) / 86400 ), 2) AS avg_delivery_days,
    COUNT(*) AS total_orders
FROM orders o
JOIN reviews r 
ON o.order_id = r.order_id
WHERE o.order_status = 'delivered'
AND o.order_delivered_customer_date IS NOT NULL
GROUP BY r.review_score
ORDER BY r.review_score;


---------------------------------------------------------------
-- Q17. Orders by Day of Week
-- Objective : Find peak order days to optimize marketing
--             campaigns and staffing schedules.
-- Tables    : orders
---------------------------------------------------------------

SELECT
    EXTRACT(DOW FROM o.order_purchase_timestamp)     AS day_number,
    TRIM(TO_CHAR(o.order_purchase_timestamp, 'Day')) AS day_name,
    COUNT(*)                                         AS total_orders
FROM orders o
GROUP BY day_number, day_name
ORDER BY day_number;


---------------------------------------------------------------
-- Q18. Repeat Customer Analysis
-- Objective : Measure customer loyalty by identifying how
--             many customers placed more than one order.
-- Tables    : customers, orders
---------------------------------------------------------------

WITH customer_orders AS (
    SELECT
        c.customer_unique_id,
        COUNT(o.order_id) AS total_orders
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
)


SELECT
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE total_orders > 1) AS repeat_customers,
    ROUND(COUNT(*) FILTER (WHERE total_orders > 1) * 100.0 / COUNT(*), 2 ) AS repeat_customer_percentage
FROM customer_orders;


--============================================================
--          SECTION 11: ADVANCED ANALYSIS (Q19 – Q21)
--============================================================

--------------------------------------------------------------
-- Q19. RFM Customer Segmentation
-- Objective : Segment customers based on Recency, Frequency,
--             and Monetary value to identify VIP, loyal,
--             and at-risk customers.
-- Tables    : orders, customers, order_items
-- R = Days since last order  (lower  = more recent)
-- F = Total orders placed    (higher = more loyal)
-- M = Total amount spent     (higher = more valuable)
--------------------------------------------------------------

WITH delivered_orders AS (
    SELECT
        c.customer_unique_id,
        o.order_id,
        o.order_purchase_timestamp,
        oi.price
    FROM orders o
    JOIN customers c    
	ON o.customer_id  = c.customer_id
    JOIN order_items oi 
	ON o.order_id     = oi.order_id
    WHERE o.order_status = 'delivered'
),

max_date AS (
    SELECT MAX(order_purchase_timestamp) AS latest_date
    FROM delivered_orders
),

rfm_base AS (
    SELECT
        d.customer_unique_id,
        EXTRACT(DAY FROM (  m.latest_date - MAX(d.order_purchase_timestamp) ))   AS recency_days,
        COUNT(DISTINCT d.order_id) AS frequency,
        ROUND(SUM(d.price), 2) AS monetary
    FROM delivered_orders d
    CROSS JOIN max_date m
    GROUP BY d.customer_unique_id, m.latest_date
)

SELECT *
FROM rfm_base
ORDER BY monetary DESC
LIMIT 10;


--------------------------------------------------------------
-- Q20. Month-over-Month Revenue Growth (2017 & 2018)
-- Objective : Calculate monthly revenue growth percentage
--             to track business momentum over time.
-- Tables    : orders, order_items
-- Note      : * 100.0 forces decimal division to avoid
--               integer truncation in PostgreSQL.
--------------------------------------------------------------
WITH monthly_revenue AS (
    SELECT
        DATE_TRUNC('month', o.order_purchase_timestamp) AS order_month,
        ROUND(SUM(oi.price), 2) AS total_revenue
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
      AND EXTRACT(YEAR FROM o.order_purchase_timestamp) IN (2016, 2017, 2018)
    GROUP BY order_month
),

revenue_with_lag AS (
    SELECT
        order_month,
        total_revenue,
        LAG(total_revenue) OVER (ORDER BY order_month) AS prev_month_revenue
    FROM monthly_revenue
)

SELECT
    order_month,
    total_revenue,
    prev_month_revenue,
    ROUND( (total_revenue - prev_month_revenue) * 100.0 / prev_month_revenue , 2) AS mom_growth_pct
FROM revenue_with_lag
WHERE prev_month_revenue IS NOT NULL;


--------------------------------------------------------------
-- Q21. Seller Churn Analysis
-- Objective : Identify sellers who were active in 2017
--             but placed no orders in 2018.
-- Tables    : orders, order_items
-- Business Use: Target churned sellers for re-engagement
--               campaigns to recover lost supply.
--------------------------------------------------------------

WITH sellers_2017 AS (
    SELECT
        oi.seller_id,
        MAX(o.order_purchase_timestamp) AS last_order_date_2017,
        COUNT(DISTINCT o.order_id) AS total_orders_2017
    FROM orders o
    JOIN order_items oi 
	ON o.order_id = oi.order_id
    WHERE EXTRACT(YEAR FROM o.order_purchase_timestamp) = 2017
      AND o.order_status = 'delivered'
    GROUP BY oi.seller_id
),

sellers_2018 AS (
    SELECT DISTINCT oi.seller_id
    FROM orders o
    JOIN order_items oi 
	ON o.order_id = oi.order_id
    WHERE EXTRACT(YEAR FROM o.order_purchase_timestamp) = 2018
      AND o.order_status = 'delivered'
)

SELECT
    s17.seller_id,
    s17.last_order_date_2017,
    s17.total_orders_2017
FROM sellers_2017 s17
LEFT JOIN sellers_2018 s18 
ON s17.seller_id = s18.seller_id
WHERE s18.seller_id IS NULL
ORDER BY s17.total_orders_2017 DESC;


-- ============================================================
--                     END OF ANALYSIS
-- ============================================================

