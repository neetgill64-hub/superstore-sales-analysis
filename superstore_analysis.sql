## Total Orders for Superstore 
    SELECT
    COUNT(invoice_id) AS total_orders
FROM `superstore-503204.sales_analysis.cleaned_superstore_sales`;

##  Total Sale for Superstore
SELECT * FROM `superstore-503204.sales_analysis.cleaned_superstore_sales` LIMIT 1000;

SELECT
    SUM(total) AS total_sales
FROM `superstore-503204.sales_analysis.cleaned_superstore_sales`;

## Gross Income for Superstor 
SELECT
    SUM(gross_income) AS total_profit
FROM `superstore-503204.sales_analysis.cleaned_superstore_sales`;

# # Categorize each sale into Low, Medium, or High Value.

SELECT
    invoice_id
    total,
    CASE
        WHEN total < 200 THEN 'Low Value'
        WHEN total BETWEEN 200 AND 500 THEN 'Medium Value'
        ELSE 'High Value'
    END AS sales_category
FROM `superstore-503204.sales_analysis.cleaned_superstore_sales`;

## Count number of order for low value ,high value ,medium value 

SELECT
   
    CASE
        WHEN total < 200 THEN 'Low Value'
        WHEN total BETWEEN 200 AND 500 THEN 'Medium Value'
        ELSE 'High Value'   
    END AS sales_category,
    COUNT(*) AS number_of_orders,
    ROUND(SUM(total),2) AS total_sales
FROM `superstore-503204.sales_analysis.cleaned_superstore_sales`
GROUP BY sales_category
ORDER BY Total_sales DESC;


## Rank Sale by product line 
SELECT
    product_line,
    invoice_id,
    total,
    RANK() OVER(
        PARTITION BY product_line
        ORDER BY total DESC
    ) AS sales_rank
FROM `superstore-503204.sales_analysis.cleaned_superstore_sales`;

## Average sale for each product 
    SELECT
product_line,
    ROUND(AVG(total),2) AS average_order_value
FROM `superstore-503204.sales_analysis.cleaned_superstore_sales`
group by product_line;

# Monthly Running Sale
    SELECT
    order_date,
    total,
    SUM(total) OVER(
        PARTITION BY EXTRACT(MONTH FROM order_date)
        ORDER BY order_date
    ) AS monthly_running_sales
FROM `superstore-503204.sales_analysis.cleaned_superstore_sales`;

## Next Sale 
    
    SELECT
    order_date,
    total,
    LEAD(total) OVER(
        ORDER BY order_date
    ) AS next_sale
FROM `superstore-503204.sales_analysis.cleaned_superstore_sales`;

## Previous Month Running Sales Comparsion 

WITH MonthlySales AS (
SELECT
    
    FORMAT_DATE('%B', order_date) AS month_name,
    SUM(total) AS total_sales,
FROM `superstore-503204.sales_analysis.cleaned_superstore_sales`
GROUP BY month_name
)

SELECT
    month_name,
    total_sales,
    LAG(total_sales) OVER (ORDER BY month_name) AS previous_month_sales,
    total_sales - LAG(total_sales) OVER (ORDER BY month_name) AS sales_difference
FROM MonthlySales
ORDER BY month_name;

# #Which product lines have sales greater than 50,000?
SELECT
    product_line,
    SUM(total) AS total_sales
FROM `superstore-503204.sales_analysis.cleaned_superstore_sales`
GROUP BY product_line
HAVING SUM(total) > 50000
ORDER BY total_sales DESC;

