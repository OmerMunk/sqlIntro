-- Drop table CarRent cascade;
-- Drop table ClientBill cascade;
-- Drop table Cars cascade;
-- Drop table Clients cascade;
-- Drop table Bills cascade;

Create table cars
	(CarID 		varchar (7),
	  CarType 	varchar (20),
	  DayRate 	Numeric (6,2),
	  MYear  	Date,
	  LicenceT	Integer,
	  primary key (CarID));
Create table Clients
	(CId 		varchar (9),
	  CName 	varchar (20),
	  Aaddress	varchar (20),
	  PhoneNum varchar (10),
	  BirthDate  	Date,
	  TLicence	Integer,
	  primary key (CId));
Create table CarRent
	(CarID 		varchar (7),
	  CId	 	varchar (9),
	  RDate 		Date,
	  RPeriod	Integer,
	  primary key (CarId, CID, RDate),
	  foreign key (CarID) references Cars,
	  foreign key (CID)  references  Clients
	  );
create table Bills
( 	OrderId varchar (5),
	BillDate date,
	PDate 	 date,
	TotalPayment numeric (8,2),
	primary key (OrderId));
Create table ClientBill
	(OrderId varchar (5),
	  CId	 varchar (9),
	  status 	varchar (4),
	  primary key (OrderId, CID),
	  foreign key (OrderId) references Bills,
	  foreign key (CID)  references  Clients
	  );
Create table OrderCarRent
	(OrderId varchar (5),
	  CarID	 varchar (7),
	  primary key (OrderId, CarID),
	  foreign key (OrderId) references Bills,
	  foreign key (CarID)  references  Cars
	  );
select * from Clients;
select * from Cars;
select * from CarRent;
select * from Bills;
select * from ClientBill;
select * from OrderCarRent;
insert into Clients
values('234567890', 'Yossi', 'Hanasi 59', '011-111111', '1/1/1975', 1);
insert into Clients
values('345678901', 'Ronit', 'Kalanit 7', '033-333333', '1/1/1980', 2);
/* or in a single statement*/
insert into Clients
values('234567891', 'Danny', 'Hadas 8', '011-122211', '1/1/1976', 1),                   
           ('345678902', 'Ranan', 'Kacal 22', '033-222333', '1/1/1985', 2);
insert into Clients
values('234117823', 'Danny', 'Harhozvim 20', '052-199151', '1/1/1982', 1);                   


insert into Cars
values('6544432', 'Daihtso Je', 150,  '1/1/2018', 1);
insert into Cars
values('6055570', 'Fiat Punto', 120,  '1/1/2018', 1),
 ('6987850', 'Volvo', 210,  '1/1/2018', 2),
 ('6077550', 'Subaru Legacy', 180,  '1/1/2019', 1),
           ('6977754', 'Ford Focus', 180,  '1/1/2019', 1);
set datestyle to "ISO,DMY";


insert into Bills
values('0001',   '24/09/2015',  '15/10/2015', 1500); 

insert into Bills values
('0002',   '12/10/2015',  '30/11/2015', 1800),
('0003',   '11/12/2015',  '15/01/2016', 600),
('0004',   '01/02/2015',  '01/03/2016', 2100),
('0005',   '05/05/2016',  '15/06/2016', 2100); 

insert into CarRent
values('6544432', '234567890',  '01/09/2015',  5); 

insert into CarRent
values('6055570', '234567890',  '01/10/2015',  8); 
insert into CarRent
values('6077550', '345678901',  '01/11/2015',  10); 
insert into CarRent
values('6977754', '234567891',  '01/12/2015',  12); 

insert into ClientBill
values('0001',  '234567890',  'open'); 
insert into ClientBill
values('0002',  '234567890',  'open'); 
insert into ClientBill
values('0003',  '345678901',  'open'); 
insert into ClientBill
values('0004',  '234567891',  'open'); 


insert into OrderCarRent
values('0001',   '6544432'); 
insert into OrderCarRent
values('0002',   '6055570');
insert into OrderCarRent
values('0003',   '6077550');
insert into OrderCarRent
values('0004',   '6977754');


