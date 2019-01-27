use AAA70;

insert into Renter values('A021','Jack Black');
insert into Renter values('C222','Fred Jones');
insert into Renter values('A025','Mike Allen');
insert into Renter values('A023','Jane Black');
insert into Renter values('B444','John Dough');
insert into Renter values('B456','Bill Smith');

Select * from Renter;


insert into Prospect values(55, 'Jack Black','73 Maple Ave','555-881-3232');
insert into Prospect values(70, 'Aakarsh Nadella','359 N West St','469-900-9835');
insert into Prospect values(11, 'Kevin White','234 Main St','555-222-1234');
insert into Prospect values(31, 'Gail Green','P.O. Box 22','555-234-2525');
insert into Prospect values(45, 'Ed Brown','12 N 1st St','555-234-8888');
insert into Prospect values(46, 'Ann Black','73 Maple Ave','555-881-3233');

Select * from Prospect;


insert into Status values(0, 'Incomplete');
insert into Status values(1, 'References');
insert into Status values(2, 'Waiting');
insert into Status values(3, 'Complete');

Select * from Status;


insert into JobType values('C', 'CEO');
insert into JobType values('M', 'Manager');
insert into JobType values('R', 'Repair');

Select * from JobType;


insert into Type values('I', 'Insured');
insert into Type values('U', 'Uninsured');

Select * from Type;

insert into Staff values('P00', 'Bob Bureaucrat',NULL,NULL,'C');
insert into Staff values('P01', 'Sam Supervisor',NULL,NULL,'M');
insert into Staff values('P02', 'Fred Foreman',NULL,NULL,'M');
insert into Staff values('P03', 'Mary Manager',NULL,NULL,'M');
insert into Staff values('P04', 'Alex Johnson','2015-10-01',NULL,'R');
insert into Staff values('P06', 'Ben Jackson','2017-12-22',NULL,'R');
insert into Staff values('P05', 'Gail Steward','2015-10-01','2017-12-21','R');
insert into Staff values('P07', 'Beth Redding','2017-12-22',NULL,'R');

Select * from Staff;


insert into Manager values('P01',NULL);
insert into Manager values('P02',NULL);
insert into Manager values('P03',NULL);

Select * from Manager;

insert into CEO values('P00',NULL);

Select * from CEO;

insert into MaintenanceStaff values('P04');
insert into MaintenanceStaff values('P05');
insert into MaintenanceStaff values('P07');
insert into MaintenanceStaff values('P06');

Select * from MaintenanceStaff;


insert into Complex values('L','Lakeview','P01');
insert into Complex values('N','Northside','P02');
insert into Complex values('P','Princeton','P03');

Select * from Complex;


insert into Apartment values(1,'101G','L',2);
insert into Apartment values(2,'201','L',1);
insert into Apartment values(5,'201','N',1);
insert into Apartment values(7,'209','L',1);
insert into Apartment values(8,'333','P',1);
insert into Apartment values(9,'431P','P',2);
insert into Apartment values(12,'310','L',NULL);
insert into Apartment values(14,'201','P',NULL);

Select * from Apartment;


insert into LeaseInformation values(1,'A021',1100,'2016-12-01');
insert into LeaseInformation values(1,'C222',1200,'2017-11-15');
insert into LeaseInformation values(2,'A025',1100,'2016-12-01');
insert into LeaseInformation values(5,'A023',1200,'2017-11-01');
insert into LeaseInformation values(7,'A023',1250,'2017-11-15');
insert into LeaseInformation values(8,'B444',700,'2017-12-01');
insert into LeaseInformation values(9,'B456',900,'2017-12-01');

Select * from LeaseInformation;


insert into Payment values(211,'2017-01-01','2016-12-30',1100,1,'A021');
insert into Payment values(397,'2017-02-01','2017-01-29',1100,1,'A021');
insert into Payment values(402,'2017-12-15','2017-12-30',1200,1,'C222');
insert into Payment values(399,'2017-01-01','2017-01-01',1100,2,'A025');
insert into Payment values(400,'2017-12-01','2017-12-01',1200,5,'A023');
insert into Payment values(401,'2017-12-15','2017-12-15',1200,7,'A023');
insert into Payment values(488,'2018-01-01','2016-12-30',700,8,'B444');
insert into Payment values(511,'2018-01-01','2017-12-30',500,9,'B456');
insert into Payment values(512,'2018-01-01','2017-12-31',400,9,'B456');

Select * from Payment;


insert into WaitingList values(55,1,3);
insert into WaitingList values(70,1,2);
insert into WaitingList values(70,2,2);
insert into WaitingList values(11,5,1);
insert into WaitingList values(31,5,2);
insert into WaitingList values(45,12,1);
insert into WaitingList values(46,14,0);

Select * from WaitingList;


insert into Repairs values(23,1,'Faucet','2017-12-22','2017-12-23','U','P04');
insert into Repairs values(28,5,'Window','2017-12-28','2017-12-31','I','P06');
insert into Repairs values(31,5,'Carpet','2017-12-28','2017-12-31','I','P05');
insert into Repairs values(33,8,'Roof','2018-01-05','2018-02-23','I',NULL);
insert into Repairs values(35,2,'Lock','2018-01-10','2018-01-11','U','P04');

Select * from Repairs;



