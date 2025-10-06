
-- CHECKING FOR DUPLICATE RECORDS
SELECT * FROM
(
SELECT 
cst_id, COUNT(*) frequency
FROM bronze.crm_cust_info 
GROUP BY cst_id
) T
WHERE frequency > 1 OR cst_id IS NULL;


SELECT cst_id, COUNT(*)
FROM bronze.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1


-- CHECKING FOR LEADING AND TRAILING SPACES
SELECT cst_firstname
FROM bronze.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname)


-- Data Standardization and Consistency check
SELECT DISTINCT(cst_gndr)
FROM bronze.crm_cust_info

-- Data Standardization and Consistency check
SELECT DISTINCT(cst_marital_status)
FROM bronze.crm_cust_info

SELECT * FROM silver.crm_cust_info