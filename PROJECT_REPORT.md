# 📋 Project Report — Olist Brazilian E-Commerce Analysis

**Author:** Subhash 

**Tool:** PostgreSQL + Power BI  
**Dataset:** Olist Brazilian E-Commerce (Kaggle, 2016–2018)  
**Date:** 2026-05-26

---

## 1. Project Summary

This report documents the findings of a comprehensive data analysis performed on the Olist Brazilian E-Commerce dataset. The analysis was conducted using PostgreSQL for data querying and Power BI for visual reporting.

The dataset contains approximately 100,000 orders placed between 2016 and 2018 across Brazil, covering customers, sellers, products, payments, and delivery logistics.

---

## 2. Dataset Overview

| Table | Row Count (approx.) |
|-------|---------------------|
| customers | 99,441 |
| orders | 99,441 |
| order_items | 112,650 |
| products | 32,951 |
| sellers | 3,095 |
| payments | 103,886 |
| reviews | 100,000 |
| geolocation | 1,000,163 |
| product_category_translation | 71 |
| brazil_states | 27 |

---

## 3. Order Analysis Findings

### 3.1 Order Status Distribution

- **97.02%** of all orders were successfully delivered — indicating a healthy fulfillment rate.
- **2,963 orders** remain undelivered, spread across statuses: Shipped, Canceled, Unavailable, Invoiced, Processing, Created, and Approved.
- This undelivered segment represents an **operational risk** and should be monitored closely.

### 3.2 Monthly Order Volume Trend

- Order volume grew significantly from 2016 to 2017 and continued strong through mid-2018.
- **Peak months** tend to fall around Q1 and Q2, suggesting seasonal demand spikes (possibly tied to Brazilian holidays and events).
- The data shows a sharp drop in late 2018, likely due to dataset cutoff, not actual decline.

### 3.3 Customer Ordering Patterns by Weekday

| Day | Orders |
|-----|--------|
| Monday | 16,200 |
| Tuesday | 15,960 |
| Wednesday | 15,550 |
| Thursday | 14,760 |
| Friday | 14,120 |
| Saturday | 10,890 |
| Sunday | 11,960 |

**Business Recommendation:** Marketing campaigns and flash sales should be scheduled on **Monday and Tuesday** to capture peak engagement.

---

## 4. Customer Analysis Findings

### 4.1 Geographic Distribution

| State | Distinct Customers |
|-------|--------------------|
| São Paulo | 40,300 |
| Rio de Janeiro | 12,380 |
| Minas Gerais | 11,260 |
| Rio Grande do Sul | 5,280 |
| Paraná | 4,880 |

São Paulo alone accounts for **~42% of the entire customer base**, making it the most critical market for Olist.

### 4.2 Customer Loyalty Rate

- Only **3.12%** of customers placed more than one order.
- This extremely low repeat purchase rate suggests customers are not returning to the platform.

**Business Recommendation:** Olist should invest in loyalty programs, personalized email campaigns, and post-purchase engagement to improve retention.

---

## 5. Revenue Analysis Findings

### 5.1 Revenue by State (Top 5)

| State | Revenue |
|-------|---------|
| São Paulo | R$ 5.20M |
| Rio de Janeiro | R$ 1.82M |
| Minas Gerais | R$ 1.59M |
| Rio Grande do Sul | R$ 0.75M |
| Paraná | R$ 0.68M |

**Total Revenue:** R$ 13.59M across all states.

### 5.2 Monthly Revenue Performance

- Revenue peaked in **May (R$ 1.50M)**.
- A sharp dip occurred in **September (R$ 0.61M)** — a potential seasonal trough.
- Recovery was observed in November (R$ 0.99M).

### 5.3 Month-over-Month Growth

- The largest positive growth occurred in **March (+43.45%)** and **January (+42.75%)**.
- The steepest decline was in **September (-56.40%)**, which may correspond to lower-activity periods in Brazil.

---

## 6. Payment Analysis Findings

| Payment Type | Orders | Share |
|-------------|--------|-------|
| Credit Card | 77,000 | 75.24% |
| Boleto | 20,000 | 19.46% |
| Voucher | 4,000 | 3.80% |
| Debit Card | 2,000 | 1.50% |

**Key Finding:** Credit card is the overwhelmingly dominant payment method. Boleto (a Brazilian bank slip payment) is a strong secondary option, reflecting Brazilian market behavior.

**Business Recommendation:** Ensure a seamless credit card checkout experience. Consider offering credit card installment incentives to increase average order value.

---

## 7. Product & Category Analysis Findings

