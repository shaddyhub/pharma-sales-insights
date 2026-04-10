-- ============================================
-- Pharma Sales Analysis Queries
-- ============================================

-- 1. Total sales by product
SELECT 
    product,
    SUM(actual_sales) AS total_sales,
    AVG(achievement_pct) AS avg_achievement_pct,
    SUM(units_sold) AS total_units
FROM pharma_sales
GROUP BY product
ORDER BY total_sales DESC;

-- 2. Regional performance vs target
SELECT 
    region,
    SUM(sales_target) AS total_target,
    SUM(actual_sales) AS total_actual,
    ROUND(SUM(actual_sales) / SUM(sales_target) * 100, 1) AS achievement_pct
FROM pharma_sales
GROUP BY region
ORDER BY achievement_pct DESC;

-- 3. Top performing sales reps
SELECT 
    sales_rep,
    COUNT(*) AS months_active,
    SUM(actual_sales) AS total_sales,
    AVG(achievement_pct) AS avg_achievement,
    SUM(new_customers) AS total_new_customers
FROM pharma_sales
GROUP BY sales_rep
ORDER BY avg_achievement DESC
LIMIT 5;

-- 4. Monthly sales trend
SELECT 
    month,
    month_num,
    SUM(actual_sales) AS monthly_sales,
    SUM(sales_target) AS monthly_target,
    ROUND(SUM(actual_sales)/SUM(sales_target)*100,1) AS achievement_pct
FROM pharma_sales
GROUP BY month, month_num
ORDER BY month_num;

-- 5. Underperforming regions (below 80% target)
SELECT 
    region,
    product,
    ROUND(AVG(achievement_pct),1) AS avg_achievement
FROM pharma_sales
GROUP BY region, product
HAVING avg_achievement < 80
ORDER BY avg_achievement ASC;
