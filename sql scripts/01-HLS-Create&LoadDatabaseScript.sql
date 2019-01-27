--01-HLS-Create&LoadDatabaseScript.txt

-- script to build a portion of the HomeLendingSecurity database

-- Creation of the tables and loading data - run with as user with dbCreator

-- replace the nn below with your number
use master;
create database HLS70;
go
USE HLS70;
go

CREATE TABLE Marital_Status_Type
( 
	Marital_Status_Type_ID int  NOT NULL  IDENTITY ( 1,1 ) ,
	Marital_Status_Type_Desc varchar(50)  NULL ,
	PRIMARY KEY  CLUSTERED (Marital_Status_Type_ID ASC)
)
go

-- Question: What does the IDENTITY specification do?
-- Question: What values does such a field provide for the PK?

CREATE TABLE Borrower
( 
	Borrower_ID          bigint  NOT NULL  IDENTITY ( 100,1 ) ,
	Borrower_DOB         datetime  NOT NULL ,
	Marital_Status_Type_ID int  NULL ,
	PRIMARY KEY  CLUSTERED (Borrower_ID ASC),
	 FOREIGN KEY (Marital_Status_Type_ID) REFERENCES Marital_Status_Type(Marital_Status_Type_ID)
)
go

CREATE TABLE Borrower_Name
( 
	Borrower_Name_ID     bigint  NOT NULL  IDENTITY ( 100,1 ) ,
	Borrower_ID          bigint  NOT NULL ,
	Borrower_FName       varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	Borrower_LName       varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	Borrower_Address     varchar(50)  NULL ,
	Borrower_City        varchar(50)  NULL ,
	Borrower_State       char(2)  NULL ,
	Borrower_ZipCode     char(5)  NULL ,
	PRIMARY KEY  CLUSTERED (Borrower_Name_ID ASC),
	 FOREIGN KEY (Borrower_ID) REFERENCES Borrower(Borrower_ID)
)
go

CREATE TABLE Identification_Type
( 
	Identification_Type_ID int  NOT NULL  IDENTITY ( 1,1 ) ,
	Identification_Type_Desc varchar(50)  NULL ,
	PRIMARY KEY  CLUSTERED (Identification_Type_ID ASC)
)
go

CREATE TABLE Borrower_Identification
( 
	Borrower_Identification_ID bigint  NOT NULL  IDENTITY ( 100,1 ) ,
	Borrower_ID          bigint  NOT NULL ,
	Identification_Value varchar(250) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	Identification_Type_ID int  NULL ,
	PRIMARY KEY  CLUSTERED (Borrower_Identification_ID ASC),
	 FOREIGN KEY (Borrower_ID) REFERENCES Borrower(Borrower_ID),
	 FOREIGN KEY (Identification_Type_ID) REFERENCES Identification_Type(Identification_Type_ID)
)
go

-- Data for the tables

-- load the marital status types
INSERT INTO Marital_Status_Type VALUES('Married')
INSERT INTO Marital_Status_Type VALUES('Seperated')
INSERT INTO Marital_Status_Type VALUES('Unmarried')

-- load the itentification types
INSERT INTO Identification_Type VALUES('Social Security Number');
INSERT INTO Identification_Type VALUES('Drivers License');
INSERT INTO Identification_Type VALUES('Passport');
INSERT INTO Identification_Type VALUES('Employer Identification Number');
INSERT INTO Identification_Type VALUES('Unique Tax Payer Reference');
INSERT INTO Identification_Type VALUES('National Insurance Number');
INSERT INTO Identification_Type VALUES('General Index Reference Number');
INSERT INTO Identification_Type VALUES('Tax File Number');
INSERT INTO Identification_Type VALUES('Other');

-- Load borrower inforamtion
INSERT INTO Borrower VALUES('05/21/1964', 1);
INSERT INTO Borrower VALUES('07/10/1937', 2);
INSERT INTO Borrower VALUES('09/05/1935', 3);
INSERT INTO Borrower VALUES('07/22/1937', 1);
INSERT INTO Borrower VALUES('01/07/1948', 2);
INSERT INTO Borrower VALUES('03/28/1976', 3);
INSERT INTO Borrower VALUES('01/03/1923', 1);
INSERT INTO Borrower VALUES('06/26/1944', 2);
INSERT INTO Borrower VALUES('10/08/1988', 3);
INSERT INTO Borrower VALUES('07/07/1949', 1);
INSERT INTO Borrower VALUES('05/14/1949', 2);
INSERT INTO Borrower VALUES('04/14/1996', 3);



