-- 03-HLS-View&GrantScript.txt 

-- script to build a portion of the HomeLendingSecurity database

-- Build the borrower view

-- replace the nn below with your number
USE HLSnn;
go

-- Question: Why do this process on a view rather than a base table?

-- variation of Listing 3-5: Creating a view in the HomeLending database 
CREATE VIEW [dbo].[vwBorrower]
AS
SELECT     
    b.Borrower_ID, 
    bn.Borrower_FName, 
    bn.Borrower_LName,
    m.Marital_Status_Type_Desc,
    FORMAT(b.Borrower_DOB, 'd', 'en-US') AS DOB,
    bn.Borrower_Address,
    bn.Borrower_City,
    bn.Borrower_State,
    bn.Borrower_Zipcode
FROM         
    dbo.Borrower AS b
       INNER JOIN dbo.Marital_Status_Type AS m
             ON b.Marital_Status_Type_ID = m.Marital_Status_Type_ID 
    INNER JOIN dbo.Borrower_Name AS bn
             ON b.Borrower_ID = bn.Borrower_ID 

GO

-- Listing 3-6: Granting to the database role, Sensitive_medium, permission to select on the view vwBorrower 
GRANT SELECT 
   ON dbo.vwBorrower 
   TO Sensitive_medium;
GO

-- Question: What does the GRANT statement accomplish?

-- Listing 3-7: Denying SELECT privileges to the SQL Server login JOHNSONTE 
DENY SELECT 
        ON dbo.vwBorrower 
        TO HLS_JohnsonT;
GO

-- Question: What does the DENY statement accomplish?

-- test the sensativity levels

-- Sensativity high
EXECUTE AS USER = 'HLS_WolfB'
go
 select * from vwBorrower;
go
REVERT;
go

-- Question: What does EXECUTE AS allow to happen?

-- Question: What is the function of REVERT?

-- Sensativity high, but denied access
EXECUTE AS USER = 'HLS_JohnsonT'
go
 select * from vwBorrower;
go
REVERT;
go
-- Sensativity medium
EXECUTE AS USER = 'HLS_DoughW'
go
 select * from vwBorrower;
go
REVERT;
go
-- Sensativity low
EXECUTE AS USER = 'HLS_SmithJ'
go
 select * from vwBorrower;
go
REVERT;
go

-- Question: What did these test confirm?

-- Some additional testing on the Borrower_Identification table

GRANT SELECT 
   ON dbo.Borrower_Identification 
   TO Sensitive_medium;
GO
-- this works
EXECUTE AS USER = 'HLS_DoughW'; 
GO
SELECT * FROM dbo.Borrower_Identification;
GO
REVERT;
GO
-- this does not work - included names
EXECUTE AS USER = 'HLS_JohnsonT'; 
GO
SELECT * FROM vwBorrower;
GO
REVERT;
GO
-- this works - no names included.
EXECUTE AS USER = 'HLS_DoughW'; 
GO
SELECT Borrower_ID, Borrower_Address FROM vwBorrower;
GO
REVERT;
GO