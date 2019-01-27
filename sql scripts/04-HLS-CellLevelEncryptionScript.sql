-- 04-HLS-CellLevelEncryptionScript.txt

-- script to build a portion of the HomeLendingSecurity database

-- Build the cell-level encryption


-- Listing 5-2: Confirming the existence of the Service Master Key 
-- This produces output only for admin

-- Question: Why is output suppressed for an ordinary user?

USE master;
GO

SELECT * 
FROM sys.symmetric_keys
WHERE name = '##MS_ServiceMasterKey##';
GO

-- Begin the cell-level process

-- replace the nn below with your number
USE HLSnn;
GO

-- Listing 5-3: Creating the Database Master Key
create master key
 ENCRYPTION BY PASSWORD = 'MyStrongPW-Fred'

-- Listing 5-4: Confirming protection of the master key 
select b.name, a.crypt_type_desc
from sys.key_encryptions as a
    inner join sys.symmetric_keys as b
	  on a.key_id = b.symmetric_key_id
where b.name = '##MS_DatabaseMasterKey##';
-- two rows expected in the output

-- Listing 5-5: Creating the self signed certificate
CREATE CERTIFICATE MyHighCert
  WITH SUBJECT = 'Cert used for sensitivity class of high';

-- Listing 5-6: Creating the symmetric key
-- 128 bit symmetric key (strong)
CREATE SYMMETRIC KEY HighSymKey1
  WITH ALGORITHM = AES_128
  ENCRYPTION BY CERTIFICATE MyHighCert;

GRANT VIEW DEFINITION ON CERTIFICATE::MyHighCert
    TO Sensitive_high;
GO

GRANT CONTROL ON CERTIFICATE::MyHighCert
    TO Sensitive_high;
GO

-- Question:  What are the certificate and symmetric key used for?

-- Listing 5-7: Granting the VIEW DEFINITION permission to the Sensitive_high database role 
GRANT VIEW DEFINITION ON SYMMETRIC KEY::HighSymKey1
    TO Sensitive_high;
GO

--  Testing the security hierarchy
-- Listing 5-8: Validating the access to key hierarchy 

-- execute as a user who is a member of Sensitive_high role
EXECUTE AS USER = 'HLS_WolfB'; 
GO
SELECT * FROM sys.symmetric_keys;
GO
REVERT;
GO

-- execute as a user who is a member of Sensitive_medium role
EXECUTE AS USER = 'HLS_DoughW'; 
GO
SELECT * FROM sys.symmetric_keys;
GO
REVERT;
GO

-- execute as a user who is a member of Sensitive_low role
EXECUTE AS USER = 'HLS_JonesB'; 
GO
SELECT * FROM sys.symmetric_keys;
GO
REVERT;
GO

-- Question: What were the results of the tests above?

-- Listing 5-9: Adding a column to store varbinary data 
ALTER TABLE dbo.Borrower_Identification ADD
    Identification_Value_E varbinary(MAX) NULL
GO

select * from dbo.borrower_identification;
-- Should see the new column

-- display column information
-- replace the nn below with your number in the second line in the following query
SELECT Table_Name, Column_Name, Data_Type
FROM HLSnn.INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Borrower_Identification'

-- Question:  Why add an extra column, why not just work on the original data?

-- Listing 5-10: Encrypting the data for the Identification_Value_E column 

-- Opens the symmetric key for use
OPEN SYMMETRIC KEY HighSymKey1
    DECRYPTION BY CERTIFICATE MyHighCert;
GO

-- Performs the update of the record
UPDATE dbo.Borrower_Identification
    SET Identification_Value_E = 
        EncryptByKey(
            Key_GUID('HighSymKey1'),
            Identification_Value,
            1,
            CONVERT(nvarchar(128),Borrower_ID)
        )
FROM
    dbo.Borrower_Identification;
GO

-- Closes the symmetric key    
CLOSE SYMMETRIC KEY HighSymKey1;
GO

-- (17 or 18 row(s) affected)

-- look at the content of the table
select * from Borrower_Identification

-- Listing 5-11
-- The original Indenification_Value column was not dropped

-- Listing 5-12: Documenting the encrypted column 

EXEC sp_addextendedproperty 
   @name='Sensitivity_Class',
   @value='High',
   @level0type='SCHEMA',
   @level0name='dbo',
   @level1type='TABLE',
   @level1name='Borrower_Identification',
   @level2type='COLUMN',
   @level2name='Identification_Value_E';
GO

-- ****************  need to create a view to read back the values *******

-- Listing 5-13: Creating the vwBorrower_Identification view 

CREATE VIEW dbo.vwBorrower_Identification
AS

SELECT
    Borrower_Identification_ID,
    Borrower_ID,
    Identification_Type_ID,
    CONVERT(varchar(250),
        COALESCE(
            DecryptByKeyAutoCert (
                CERT_ID('MyHighCert'), 
                NULL,
                Identification_Value_E,
                1,
                CONVERT(nvarchar(128), Borrower_ID)
            ),
            '<SECURED VALUE>'
        )
    ) AS Identification_Value
FROM
    dbo.Borrower_Identification;
GO

-- Question: What is the purpose of this view?

-- Listing 5-14: Granting permission to access the view 
GRANT SELECT ON dbo.vwBorrower_Identification 
    TO Sensitive_high, Sensitive_medium;
GO

-- Question:  What is the purpose of this GRANT?

-- Listing 5-15: Verification of permissions to vwBorrower_Identification  

-- execute as a user who is a member of Sensitive_high role
EXECUTE AS USER = 'HLS_WolfB'; 
GO
SELECT * FROM dbo.vwBorrower_Identification;
GO
REVERT;
GO

-- execute as a user who is a member of Sensitive_medium role
EXECUTE AS USER = 'HLS_DoughW'; 
GO
SELECT * FROM dbo.vwBorrower_Identification;
GO
REVERT;
GO

-- execute as a user who is a member of Sensitive_low role
EXECUTE AS USER = 'HLS_JonesB'; 
GO
SELECT * FROM dbo.vwBorrower_Identification;
GO
REVERT;
GO

-- Question: What were the results of these tests?
