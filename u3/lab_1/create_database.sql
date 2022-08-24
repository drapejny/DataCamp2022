USE master;  
GO  
CREATE DATABASE Slizh  
ON   
( NAME = Slizh_dat,  
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\slizhdat.mdf',  
    SIZE = 10MB,  
    MAXSIZE = 1500MB,  
    FILEGROWTH = 5MB )  
LOG ON  
( NAME = Slizh_log,  
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\slizhlog.ldf',  
    SIZE = 5MB,  
    MAXSIZE = 1500MB,  
    FILEGROWTH = 5MB );  
GO  