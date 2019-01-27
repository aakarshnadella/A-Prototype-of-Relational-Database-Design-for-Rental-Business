CREATE TABLE [Prospect]
( 
	[ProspectNumber]     integer  NOT NULL ,
	[Name]               char(20)  NULL ,
	[Address]            char(20)  NULL ,
	[Phone]              char(12)  NULL ,
	PRIMARY KEY  CLUSTERED ([ProspectNumber] ASC)
)
go

CREATE TABLE [JobType]
( 
	[JobCode]            char(1)  NOT NULL ,
	[Description]        char(10)  NULL ,
	PRIMARY KEY  CLUSTERED ([JobCode] ASC)
)
go

CREATE TABLE [Staff]
( 
	[PersonID]           char(3)  NOT NULL ,
	[Name]               char(20)  NULL ,
	[StartDate]          date  NULL ,
	[EndDate]            date  NULL ,
	[JobCode]            char(1)  NULL ,
	PRIMARY KEY  CLUSTERED ([PersonID] ASC),
	 FOREIGN KEY ([JobCode]) REFERENCES [JobType]([JobCode])
)
go

CREATE TABLE [Manager]
( 
	[PersonID]           char(3)  NOT NULL ,
	[LastAccessedOn]     datetime  NULL ,
	PRIMARY KEY  CLUSTERED ([PersonID] ASC),
	 FOREIGN KEY ([PersonID]) REFERENCES [Staff]([PersonID])
)
go

CREATE TABLE [Complex]
( 
	[ComplexID]          char(1)  NOT NULL ,
	[Description]        char(15)  NULL ,
	[PersonID]           char(3)  NULL ,
	PRIMARY KEY  CLUSTERED ([ComplexID] ASC),
	 FOREIGN KEY ([PersonID]) REFERENCES [Manager]([PersonID])
)
go

CREATE TABLE [Apartment]
( 
	[ApartmentID]        integer  NOT NULL ,
	[Number]             char(4)  NULL ,
	[ComplexID]          char(1)  NULL ,
	[NumberRents]        integer  NULL ,
	PRIMARY KEY  CLUSTERED ([ApartmentID] ASC),
	 FOREIGN KEY ([ComplexID]) REFERENCES [Complex]([ComplexID])
)
go

CREATE TABLE [Status]
( 
	[StatusCode]         integer  NOT NULL ,
	[Description]        char(15)  NULL ,
	PRIMARY KEY  CLUSTERED ([StatusCode] ASC)
)
go

CREATE TABLE [WaitingList]
( 
	[ProspectNumber]     integer  NOT NULL ,
	[ApartmentID]        integer  NOT NULL ,
	[StatusCode]         integer  NULL ,
	PRIMARY KEY  CLUSTERED ([ProspectNumber] ASC,[ApartmentID] ASC),
	 FOREIGN KEY ([ProspectNumber]) REFERENCES [Prospect]([ProspectNumber]),
	 FOREIGN KEY ([ApartmentID]) REFERENCES [Apartment]([ApartmentID]),
	 FOREIGN KEY ([StatusCode]) REFERENCES [Status]([StatusCode])
)
go

CREATE TABLE [Type]
( 
	[Type]               char(1)  NOT NULL ,
	[Description]        char(10)  NULL ,
	PRIMARY KEY  CLUSTERED ([Type] ASC)
)
go

CREATE TABLE [MaintenanceStaff]
( 
	[PersonID]           char(3)  NOT NULL ,
	PRIMARY KEY  CLUSTERED ([PersonID] ASC),
	 FOREIGN KEY ([PersonID]) REFERENCES [Staff]([PersonID])
)
go

CREATE TABLE [Repairs]
( 
	[RepairNum]          integer  NOT NULL ,
	[ApartmentID]        integer  NULL ,
	[Description]        char(10)  NULL ,
	[DateOrdered]        date  NULL ,
	[DateCompleted]      date  NULL ,
	[Type]               char(1)  NULL ,
	[PersonID]           char(3)  NULL ,
	PRIMARY KEY  CLUSTERED ([RepairNum] ASC),
	 FOREIGN KEY ([ApartmentID]) REFERENCES [Apartment]([ApartmentID]),
	 FOREIGN KEY ([Type]) REFERENCES [Type]([Type]),
	 FOREIGN KEY ([PersonID]) REFERENCES [MaintenanceStaff]([PersonID])
)
go

CREATE TABLE [Renter]
( 
	[RenterID]           char(5)  NOT NULL ,
	[Name]               char(20)  NULL ,
	PRIMARY KEY  CLUSTERED ([RenterID] ASC)
)
go

CREATE TABLE [LeaseInformation]
( 
	[ApartmentID]        integer  NOT NULL ,
	[RenterID]           char(5)  NOT NULL ,
	[Rent]               money  NULL ,
	[StartDate]          date  NULL ,
	PRIMARY KEY  CLUSTERED ([ApartmentID] ASC,[RenterID] ASC),
	 FOREIGN KEY ([ApartmentID]) REFERENCES [Apartment]([ApartmentID]),
	 FOREIGN KEY ([RenterID]) REFERENCES [Renter]([RenterID])
)
go

CREATE TABLE [Payment]
( 
	[PaymentNumber]      integer  NOT NULL ,
	[DateDue]            date  NULL ,
	[DatePaid]           date  NULL ,
	[Amount]             money  NULL ,
	[ApartmentID]        integer  NULL ,
	[RenterID]           char(5)  NULL ,
	PRIMARY KEY  CLUSTERED ([PaymentNumber] ASC),
	 FOREIGN KEY ([ApartmentID],[RenterID]) REFERENCES [LeaseInformation]([ApartmentID],[RenterID])
)
go

CREATE TABLE [CEO]
( 
	[PersonID]           char(3)  NOT NULL ,
	[NextMeeting]        date  NULL ,
	PRIMARY KEY  CLUSTERED ([PersonID] ASC),
	 FOREIGN KEY ([PersonID]) REFERENCES [Staff]([PersonID])
)
go
