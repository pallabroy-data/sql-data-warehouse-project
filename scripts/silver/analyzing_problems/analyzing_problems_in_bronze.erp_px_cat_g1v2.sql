SELECT 
	id,
	cat,
	subcat,
	maintenance
FROM bronze.erp_px_cat_g1v2

-- Check for Unwanted Spaces
SELECT *
FROM bronze.erp_px_cat_g1v2
WHERE TRIM(cat) != cat
OR TRIM(subcat) != subcat
OR TRIM(maintenance) != maintenance

-- Data Standardization & Consistency check

SELECT 
DISTINCT cat 
FROM bronze.erp_px_cat_g1v2

SELECT 
DISTINCT subcat
FROM bronze.erp_px_cat_g1v2

SELECT 
DISTINCT maintenance 
FROM bronze.erp_px_cat_g1v2

-- No problem. Read to be inserted