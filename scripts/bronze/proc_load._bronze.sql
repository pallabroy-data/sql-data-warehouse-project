/*
===============================================================================
Stored Procedure: Initialize Bronze Schema (Source → Bronze Load)
===============================================================================
Script Purpose:
    This stored procedure refreshes data in the 'bronze' schema using external CSV files.
    It executes the following steps:
    - Clears existing bronze tables to ensure clean reloads.
    - Utilizes the BULK INSERT command to ingest CSV data into bronze tables.

Parameters:
    None.
    This stored procedure does not require input parameters or produce return values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/
CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '====================================';
		PRINT '--- Starting Bronze schema load process ---';
		PRINT '====================================';

		PRINT '====================================';
		PRINT '--- Initiating CRM dataset ingestion ---';
		PRINT '====================================';

		SET @start_time = GETDATE();
		PRINT 'Clearing table before load: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info

		PRINT 'Inserting new data into: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info 
		FROM 'C:\Users\Pallab Roy\Desktop\Data_Warehousing\Data_Warehouse_Project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Time taken for this load segment: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-----------------------';

		SET @start_time = GETDATE();
		PRINT 'Clearing table before load: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info

		PRINT 'Inserting new data into: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info 
		FROM 'C:\Users\Pallab Roy\Desktop\Data_Warehousing\Data_Warehouse_Project\datasets\source_crm\prd_info.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Time taken for this load segment: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-----------------------';


		SET @start_time = GETDATE();
		PRINT 'Clearing table before load: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_sales_details
	
		PRINT 'Inserting new data into: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\Pallab Roy\Desktop\Data_Warehousing\Data_Warehouse_Project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Time taken for this load segment: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-----------------------';

		PRINT '====================================';
		PRINT 'Loading ERP tables';
		PRINT '====================================';

		SET @start_time = GETDATE();
		PRINT 'Clearing table before load: bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12

		PRINT 'Inserting new data into: bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\Pallab Roy\Desktop\Data_Warehousing\Data_Warehouse_Project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Time taken for this load segment: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-----------------------';

		SET @start_time = GETDATE();
		PRINT 'Clearing table before load: bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101

		PRINT 'Inserting new data into: bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\Pallab Roy\Desktop\Data_Warehousing\Data_Warehouse_Project\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Time taken for this load segment: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-----------------------';

		SET @start_time = GETDATE();
		PRINT 'Clearing table before load: bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2

		PRINT 'Inserting new data into: bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\Pallab Roy\Desktop\Data_Warehousing\Data_Warehouse_Project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Time taken for this load segment: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-----------------------';
		SET @batch_end_time = GETDATE();

		PRINT '=====================================';
		PRINT 'Loading Bronze Layer is Completed' 
		PRINT 'Total Load Duration: ' + CAST(DATEDIFF(SECOND,@batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds'
		PRINT '=====================================';
	END TRY
	BEGIN CATCH
		PRINT '=====================================';
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'ERROR CODE' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'ERROR CODE' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '=====================================';
	END CATCH
END

-- EXEC bronze.load_bronze
