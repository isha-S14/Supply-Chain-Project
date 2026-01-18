------ Monitoring 
/* Current stock per product */

SELECT 
    product_id,
    current_stock
FROM inventory;

/* Which products are low in stock? */

SELECT 
    p.product_id,
    p.product_name,
    i.current_stock,
    p.reorder_level
FROM products p
JOIN inventory i ON p.product_id = i.product_id
WHERE i.current_stock <= p.reorder_level;
-------------------------------------------------

------ Diagnostic
/* Daily demand per product */
SELECT
    product_id,
    sale_date,
    SUM(quantity_sold) AS daily_demand
FROM sales
GROUP BY product_id, sale_date;

/* Average daily demand (last 30 days) */

SELECT
    product_id,
    AVG(daily_demand) AS avg_daily_demand
FROM (
    SELECT
        product_id,
        sale_date,
        SUM(quantity_sold) AS daily_demand
    FROM sales
    WHERE sale_date >= CURRENT_DATE - INTERVAL '30 days'
    GROUP BY product_id, sale_date
) t
GROUP BY product_id;

/* Days of inventory left */

WITH avg_demand AS (
    SELECT
        product_id,
        AVG(daily_demand) AS avg_daily_demand
    FROM (
        SELECT
            product_id,
            sale_date,
            SUM(quantity_sold) AS daily_demand
        FROM sales
        GROUP BY product_id, sale_date
    ) d
    GROUP BY product_id
)
SELECT
    i.product_id,
    i.current_stock,
    a.avg_daily_demand,
    ROUND(i.current_stock / a.avg_daily_demand, 1) AS days_of_inventory
FROM inventory i
JOIN avg_demand a ON i.product_id = a.product_id;

-------------------------------------------------------
------ Predictive

/* Expected demand for next 14 days */

WITH avg_demand AS (
    SELECT
        product_id,
        AVG(daily_demand) AS avg_daily_demand
    FROM (
        SELECT
            product_id,
            sale_date,
            SUM(quantity_sold) AS daily_demand
        FROM sales
        WHERE sale_date >= CURRENT_DATE - INTERVAL '30 days'
        GROUP BY product_id, sale_date
    ) d
    GROUP BY product_id
)
SELECT
    product_id,
    avg_daily_demand,
    avg_daily_demand * 14 AS expected_14_day_demand
FROM avg_demand;


/* Stockout prediction logic */

WITH demand_forecast AS (
    SELECT
        product_id,
        AVG(daily_demand) * 14 AS expected_14_day_demand
    FROM (
        SELECT
            product_id,
            sale_date,
            SUM(quantity_sold) AS daily_demand
        FROM sales
        WHERE sale_date >= CURRENT_DATE - INTERVAL '30 days'
        GROUP BY product_id, sale_date
    ) d
    GROUP BY product_id
)
SELECT
    i.product_id,
    i.current_stock,
    f.expected_14_day_demand,
    CASE
        WHEN i.current_stock < f.expected_14_day_demand THEN 'High Stockout Risk'
        ELSE 'Low Risk'
    END AS stockout_risk
FROM inventory i
JOIN demand_forecast f ON i.product_id = f.product_id;


/*  Risk prioritization */

CASE
    WHEN current_stock / avg_daily_demand <= 7 THEN 'Critical'
    WHEN current_stock / avg_daily_demand <= 14 THEN 'High'
    WHEN current_stock / avg_daily_demand <= 30 THEN 'Medium'
    ELSE 'Low'
END AS risk_category

