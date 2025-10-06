-- SELECT * FROM bronze.crm_prd_info

-- Checking Duplicates
SELECT * FROM
(
SELECT 
prd_id, COUNT(*) frequency
FROM bronze.crm_prd_info 
GROUP BY prd_id
) T
WHERE frequency > 1 OR prd_id IS NULL;

-- Checking Unwanted Spaces
SELECT prd_nm
FROM bronze.crm_prd_info
WHERE prd_nm != TRIM(prd_nm)

SELECT TOP 100 * FROM bronze.crm_prd_info

-- Check for NULL and negavtive numbers in prd_cost
SELECT 
prd_cost 
FROM bronze.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL

-- Data Standardization and Consistency check
SELECT DISTINCT(prd_line)
FROM bronze.crm_prd_info

-- Check for Invalid Date Orders
SELECT 
	prd_id,
	prd_key,
	prd_start_dt,
	prd_end_dt
FROM bronze.crm_prd_info
WHERE prd_start_dt > prd_end_dt

-- Building the Logic to change the Product End Date to appropriate one 
SELECT 
	prd_id,
	prd_key,
	prd_nm,
	prd_start_dt,
	DATEADD(DAY, -1, LEAD(prd_start_dt) OVER(PARTITION BY prd_key ORDER BY prd_start_dt)) prd_end_date,
	prd_end_dt
FROM bronze.crm_prd_info
WHERE prd_key IN ('AC-HE-HL-U509-R', 'AC-HE-HL-U509')

