# RFM Customer Analysis for Marketing Campaign

## Overview

This report presents an analysis of the company's current customer base using the **RFM (Recency, Frequency, Monetary)** model to help the marketing team optimize advertising costs while nurturing customer relationships. The analysis aims to segment customers into smaller, distinct groups, allowing for the creation of tailored strategies that will contribute to achieving the year-end sales goals.

The RFM model will be applied to classify customers based on their **Recency**, **Frequency**, and **Monetary** values, which are key indicators of customer engagement and spending behavior. By utilizing this analysis, the marketing team will gain a deeper understanding of customer segments, enabling targeted, data-driven campaigns.

## Table of Contents

1. [Objective](#objective)
2. [Methodology](#methodology)
   - Data Cleaning & Transformation
   - RFM Model Application
   - Visualization
3. [Theoretical Basis](#theoretical-basis)
   - Customer360
   - RFM Model
   - BCG Matrix
   - Interquartile Range
4. [Results & Insights](#results--insights)
5. [Conclusion & Recommendations](#conclusion--recommendations)

---

## Objective

The marketing team has launched a sales-boosting campaign for the end of the year, and the goal is to segment the current customer base into distinct groups to develop targeted policies and strategies. This segmentation will help ensure that advertising resources are effectively allocated, relationships with customers are nurtured, and the company's sales objectives are met.

This report aims to provide the marketing team with actionable insights by segmenting customers based on their behavior using the RFM model. By the end of the analysis, the team will have a comprehensive view of the customer base, which will inform decision-making for marketing initiatives.

---

## Methodology

### Data Cleaning & Transformation (Using MySQL)

The first step in the analysis involved cleaning and transforming raw customer data from the company's database using **MySQL**. The steps included:

- Removing duplicates
- Handling missing data
- Standardizing date formats for customer transactions
- Creating derived fields (e.g., calculating the number of days since the last purchase)

This process ensured that the data was accurate, consistent, and ready for analysis.

### RFM Model Application

The **RFM model** is used to analyze customers based on three key metrics:

1. **Recency (R)**: How recently a customer made a purchase.
2. **Frequency (F)**: How often a customer makes a purchase.
3. **Monetary (M)**: How much money a customer spends.

Each of these metrics was calculated and then segmented into quintiles (or quartiles, depending on data distribution) using SQL queries. Customers were then scored on a scale of 1 to 5 for each of these dimensions.

### Visualization (Using Power BI)

Once the data was transformed and segmented, the results were visualized using **Power BI**. Interactive dashboards were created to provide clear insights into:

- Customer distribution across different RFM segments
- Key metrics like average recency, frequency, and monetary values
- Visuals to track customer behavior trends over time

These visuals helped the marketing team quickly identify high-value customers, dormant customers, and potential prospects.

---

## Theoretical Basis

### Customer360

**Customer360** is a comprehensive approach to understanding customers by integrating data from various touchpoints, channels, and interactions. It ensures that every customer interaction is captured in a centralized view, providing a complete picture of each customer’s journey. This model guided the approach to capturing and analyzing the company's customer data.

### RFM Model

The **RFM model** is a well-established marketing framework for segmenting customers based on three key behaviors:

- **Recency**: Identifies how recently a customer interacted with the company.
- **Frequency**: Measures how often a customer makes a purchase or engages with the company.
- **Monetary**: Tracks the total spending of a customer over a certain period.

This model enables the identification of high-value customers, as well as the detection of at-risk or dormant customers that may need re-engagement strategies.

### BCG Matrix

The **BCG Matrix** (Boston Consulting Group Matrix) was used to analyze customers based on their potential growth and profitability. This framework helps classify customers into four categories: **Stars, Cash Cows, Question Marks, and Dogs**, based on their RFM scores.

### Interquartile Range (IQR)

The **Interquartile Range (IQR)** was used to detect and handle outliers in the RFM data. By identifying and understanding the spread of customer behavior, outliers were managed appropriately to avoid distortion in segmentation results.

---

## Results & Insights

Based on the analysis, the customer base was segmented into distinct groups using the RFM scores: 

- **VIP Customers**
  
- **Loyal Customers**

- **Potential Customers**

- **Churned Customers**

- **Walk-in Customers**

Insights includes:
- Overview of the number of customers in each group.
- Overview of the revenue situation in each group.
- Overview of the purchase frequency in each group.
## Additional Resources

- [RFM Analysis Methodology](https://en.wikipedia.org/wiki/RFM_analysis)
- [Power BI Resources](https://powerbi.microsoft.com)
- [BCG Matrix Overview](https://www.bcg.com/publications/2021/bcg-growth-share-matrix)
