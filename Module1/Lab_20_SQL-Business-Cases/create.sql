CREATE DATABASE lab_20_v2;
use lab_20_v2;
SET [GLOBAL|SESSION] sql_mode='NO_AUTO_VALUE_ON_ZERO';

CREATE TABLE IF NOT EXISTS Cars (
	car_id int auto_increment,
	VIN_number varchar(255),
	Manufacturer varchar(255),
	Model varchar(255),
    Year_released int,
    Color varchar(255),
    PRIMARY KEY (car_id)
    );
    
 CREATE TABLE IF NOT EXISTS Customers (
	id int auto_increment,
    Customer_id int,
	Name varchar(255),
	Phone_number varchar(255),
	Email varchar(255),
    Address varchar(255),
    City varchar(255),
    State varchar(255),
    Country varchar(255),
    ZIP varchar(255),
    PRIMARY KEY (id)
    );   
    
CREATE TABLE IF NOT EXISTS Salesperson (
	id int auto_increment,
    Staff_id int,
	Name varchar(255),
	Store varchar(255),
	PRIMARY KEY (id)
    );
    
CREATE TABLE IF NOT EXISTS Invoices (
	id int auto_increment,
    Invoice_number varchar(255),
    Date_made date,
    Car int,
    Customer int,
    Sales_Person int,
    PRIMARY KEY (id)
    );
    
show tables;