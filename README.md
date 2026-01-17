# Supply-Chain-Project

## Project Overview

This project analyzes supply chain demand and inventory data to move from reactive monitoring to predictive stockout risk identification.
Using SQL as the primary analytical tool and Python for forecasting, the project identifies products that are likely to go out of stock in the next 14 days, enabling proactive replenishment decisions.

## Business Problem

### The business faces frequent stockouts due to:

Limited visibility into demand trends

Reactive inventory planning

Supplier lead-time variability

### The goal is to identify stockout risks early and support data-driven inventory and procurement decisions.

## Tools & Technologies

SQL – Data modeling, aggregation, predictive logic

Python – Time-series forecasting (ARIMA)

Pandas / Statsmodels – Data processing & modeling

Kaggle Notebooks – Python execution environment

## Methodology
### Phase 1 – Inventory Monitoring (Beginner)

Track current stock levels

Identify low-stock products

### Phase 2 – Demand & Coverage Analysis (Intermediate)

Calculate daily and average demand

Estimate inventory coverage in days

### Phase 3 – Stockout Prediction (Advanced)

Estimate 14-day demand using historical trends

Flag products at high risk of stockout

Classify products into risk categories (Critical / High / Medium / Low)

### Phase 4 – Forecasting (Python)

Forecast demand for the next 14 days using ARIMA

Compare forecasted demand with available stock

Validate SQL-based predictions

## Key Insights

Products with less than 14 days of inventory coverage are at high risk of stockout

Demand velocity is a stronger indicator than static reorder levels

Predictive analysis enables earlier and more effective replenishment decisions

## Business Recommendations

Prioritize replenishment for high-risk products

Adjust reorder levels based on demand trends

Monitor fast-moving SKUs more frequently

Integrate forecasting into regular inventory planning 




### Author

Isha Shukla
📧 ishas@theshashaedit.com

🌐 https://theshashaedit.com