-- load identification for Borrower 100 -> 110
INSERT INTO Borrower_Identification VALUES(100, 'SSN: 111-22-3333', 1);
INSERT INTO Borrower_Identification VALUES(101, 'SSN: 222-23-3334', 1);
INSERT INTO Borrower_Identification VALUES(103, 'SSN: 333-24-3335', 1);
INSERT INTO Borrower_Identification VALUES(104, 'SSN: 444-25-3336', 1);
INSERT INTO Borrower_Identification VALUES(105, 'SSN: 555-26-3337', 1);
INSERT INTO Borrower_Identification VALUES(106, 'SSN: 666-27-3338', 1);
INSERT INTO Borrower_Identification VALUES(109, 'SSN: 777-29-3310', 1);
INSERT INTO Borrower_Identification VALUES(107, 'SSN: 777-28-3339', 1);
INSERT INTO Borrower_Identification VALUES(100, 'Drivers License: 333567', 2);
INSERT INTO Borrower_Identification VALUES(104, 'Drivers License: 444765', 2);
INSERT INTO Borrower_Identification VALUES(106, 'Drivers License: 555123', 2);
INSERT INTO Borrower_Identification VALUES(100, 'Passport: US 2345', 3);
INSERT INTO Borrower_Identification VALUES(102, 'Passport: GB 998877', 3);
INSERT INTO Borrower_Identification VALUES(110, 'Passport: US 5689', 3);
INSERT INTO Borrower_Identification VALUES(108, 'Passport: US 7890', 3);
INSERT INTO Borrower_Identification VALUES(108, 'EmpID: J329K', 4);
INSERT INTO Borrower_Identification VALUES(102, 'EmpID: A123B', 4);
INSERT INTO Borrower_Identification VALUES(111, 'Other: 70', 9);

-- Borrower_Name information
INSERT INTO Borrower_Name VALUES(100, 'Trisha',   'Griffin',  '225 Oak Road',           'Any Town', 'HI', '14213');
INSERT INTO Borrower_Name VALUES(101, 'Byron',    'Jacobson', '85 Old Freeway',         'Any Town', 'UT', '01680');
INSERT INTO Borrower_Name VALUES(102, 'Joe',      'Beltran',  '767 Rocky Old Drive',    'Your Town','OK', '47581');
INSERT INTO Borrower_Name VALUES(103, 'Edward',   'Mills',    '655 Clarendon Avenue',   'Any Town', 'AL', '98626');
INSERT INTO Borrower_Name VALUES(104, 'Margarita','Ponce',    '680 First Parkway',      'Your Town','OK', '11661');
INSERT INTO Borrower_Name VALUES(105, 'Karin',    'Bright',   '97 South Nobel St.',     'My Town',  'MO', '40218');
INSERT INTO Borrower_Name VALUES(106, 'Sonia',    'Cross',    '628 Fabien Avenue',      'Any Town', 'FL', '50605');
INSERT INTO Borrower_Name VALUES(107, 'Sarah',    'Lindsey',  '62 Green Cowley Street', 'My Town',  'MO', '96963');
INSERT INTO Borrower_Name VALUES(108, 'Suzanne',  'Franco',   '562 North Oak Drive',    'Any Town', 'AR', '26130');
INSERT INTO Borrower_Name VALUES(109, 'Jermaine', 'Arroyo',   '927 Green New Freeway',  'Your Town','KS', '18749');
INSERT INTO Borrower_Name VALUES(110, 'Hilary',   'Gardner',  '255 Milton Avenue',      'Any Town', 'CT', '93024');
INSERT INTO Borrower_Name VALUES(111, 'Aakarsh',   'Nadella', '402 W New York Street',  'Indianapolis', 'IN', '46202');

select * from Marital_Status_Type;
select * from Identification_Type;
select * from Borrower;
select * from Borrower_Identification;
select * from Borrower_Name;

-- Recall from the assignment, you are to add records for you to the database.
-- Question: How did you specify the value for the IDENTITY attributes?

