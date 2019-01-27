-- 02-HLS-RolesScript.txt

-- script to build a portion of the HomeLendingSecurity (HLSnn) database

-- Build the structure for cell-level encryption

-- replace the nn below with your number
USE HLSnn;
go

-- Listing 2-1: Create the roles

CREATE ROLE Sensitive_low AUTHORIZATION db_owner;
CREATE ROLE Sensitive_medium AUTHORIZATION db_owner;
CREATE ROLE Sensitive_high AUTHORIZATION db_owner;
GO

-- Question: What is a role?
-- Question: What is the purpose of these roles within the HLS enterprise?

-- Listing 2-3 Create the users of the HLStest database

CREATE USER HLS_SmithJ FOR LOGIN HLS_SmithJ;
CREATE USER HLS_JonesB FOR LOGIN HLS_JonesB;
CREATE USER HLS_JohnsonT FOR LOGIN HLS_JohnsonT;
CREATE USER HLS_DoughW FOR LOGIN HLS_DoughW;
CREATE USER HLS_ReganC FOR LOGIN HLS_ReganC;
CREATE USER HLS_WolfB FOR LOGIN HLS_WolfB;
GO

-- Listing 2-4: Implementing the inheritance hierarchy in our sensitivity classes  

-- Sensitive_medium role is a member of Sensitive_low
EXEC sp_addrolemember 'Sensitive_low', 'Sensitive_medium';

-- Sensitive_high role is a member of Sensitive_medium
EXEC sp_addrolemember 'Sensitive_medium', 'Sensitive_high';
GO

-- Question:  How do these two "adds" actually implement the hierarchy?

-- Listing 2-5: Assign members to the database roles 

-- These users have been determined to have access to low sensitive data
EXEC sp_addrolemember 'Sensitive_low', 'HLS_SmithJ';
EXEC sp_addrolemember 'Sensitive_low', 'HLS_JonesB';
GO

-- These users have been determined to have access to meduim sensitive data
EXEC sp_addrolemember 'Sensitive_medium', 'HLS_JohnsonT';
EXEC sp_addrolemember 'Sensitive_medium', 'HLS_DoughW';
GO

-- These users have been determined to have access to highly sensitive data
EXEC sp_addrolemember 'Sensitive_high', 'HLS_ReganC';
EXEC sp_addrolemember 'Sensitive_high', 'HLS_WolfB';
GO

-- Listing 2-7 displays schema information (works for student)
select TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS

-- Set extended properties

-- Listing 2-8 (only set two fields in each)

-- raise the class for Name to medium
exec sp_addextendedproperty @name='Sensitivity_Class',@value='Medium',
                            @level0type='SCHEMA',@level0name='dbo',
			    @level1type='TABLE', @level1name='Borrower_Name',
			    @level2type='COLUMN', @level2name='Borrower_FName';
exec sp_addextendedproperty @name='Sensitivity_Class',@value='Medium',
                            @level0type='SCHEMA',@level0name='dbo',
			    @level1type='TABLE', @level1name='Borrower_Name',
			    @level2type='COLUMN', @level2name='Borrower_LName';
go

-- raise the class for Identification information to high
exec sp_addextendedproperty @name='Sensitivity_Class',@value='High',
                            @level0type='SCHEMA',@level0name='dbo',
			    @level1type='TABLE', @level1name='Borrower_Identification',
			    @level2type='COLUMN', @level2name='Identification_Value';
exec sp_addextendedproperty @name='Sensitivity_Class',@value='High',
                            @level0type='SCHEMA',@level0name='dbo',
			    @level1type='TABLE', @level1name='Borrower_Identification',
			    @level2type='COLUMN', @level2name='Identification_Type_ID';
go

-- Listing 2-7: Retrieving column information from the catalog view (again)
SELECT 
   TABLE_SCHEMA,
   TABLE_NAME,
   COLUMN_NAME,
   DATA_TYPE
FROM 
   INFORMATION_SCHEMA.COLUMNS;
GO

-- Listing 2-11: Querying extended properties using the fn_listextendedpropery system metadata function 
SELECT  
    objname as Column_Name,
    name as Extended_Property,
    value as Value
FROM 
    fn_listextendedproperty ('Sensitivity_Class', 
                             'schema', 'dbo',   
                             'table', 'Borrower_Identification',  
                             'column', default);
GO
