/*
-----------------------------------------------------------------
Create Database and Schemas
------------------------------------------------------------------
Purpose:
       This scripts helps to create database called "Datawarehouse" if it does exist then
	   it will drop the entire database and recreate the database again. 
	   Additionally, we are creating three schema's 'Bronze','Silver','Gold' for data flow.

Warning: 
       In this script, we are dropping the database if its present already, 
	   all the data in this database will be deleted permanently,
	   Hence make sure to have back up's before dropping the database.
*/
use master;

------ dropping and recreating the database if its already available--------

IF EXISTS (SELECT * FROM sys.databases where name ='DATAWAREHOUSE')
BEGIN
    ALTER DATABASE DATAWAREHOUSE SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DATAWAREHOUSE;
END;

--create the 'Datawarehouse' database--
CREATE DATABASE DATAWAREHOUSE;
GO

USE DATAWAREHOUSE
GO

--create the bronze layer schema
CREATE SCHEMA BRONZE;
GO

--create the silver layer schema
CREATE SCHEMA SILVER;
GO

--create the gold layer schema
CREATE SCHEMA GOLD;
GO
