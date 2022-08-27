USE master;  
GO  
CREATE DATABASE HumanResources  
ON   
( NAME = HumanResources_dat,  
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\humanresourcesdat.mdf',  
    SIZE = 10MB,  
    MAXSIZE = 3000MB,  
    FILEGROWTH = 10MB )  
LOG ON  
( NAME = HumanResources_log,  
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\humanresourceslog.ldf',  
    SIZE = 10MB,  
    MAXSIZE = 3000MB,  
    FILEGROWTH = 10MB );  
GO  