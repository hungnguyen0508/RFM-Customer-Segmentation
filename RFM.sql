use rfmreport; 
select * from customer_registered; 
with customer_statistics as (
SELECT 
        ct.customerid, 
        DATEDIFF('2022-09-01', max(ct.Purchase_Date)) AS recency, 
        COUNT(ct.customerid) AS frequency,
        cast(COUNT(ct.customerid) as float) / DATEDIFF('2022-09-01',cr.created_date) AS F_divide,
        SUM(ct.gmv) AS monetary, 
        (1.0*SUM(ct.gmv) / (DATEDIFF('2022-09-01', cr.created_date))) AS M_divide,
        ROW_NUMBER() OVER (ORDER BY DATEDIFF('2022-09-01', MAX(ct.purchase_date))) AS rn_recency, 
        ROW_NUMBER() OVER (ORDER BY (COUNT(ct.customerid))/(DATEDIFF('2022-09-01', cr.created_date))) AS rn_frequency,
        ROW_NUMBER() OVER (ORDER BY SUM(ct.gmv) / (DATEDIFF('2022-09-01',cr.created_date))) AS rn_monetary
    FROM 
        customer_transaction ct 
    JOIN 
        customer_registered cr 
    ON 
        ct.customerId = cr.id
    GROUP BY 
        ct.customerid), 
RFM as (
SELECT 
      	customerid,
      	recency,
      	frequency,
      	monetary, 
        -- Calculate R
        CASE 
            WHEN recency < (SELECT recency FROM customer_statistics 
                                WHERE rn_recency = (SELECT ROUND(COUNT(customerid) * 0.25, 0) FROM customer_statistics)) THEN 4
            WHEN recency >= (SELECT recency FROM customer_statistics 
                                WHERE rn_recency = (SELECT ROUND(COUNT(customerid) * 0.25, 0) FROM customer_statistics))
                 AND recency < (SELECT recency FROM customer_statistics 
                                WHERE rn_recency = (SELECT ROUND(COUNT(customerid) * 0.5, 0) FROM customer_statistics)) THEN 3
            WHEN recency >= (SELECT recency FROM customer_statistics 
                                WHERE rn_recency = (SELECT ROUND(COUNT(customerid) * 0.5, 0) FROM customer_statistics))
                 AND recency < (SELECT recency FROM customer_statistics 
                                WHERE rn_recency = (SELECT ROUND(COUNT(customerid) * 0.75, 0) FROM customer_statistics)) THEN 2
            ELSE 1 
        END AS R,
        -- Calculate F
        CASE 
            WHEN F_divide < (SELECT F_divide FROM customer_statistics 
                                  WHERE rn_frequency = (SELECT ROUND(COUNT(customerid) * 0.25, 0) FROM customer_statistics)) THEN 1
            WHEN F_divide >= (SELECT F_divide FROM customer_statistics 
                                  WHERE rn_frequency = (SELECT ROUND(COUNT(customerid) * 0.25, 0) FROM customer_statistics))
                 AND F_divide < (SELECT F_divide FROM customer_statistics 
                                  WHERE rn_frequency = (SELECT ROUND(COUNT(customerid) * 0.5, 0) FROM customer_statistics)) THEN 2
            WHEN F_divide >= (SELECT F_divide FROM customer_statistics 
                                  WHERE rn_frequency = (SELECT ROUND(COUNT(customerid) * 0.5, 0) FROM customer_statistics))
                 AND F_divide < (SELECT F_divide FROM customer_statistics 
                                  WHERE rn_frequency = (SELECT ROUND(COUNT(customerid) * 0.75, 0) FROM customer_statistics)) THEN 3
            ELSE 4 
        END AS F, 
        -- Calculate M
        CASE 
            WHEN M_divide < (SELECT M_divide FROM customer_statistics 
                                 WHERE rn_monetary = (SELECT ROUND(COUNT(customerid) * 0.25, 0) FROM customer_statistics)) THEN 1
            WHEN M_divide >= (SELECT M_divide FROM customer_statistics 
                                 WHERE rn_monetary = (SELECT ROUND(COUNT(customerid) * 0.25, 0) FROM customer_statistics))
                 AND M_divide < (SELECT M_divide FROM customer_statistics 
                                 WHERE rn_monetary = (SELECT ROUND(COUNT(customerid) * 0.5, 0) FROM customer_statistics)) THEN 2
            WHEN M_divide >= (SELECT M_divide FROM customer_statistics 
                                 WHERE rn_monetary = (SELECT ROUND(COUNT(customerid) * 0.5, 0) FROM customer_statistics))
                 AND M_divide < (SELECT M_divide FROM customer_statistics 
                                 WHERE rn_monetary = (SELECT ROUND(COUNT(customerid) * 0.75, 0) FROM customer_statistics)) THEN 3
            ELSE 4 
        END AS M
    FROM customer_statistics  
	), 
customer_segmentation as (
SELECT customerid, 
       recency,
       frequency, 
       monetary,
       CONCAT(R, F, M) AS RFM, 
       CASE
           WHEN CONCAT(R, F, M) IN ('344', '343', '334', '444', '443', '434', '433') THEN 'Vip Customer'
           WHEN CONCAT(R, F, M) IN ('424', '243', '324', '244', '342', '242', '333', '332', '234', '341', '241', '441', '331', '231', '442', '431', '432', '423') THEN 'Loyal Customer'
           WHEN CONCAT(R, F, M) IN ('222', '322', '223', '323', '224', '132', '233', '312', '232', '313', '214', '314', '421', '414', '422', '413') THEN 'Potential Customer'
           WHEN CONCAT(R, F, M) IN ('143', '142', '124', '131', '141','133', '144', '134') THEN 'Churned Customer'
           ELSE 'Walk-in Customer' 
       END AS customer_segment
FROM RFM) 
