USE [DATAWAREHOUSE]
GO
/****** Object:  StoredProcedure [BRONZE].[load_bronze]    Script Date: 27-10-2025 21:04:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   PROCEDURE [BRONZE].[load_bronze] AS

/*
==========================================================
Stored Procedure : Load Bronze Layer  (Source -> Bronze)
==========================================================
Purpose:
this proc loads data from source paths (external csv files) into each dedicated tables respectively after deleting the data in table if any.
*/

BEGIN
    DECLARE @START_TIME DATETIME, @END_TIME DATETIME;
	DECLARE @BATCH_START_TIME DATETIME, @BATCH_END_TIME DATETIME;

	BEGIN TRY
		PRINT '==================================================';
		PRINT 'Loading Bronze Layer';
		PRINT '==================================================';

		PRINT '--------------------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '--------------------------------------------------';

		SET @START_TIME = GETDATE();
		SET @BATCH_START_TIME = GETDATE();

		PRINT '>> Truncating Table : BRONZE.crm_cust_info';
		TRUNCATE TABLE BRONZE.crm_cust_info;

		PRINT '>> Inserting Table : BRONZE.crm_cust_info';
		BULK INSERT BRONZE.crm_cust_info
		FROM 'C:\Users\HP\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			 FIRSTROW = 2,
			 FIELDTERMINATOR = ',',
			 TABLOCK
		);
		SET @END_TIME = GETDATE();
		PRINT 'Loading Duration : '+CAST(DATEDIFF(SECOND,@START_TIME, @END_TIME)AS NVARCHAR);
		PRINT '---------------------';

		SET @START_TIME = GETDATE();
		PRINT '>> Truncating Table : BRONZE.crm_prd_info';
		TRUNCATE TABLE BRONZE.crm_prd_info;

		PRINT '>> Inserting Table : BRONZE.crm_prd_info';
		BULK INSERT BRONZE.crm_prd_info
		FROM 'C:\Users\HP\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			 FIRSTROW = 2,
			 FIELDTERMINATOR = ',',
			 TABLOCK
		);
		SET @END_TIME = GETDATE();

		PRINT 'Loading Duration :'+ CAST(DATEDIFF(SECOND,@START_TIME,@END_TIME) AS NVARCHAR);
		PRINT '---------------------';

		SET @START_TIME = GETDATE();
		PRINT '>> Truncating Table : BRONZE.crm_sales_details';
		TRUNCATE TABLE BRONZE.crm_sales_details;

		PRINT '>> Inserting Table : BRONZE.crm_sales_details';
		BULK INSERT BRONZE.crm_sales_details 
		FROM 'C:\Users\HP\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			 TABLOCK,
			 FIELDTERMINATOR=',',
			 FIRSTROW=2
		);
		SET @END_TIME = GETDATE();
		PRINT 'Loading Duration : '+CAST(DATEDIFF(SECOND, @START_TIME, @END_TIME) AS NVARCHAR);

		SET @START_TIME = GETDATE();
		PRINT '--------------------------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '--------------------------------------------------';

		PRINT '>> Truncating Table : BRONZE.erp_cust_info';
		TRUNCATE TABLE BRONZE.erp_cust_info;

		PRINT '>> Inserting Table : BRONZE.erp_cust_info';
		BULK INSERT BRONZE.erp_cust_info 
		FROM 'C:\Users\HP\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			 FIELDTERMINATOR=',',
			 FIRSTROW=2,
			 TABLOCK
		);
		SET @END_TIME = GETDATE();
		PRINT 'Loading Duration : '+ CAST(DATEDIFF(SECOND,@START_TIME,@END_TIME) AS NVARCHAR);
		PRINT '---------------------';

		SET @START_TIME = GETDATE();

		PRINT '>> Truncating Table : BRONZE.erp_location_info';
		TRUNCATE TABLE BRONZE.erp_location_info;

		PRINT '>> Inserting Table : BRONZE.erp_location_info';
		BULK INSERT BRONZE.erp_location_info
		FROM 'C:\Users\HP\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
			  FIELDTERMINATOR=',',
			  FIRSTROW=2,
			  TABLOCK
		);
		SET @END_TIME = GETDATE();
		PRINT 'Loading Duration : ' + CAST (DATEDIFF(SECOND,@START_TIME, @END_TIME) AS NVARCHAR);
		PRINT '---------------------';

		SET @START_TIME = GETDATE();
		PRINT '>> Truncating Table : BRONZE.erp_px_cat_info';
		TRUNCATE TABLE BRONZE.erp_px_cat_info;

		PRINT '>> Inserting Table : BRONZE.erp_px_cat_info';
		BULK INSERT BRONZE.erp_px_cat_info 
		FROM 'C:\Users\HP\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			 FIELDTERMINATOR = ',',
			 TABLOCK,
			 FIRSTROW=2
		);
		SET @END_TIME = GETDATE();
		PRINT 'Loading Duration : ' + CAST(DATEDIFF(SECOND, @START_TIME, @END_TIME) AS NVARCHAR);
		PRINT '---------------------';
		SET @BATCH_END_TIME = GETDATE();
		PRINT 'Complete Batch Duration : ' + CAST(DATEDIFF(SECOND, @BATCH_START_TIME, @BATCH_END_TIME) AS NVARCHAR);
	END TRY

	BEGIN CATCH
		PRINT '=================================================================';
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER..';
		PRINT 'Error Message : ' + Error_message();
		PRINT 'Error Id : '+ CAST(Error_number() as NVARCHAR);
		PRINT 'Error Status : '+ CAST(Error_State() as NVARCHAR);
		PRINT '=================================================================';
	END CATCH

END;
