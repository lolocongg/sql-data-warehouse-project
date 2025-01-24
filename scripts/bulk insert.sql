-- uisng bulk insert

TRUNCATE TABLE brone.crm_cust_info;
GO
-- AVOID DUPLICATE
BULK INSERT brone.crm_cust_info
FROM 'C:\Users\Cong\Downloads\src_crm\cust_info.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK 
);
GO

TRUNCATE TABLE brone.crm_prd_info;
GO
-- AVOID DUPLICATE
BULK INSERT brone.crm_cust_info
FROM 'C:\Users\Cong\Downloads\src_crm\prd_info.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK 
);
GO

TRUNCATE TABLE brone.crm_sales_details;
GO
-- AVOID DUPLICATE
BULK INSERT brone.crm_sales_details
FROM 'C:\Users\Cong\Downloads\src_crm\sales_details.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK 
);
GO

TRUNCATE TABLE brone.erp_cust_az12;
GO
-- AVOID DUPLICATE
BULK INSERT brone.erp_cust_az12
FROM 'C:\Users\Cong\Downloads\src_erp\CUST_AZ12.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK 
);
GO

TRUNCATE TABLE brone.erp_loc_a101;
GO
-- AVOID DUPLICATE
BULK INSERT brone.erp_loc_a101
FROM 'C:\Users\Cong\Downloads\src_erp\LOC_A101.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK 
);
GO

TRUNCATE TABLE brone.erp_px_cat_g1v2;
GO
-- AVOID DUPLICATE
BULK INSERT brone.erp_px_cat_g1v2
FROM 'C:\Users\Cong\Downloads\src_erp\PX_CAT_G1V2.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK 
);
GO
