USE HumanResources;
GO
CREATE TABLE [dbo].[EmployeesExternal]
(
	EmployeeID INT NOT NULL PRIMARY KEY,
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	JobTitle NVARCHAR(50) NOT NULL,
	EmailAddress NVARCHAR(50),
 	City NVARCHAR(50) NOT NULL,
	StateProvinceName NVARCHAR(50) NOT NULL,
	CountryRegionName NVARCHAR(50) NOT NULL
);
GO

CREATE TABLE [dbo].[EmployeesAW]
(
	BusinessEntityID INT NOT NULL PRIMARY KEY,
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	JobTitle NVARCHAR(50)
);
GO

CREATE TABLE [dbo].[EmailAddressesAW]
(
	EmailAddressId INT NOT NULL PRIMARY KEY,
	BusinessEntityID INT NOT NULL,
	EmailAddress NVARCHAR(50) NOT NULL
);
GO
