-- Checking Outof Range Birthdays
SELECT * FROM bronze.erp_cust_az12
WHERE bdate > GETDATE()

-- Data Standardization & Consistency check and building the derived column
SELECT DISTINCT 
gen,
CASE 
	WHEN UPPER(TRIM(gen)) IN ('F', 'Female') THEN 'Female'
	WHEN UPPER(TRIM(gen)) IN ('M', 'Male') THEN 'Male'
	ELSE 'n/a'
END gen
FROM bronze.erp_cust_az12

