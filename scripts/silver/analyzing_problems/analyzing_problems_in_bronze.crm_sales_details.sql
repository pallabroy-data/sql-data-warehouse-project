-- Analyze the available data
SELECT
	sls_ord_num,
	sls_prd_key,
	sls_cust_id,
	sls_order_dt,
	sls_ship_dt,
	sls_due_dt,
	sls_sales,
	sls_quantity,
	sls_price
FROM
bronze.crm_sales_details


-- Checking Unwanted Spaces
SELECT sls_ord_num
FROM bronze.crm_sales_details
WHERE sls_ord_num != TRIM(sls_ord_num)

-- Checking Unwanted Spaces
SELECT sls_prd_key
FROM bronze.crm_sales_details
WHERE sls_prd_key != TRIM(sls_prd_key)


-- Check for Invalid sls_order_dt Dates
SELECT 
sls_order_dt,
NULLIF(sls_order_dt, 0) sls_order_dt
FROM
bronze.crm_sales_details
WHERE sls_order_dt <= 0
OR LEN(sls_order_dt) != 8
OR sls_order_dt > 20500101
OR sls_order_dt < 19000101

-- Check for Invalid sls_ship_dt Dates 
SELECT 
	sls_ship_dt,
	NULLIF(sls_ship_dt, 0) sls_ship_dt
FROM
bronze.crm_sales_details
WHERE sls_ship_dt <= 0
OR LEN(sls_ship_dt) != 8
OR sls_ship_dt > 20500101
OR sls_ship_dt < 19000101

-- Check for Invalid sls_due_dt Dates 
SELECT 
	sls_due_dt,
	NULLIF(sls_due_dt, 0) sls_ship_dt
FROM
bronze.crm_sales_details
WHERE sls_due_dt <= 0
OR LEN(sls_due_dt) != 8
OR sls_due_dt > 20500101
OR sls_due_dt < 19000101

-- Check Invalid Orders based on OrderDate and Shipping Date
SELECT 
*
FROM bronze.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt

/* Check Data Consistency between sales, quantity and price.
Business Logic: sales = quantity * price,
sales, quantity, price can't be negative, zero or NULL
*/

SELECT 
	CASE
		WHEN sls_price IS NULL OR sls_price <= 0 
		THEN sls_sales / NULLIF(sls_quantity, 0)
		ELSE sls_price
	END sls_price,
	sls_quantity,
	CASE
		WHEN sls_sales IS NULL OR sls_sales <= 0 OR sls_sales != sls_price * sls_quantity
		THEN sls_quantity * ABS(sls_price)
		ELSE sls_sales
	END sls_sales,
	sls_price incorrect_price,
	sls_sales incorrect_sales
FROM 
bronze.crm_sales_details
WHERE sls_sales != sls_price * sls_quantity
OR sls_price IS NULL OR sls_quantity IS NULL OR sls_sales IS NULL
OR sls_price <=0 OR sls_quantity <=0 OR sls_sales <=0