# DAX Measures

## Total Sales

```DAX
Total Sales = SUM('cleaned_superstore_sales'[total])
```

Calculates the total sales revenue.

---

## Total Profit

```DAX
Total Profit = SUM('cleaned_superstore_sales'[gross_income])
```

Calculates the total gross income.

---

## Total Orders

```DAX
Total Orders = COUNT('cleaned_superstore_sales'[invoice_id])
```

Counts the total number of customer orders.

---

## Average Order Value

```DAX
Average Order Value =
DIVIDE([Total Sales], [Total Orders])
```

Calculates the average amount spent per order.
