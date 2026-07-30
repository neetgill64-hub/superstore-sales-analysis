# Total Sale for Superstore
SELECT * FROM `superstore-503204.sales_analysis.cleaned_superstore_sales` LIMIT 1000;

SELECT
    SUM(total) AS total_sales
FROM `superstore-503204.sales_analysis.cleaned_superstore_sales`;
