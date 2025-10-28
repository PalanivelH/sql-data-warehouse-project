-- Purpose : To create the ddl table's in Bronze Schema if its exist it drops and recreates it

IF OBJECT_ID ('BRONZE.crm_cust_info','U') IS NOT NULL
    DROP TABLE BRONZE.crm_cust_info;

CREATE TABLE BRONZE.crm_cust_info (
cst_id	int,
cst_key	varchar(10),
cst_firstname varchar(50),	
cst_lastname varchar(50),	
cst_marital_status	varchar(5),
cst_gndr varchar(5),	
cst_create_date date);

IF OBJECT_ID ('BRONZE.crm_prd_info','U') IS NOT NULL
    DROP TABLE BRONZE.crm_prd_info;

CREATE TABLE BRONZE.crm_prd_info(
prd_id int,
prd_key	varchar(50),
prd_nm varchar(50),
prd_cost int,
prd_line varchar(10),
prd_start_dt datetime,
prd_end_dt datetime
);

IF OBJECT_ID ('BRONZE.crm_sales_details','U') IS NOT NULL
   DROP TABLE BRONZE.crm_sales_details;

CREATE TABLE BRONZE.crm_sales_details (
sls_ord_num varchar(20),
sls_prd_key	varchar(20),
sls_cust_id	int,
sls_order_dt int,	
sls_ship_dt	int,
sls_due_dt int,
sls_sales int,
sls_quantity int,
sls_price int
);

IF OBJECT_ID('BRONZE.erp_cust_info','U') IS NOT NULL
   DROP TABLE BRONZE.erp_cust_info;

CREATE TABLE BRONZE.erp_cust_info
(CID varchar(30),
BDATE date,
GEN varchar(30));

IF OBJECT_ID('BRONZE.erp_location_info','U') IS NOT NULL
   DROP TABLE BRONZE.erp_location_info;

CREATE TABLE BRONZE.erp_location_info(
CID varchar(30),	
CNTRY varchar(30)
);

IF OBJECT_ID('BRONZE.erp_px_cat_info','U') IS NOT NULL
   DROP TABLE BRONZE.erp_px_cat_info;

CREATE TABLE BRONZE.erp_px_cat_info
(ID	varchar(30),
CAT varchar(30),	
SUBCAT varchar(30),	
MAINTENANCE varchar(30)
);
