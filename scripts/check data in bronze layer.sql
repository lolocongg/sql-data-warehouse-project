-- check for nulls or duplicate PK
SELECT cst_id,
COUNT(*) from silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id is NULL

-- check for unwanted spaces
select cst_firstname
FROM silver.crm_cust_info
where cst_firstname != TRIM(cst_firstname)

ALTER TABLE silver.crm_prd_info
ADD cat_id NVARCHAR(50);

ALTER TABLE silver.crm_prd_info
ALTER COLUMN  prd_end_dt DATE;

DROP TABLE silver.crm_prd_info;

-- check and validating values
SELECT DISTINCT 
sls_sales AS OLD_sales, 
sls_quantity, 
sls_price AS OLD_price,
CASE WHEN sls_sales IS NULL OR sls_sales <=0  
OR sls_sales != sls_quantity * ABS(sls_price)
	THEN sls_quantity * ABS(sls_price)
	ELSE sls_sales
END AS sls_sales,

CASE WHEN sls_price IS NULL OR sls_price <=0  
	THEN sls_sales / NULLIF(sls_quantity,0)
	ELSE sls_price
END AS sls_price

FROM brone.crm_sales_details
where sls_sales != sls_quantity * sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales <= 0 OR sls_quantity <= 0 OR sls_price <= 0
ORDER BY sls_sales, sls_quantity, sls_price

