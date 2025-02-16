-- customer
CREATE VIEW gold.dim_customer AS
select 
ROW_NUMBER() OVER (Order By cst_id) AS customer_key, -- SK key
ci.cst_id as customer_id, 
ci.cst_key as customer_number, 
ci.cst_firstname as first_name,
ci.cst_lastname as last_name, 
la.cntry as country,
ci.cst_material_status as marital_status, 
CASE WHEN ci.cst_gndr != 'n/a'  THEN ci.cst_gndr -- CRM is the master for gender info
ELSE COALESCE(ca.gen, 'n/a')
END AS gender,
ca.bdate as birthdate,
ci.cst_create_date as create_date
from silver.crm_cust_info ci
left join silver.erp_cust_az12 ca 
on ci.cst_key = ca.cid
left join silver.erp_loc_a101 la 
on ci.cst_key = la.cid

-- null oftens come from joined tables
-- null will appear if SQL finds no match
select distinct ci.cst_gndr,ca.gen,
CASE WHEN ci.cst_gndr != 'n/a'  THEN ci.cst_gndr -- CRM is the master for gender info
ELSE COALESCE(ca.gen, 'n/a')
END AS new_gen
from silver.crm_cust_info ci
left join silver.erp_cust_az12 ca 
on ci.cst_key = ca.cid
left join silver.erp_loc_a101 la 
on ci.cst_key = la.cid

-- dimension product
CREATE VIEW gold.dim_products AS
select  
ROW_NUMBER() OVER(ORDER BY pn.prd_start_dt, pn.prd_key) AS product_key,
pn.prd_id AS product_id,
pn.prd_key AS product_number,
pn.prd_nm AS product_name,
pn.cat_id AS category_id,
pc.cat AS category,
pc.subcat AS subcategory,
pc.maintenance,
pn.prd_cost AS product_cost,
pn.prd_line AS product_line,
pn.prd_start_dt AS start_date
from silver.crm_prd_info pn
LEFT JOIN silver.erp_px_cat_g1v2 pc
ON pn.cat_id = pc.id
where pn.prd_end_dt IS NULL 

-- build fact table sales
CREATE VIEW gold.fact_sales AS
select 
sd.sls_ord_num AS order_number,
pr.product_key,
cu.customer_id,
sd.sls_order_dt AS order_date,
sd.sls_ship_dt AS shipping_date,
sd.sls_due_dt AS due_date,
sd.sls_sales AS sales_amount,
sd.sls_quantity AS quantity,
sd.sls_price AS price
from silver.crm_sales_details sd
LEFT JOIN gold.dim_products pr
ON sd.sls_prd_key = pr.product_number
LEFT JOIN gold.dim_customer cu
on sd.sls_cust_id = cu.customer_id

