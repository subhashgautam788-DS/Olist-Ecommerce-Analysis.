# 🛒 Olist Brazilian E-Commerce — End-to-End Data Analysis Project

![Project Status](https://img.shields.io/badge/Status-Completed-brightgreen)
![Tool](https://img.shields.io/badge/SQL-PostgreSQL-blue)
![Tool](https://img.shields.io/badge/Visualization-Power%20BI-yellow)
![Dataset](https://img.shields.io/badge/Dataset-Kaggle-orange)

---

## 📌 Project Overview

This is an end-to-end data analysis project built on the **Olist Brazilian E-Commerce** public dataset from Kaggle. The goal was to simulate a real-world business analyst workflow — from raw data ingestion and SQL-based exploration to visual storytelling in Power BI.

The project answers 21 business questions across areas such as order fulfillment, customer behavior, revenue trends, seller performance, and logistics efficiency.

---

## 🎯 Business Objectives

| # | Objective |
|---|-----------|
| 1 | Understand order fulfillment health and undelivered order risk |
| 2 | Identify peak order periods for inventory and staffing planning |
| 3 | Analyze customer geographic distribution and state-level revenue |
| 4 | Measure customer loyalty and repeat purchase behavior |
| 5 | Evaluate payment preferences to optimize the checkout experience |
| 6 | Identify top-selling product categories and high-rated products |
| 7 | Detect late delivery patterns by category and state |
| 8 | Rank top revenue-generating sellers |
| 9 | Analyze the relationship between delivery speed and review scores |
| 10 | Perform RFM segmentation, MoM revenue growth, and seller churn analysis |

---

## 🗂️ Dataset

- **Source:** [Kaggle — Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
- **Period Covered:** 2016 – 2018
- **Size:** ~100K orders across multiple relational tables

### Tables Used

| Table | Description |
|-------|-------------|
| `customers` | Customer IDs, city, state, zip code |
| `orders` | Order lifecycle — status, timestamps |
| `order_items` | Product-level order details, price, freight |
| `products` | Product attributes and category |
| `sellers` | Seller location and ID |
| `payments` | Payment type, value, installments |
| `reviews` | Customer review scores and comments |
| `geolocation` | Lat/Lng by zip code |
| `product_category_translation` | Portuguese to English category names |
| `brazil_states` | Reference table: state code to full name |

---

## 🛠️ Tools & Technologies

| Tool | Purpose |
|------|---------|
| **PostgreSQL** | Data ingestion, cleaning, and all SQL analysis |
| **Power BI Desktop** | Interactive dashboards and visual storytelling |
| **Kaggle** | Dataset source |
| **GitHub** | Version control and project sharing |

---

## 📁 Repository Structure

```
olist-ecommerce-analysis/
│
├── olist.sql               # All SQL queries (table setup + 21 business questions)
├── README.md               # Project documentation (this file)
├── PROJECT_REPORT.md       # Detailed findings and business insights
│
└── dashboards/
    ├── EXECUTIVE OVERVIEW.png
    ├── SALES & REVENUE ANALYSIS.png
    ├── Operations & Seller Performance.png
    └── Advanced Customer Analytics.png
```

---

## 📊 SQL Analysis — Sections Covered

| Section | Topic | Questions |
|---------|-------|-----------|
| 1 | Table Setup | CREATE TABLE + INSERT (10 tables) |
| 2 | Data Validation | Row count checks, table preview |
| 3 | Order Analysis | Q1 to Q5 |
| 4 | Customer Analysis | Q6 to Q7 |
| 5 | Revenue & Delivery Analysis | Q8 to Q9 |
| 6 | Payment Analysis | Q10 |
| 7 | Product & Category Analysis | Q11, Q14, Q15 |
| 9 | Seller Analysis | Top revenue sellers |
| 10 | Behavioral Analysis | Q16 to Q18 |
| 11 | Advanced Analysis | Q19 to Q21 |

### SQL Concepts Applied

- `GROUP BY`, `ORDER BY`, `HAVING`, `WHERE` filtering
- Multi-table `JOIN` (INNER, LEFT)
- `COUNT(DISTINCT ...)` for deduplication
- `EXTRACT()` and `DATE_TRUNC()` for time-based analysis
- Window functions: `LAG()`, `SUM() OVER()`
- Common Table Expressions (CTEs) using `WITH` clause
- `FILTER (WHERE ...)` for conditional aggregation

---

## 📈 Power BI Dashboards — Key KPIs

| KPI | Value |
|-----|-------|
| Total Orders | 99,440 |
| Delivered Orders | 96,480 (97.02%) |
| Undelivered Orders | 2,963 |
| Total Revenue | R$ 13.59M |
| Total Customers | 96,100 |
| Customer Loyalty Rate | 3.12% |

### Dashboard Pages

1. **Overview Dashboard** — KPI cards, monthly order trend, order status breakdown, payment preferences, geographic distribution, top revenue states
2. **Revenue & Satisfaction Dashboard** — Monthly revenue bar chart, MoM growth line, customer satisfaction vs delivery time, top product categories
3. **Logistics & Seller Dashboard** — States with highest delivery times, late delivery by product category, top revenue-generating sellers
4. **Advanced Analytics Dashboard** — RFM top customers table, MoM revenue growth analysis
## 📸 Dashboard Preview

### Executive Overview
![Executive Overview](dashboards/EXECUTIVE%20OVERVIEW.png)

### Sales & Revenue Analysis
![Sales & Revenue](dashboards/SALES%20%26%20REVENUE%20ANALYSIS.png)

### Operations & Seller Performance
![Operations](dashboards/Operations%20%26%20Seller%20Performance.png)

### Advanced Customer Analytics
![Advanced Analytics](dashboards/Advanced%20Customer%20Analytics.png)
---

## 💡 Key Business Insights

1. **São Paulo dominates** — accounts for R$5.20M (38%) of total revenue and 40K+ customers
2. **Credit card is king** — 75.24% of all orders paid via credit card
3. **Delivery speed drives reviews** — 5-star reviews average 10.62 delivery days vs 21.25 days for 1-star reviews
4. **Northern states struggle** — Roraima (29.3 days) and Amapá (27.2 days) have the worst average delivery times
5. **Low loyalty rate (3.12%)** — signals a major opportunity for retention campaigns
6. **Bed, Bath & Table** is the top-selling category with 9,270+ delivered orders

---

## 🚀 How to Run the SQL Analysis

1. Install [PostgreSQL](https://www.postgresql.org/download/)
2. Download the dataset from [Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) and import CSVs into the tables
3. Open `olist.sql` in pgAdmin or any PostgreSQL client
4. Run sections in order: **Section 1 first** (table creation), then Section 2 onward
5. Each query is self-contained with a clear business objective comment

---

## 👤 Author

**Subhash**  
📧 *subhashgautam788@gmail.com*  
🔗 *https://www.linkedin.com/in/subhash-g-a6126626b/*

---

## 📄 License

This project is for educational and portfolio purposes. The dataset is publicly available under the [CC BY-NC-SA 4.0 License](https://creativecommons.org/licenses/by-nc-sa/4.0/) via Kaggle.
