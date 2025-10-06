-- Data Standardization and Consistency check
SELECT 
	DISTINCT cntry 
FROM bronze.erp_loc_a101
ORDER BY cntry -- Inconsistent Country Names