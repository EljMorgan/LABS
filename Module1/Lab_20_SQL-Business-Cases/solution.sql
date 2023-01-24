CREATE DATABASE lab_20;
use lab_20;

CREATE TABLE IF NOT EXISTS Cars (
	Car_id int,
	VIN_number varchar(255),
	Manufacturer varchar(255),
	Model varchar(255),
    Year_released varchar(255),
    Color varchar(255)
    );
 CREATE TABLE IF NOT EXISTS Customers (
	Customer_id int,
	Name varchar(255),
	Phone_number varchar(255),
	Email varchar(255),
    Address varchar(255),
    City varchar(255),
    State varchar(255),
    Country varchar(255),
    ZIP varchar(255),
    Staff_id int
    );   
    
CREATE TABLE IF NOT EXISTS Salesperson (
	Staff_id int,
	Name varchar(255),
	Store varchar(255)
	);
    
CREATE TABLE IF NOT EXISTS Invoices (
	Car_id int,
    Customer_id int,
    Salesperson_id int, 
    Invoice_id int,
	Data varchar(255),
	Invoice_number varchar(255)
    );
    
show tables;

INSERT INTO Cars (Car_ID, VIN_number, Manufacturer, Model, Year_released, Color)
VALUES ('0','3K096I98581DHSNUP', 'Volkswagen',	'Tiguan',	'2019','Blue'),
('1','ZM8G7BEUQZ97IH46V', 'Peugeot',	'Rifter',	'2019','Red'),
('2', 'RKXVNNIHLVVZOUB4M', 'Ford',	'Fusion',	'2018','White'),
('3','HKNDGS7CU31E9Z7JW', 'Toyota',	'RAV4',	'2018','Silver'),
('4','DAM41UDN3CHU2WVF6', 'Volvo',	'V60',	'2019','Gray'),
('5','DAM41UDN3CHU2WVF6', 'Volvo',	'V60 Cross Country',	'2019','Gray');

select* from cars;

INSERT INTO Customers(Customer_id,Name,	Phone_number, Email , Address,
    City, State, Country, ZIP, staff_id)
VALUES ('0', '10001', 'Pablo Picasso', '+34636176382', '-', 'Paseo de la Chopera, 14',
'Madrid', 'Madrid', 'Spain', '28045'),
('1', '20001', 'Abraham Lincoln', '+1 305 907 7086', '-', '120 SW 8th St',
'Miami', 'Floride', 'US', '33130'),
('2', '30001', 'Napoléon Bonaparte', '+33 1 79 75 40 00', '-', '40 Rue du Colisée',
'Paris', 'Ile de France', 'France', '75008');

select* from customers;

INSERT INTO Salespersons( Staff_ID, Name, Store)
VALUES (	'00001',	'Petey Cruiser',	'Madrid'),
(	'00002',	'Anna Sthesia',	'Barcelona'),
(	'00003',	'Paul Molive',	'Berlin'),
(	'00004',	'Gail Forcewind',	'Paris'),
(	'00005',	'Paige Turner',	'Mimia'),
(	'00006',	'Bob Frapples',	'Mexico City'),
(	'00007',	'Walter Melon',	'Amsterdam'),
(	'00008',	'Shonda Leer',	'Sao Paulo');

select* from Salespersons;

INSERT INTO Invoices (Car_id, customer_id, salesperson_id, invoice_id,data, invoice_number)
VALUES ('0', '852399038', '22-08-2018', '0', '1', '3'),
('1', '731166526', '31-12-2018	', '3', '0', '5'),
('2', '271135104', '22-01-2019', '2', '2', '7');