### 7.1 Top-Selling Categories (by Delivered Orders)

| Category | Delivered Orders |
|----------|-----------------|
| Bed, Bath & Table | 9,270 |
| Health & Beauty | 8,650 |
| Sports & Leisure | 7,530 |
| Computers & Accessories | 6,530 |
| Watches & Gifts | 5,500 |

### 7.2 Categories with Most Late Deliveries

| Category | Late Deliveries |
|----------|----------------|
| Bed, Bath & Table | 920 |
| Health & Beauty | 857 |
| Furniture & Decor | 688 |
| Sports & Leisure | 625 |
| Computers & Accessories | 594 |

**Observation:** The top-selling categories also experience the most late deliveries — likely due to high volume. However, the late delivery rate as a percentage of total orders should be monitored to distinguish volume effect from operational issues.

---

## 8. Delivery & Logistics Analysis Findings

### 8.1 States with Highest Average Delivery Time

| State | Avg Delivery Days |
|-------|------------------|
| Roraima | 29.34 |
| Amapá | 27.18 |
| Amazonas | 26.36 |
| Alagoas | 24.50 |
| Pará | 23.73 |

The **Northern and Northeastern states** consistently face the longest delivery times — likely due to geographic distance, poor infrastructure, and limited logistics coverage.

### 8.2 Customer Satisfaction vs. Delivery Time

| Review Score | Avg Delivery Days |
|-------------|------------------|
| 1 (Worst) | 21.25 days |
| 2 | 16.60 days |
| 3 | 14.21 days |
| 4 | 12.25 days |
| 5 (Best) | 10.62 days |

**Key Finding:** There is a clear negative correlation between delivery time and customer satisfaction. **Faster delivery = higher review score.** This is statistically significant.

**Business Recommendation:** Prioritize logistics investment in Northern states and focus on reducing delivery time for the largest product categories.

---

## 9. Seller Analysis Findings

### 9.1 Top Revenue-Generating Sellers (Top 5)

| Seller ID | Revenue |
|-----------|---------|
| 4869f7a5dfa277a7dca6462dcf3b52b2 | R$ 0.23M |
| 53243585a1d6dc2643021fd1853d8905 | R$ 0.22M |
| 4a3ca9315b744ce9f8e9374361493884 | R$ 0.20M |
| fa1c13f2614d7b5c4749cbc52fecda94 | R$ 0.19M |
| 7c67e1448b00f6e969d365cea6b010ab | R$ 0.19M |

The top 10 sellers collectively generate approximately R$ 1.89M — roughly **14% of total revenue** — highlighting a seller concentration risk.

### 9.2 Seller Churn (2017 to 2018)

- Several sellers were active in 2017 but did not place any orders in 2018.
- These churned sellers represent a **lost supply risk** and should be flagged for re-engagement outreach.

---

## 10. Advanced Analysis — RFM Customer Segmentation

RFM (Recency, Frequency, Monetary) analysis was performed to identify the most valuable customers.

- **Recency:** Days since the customer's last purchase
- **Frequency:** Number of unique orders placed
- **Monetary:** Total amount spent

**Top Customer by Monetary Value:** `0a0a92112bd4c708ca5fde585afaa872` — spent R$ 13,440.00 in a single order.

Most high-monetary customers had a **frequency of 1**, confirming the low loyalty rate observed earlier. These are high-value single-purchase customers — a prime target for retention campaigns.

---

## 11. Conclusions & Recommendations

| Area | Finding | Recommendation |
|------|---------|----------------|
| Delivery | Northern states have 25–30 day delivery times | Invest in regional logistics partners |
| Customer Retention | 3.12% loyalty rate | Launch loyalty/rewards program |
| Revenue | São Paulo = 38% of revenue | Diversify into Rio de Janeiro and Minas Gerais |
| Payments | 75% use credit card | Optimize credit card UX and offer installments |
| Sellers | Top 10 sellers = 14% of revenue | Diversify seller base, re-engage churned sellers |
| Marketing | Monday–Tuesday peak ordering | Schedule promotions on peak days |
| Satisfaction | Delivery time directly impacts review score | Speed = Satisfaction |

---

## 12. Technical Notes

- All analysis was performed in **PostgreSQL**.
- `customer_unique_id` was used (instead of `customer_id`) throughout to avoid double-counting customers with multiple orders.
- Revenue figures represent **product price only**; freight charges are excluded.
- "Late delivery" is defined as: `order_delivered_customer_date > order_estimated_delivery_date`.
- MoM growth excludes the first month (no prior month for comparison).

---

*End of Report*
