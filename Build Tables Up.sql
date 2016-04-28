DROP DATABASE IF EXISTS BuildTables;

CREATE DATABASE BuildTables;

USE BuildTables;

CREATE TABLE Staff (staff_no VARCHAR(5), first_name TEXT(50), last_name TEXT(50), role ENUM('Assistant', 'Manager', 'Supervisor', 'CustomerService'), gender ENUM('M', 'F'), dob DATE, salary INTEGER(6), username VARCHAR(50), password VARCHAR(50), PRIMARY KEY (staff_no));

CREATE TABLE Apartments (apt_no INTEGER(3), apt_type INTEGER(1), apt_status ENUM('V', 'R'), apt_utility ENUM('Y', 'N'), apt_deposit_amt FLOAT(5), apt_rent_amt FLOAT(5), PRIMARY KEY (apt_no));

CREATE TABLE Handle_rents (rental_no INTEGER(6), rental_date DATE, rental_status ENUM('S', 'O'), cancel_date DATE, lease_type ENUM('One', 'Six'), lease_start DATE, lease_end DATE, renewal_date DATE, staff_no VARCHAR(5) NOT NULL, apt_no INTEGER(3) NOT NULL, PRIMARY KEY (rental_no), FOREIGN KEY (staff_no) REFERENCES Staff(staff_no), FOREIGN KEY (apt_no) REFERENCES Apartments(apt_no));

CREATE TABLE Tenant (tenant_ss INTEGER(9) NOT NULL, tenant_name TEXT(50), tenant_dob DATE, marital ENUM('M', 'S'), work_phone BIGINT(10), home_phone BIGINT(10), employer TEXT(50), gender ENUM('M', 'F'), username VARCHAR(50), password VARCHAR(50), rental_no INTEGER(6) NOT NULL, PRIMARY KEY (tenant_ss), FOREIGN KEY (rental_no) REFERENCES Handle_rents(rental_no));

CREATE TABLE Automobiles (tenant_ss INTEGER(9) NOT NULL, license_no VARCHAR(8), auto_make TEXT(50), auto_model VARCHAR(50), auto_year INTEGER(4), auto_color TEXT(15), PRIMARY KEY (license_no), FOREIGN KEY (tenant_ss) REFERENCES Tenant(tenant_ss));

CREATE TABLE Tenant_Family (tenant_ss INTEGER(9) NOT NULL, family_ss INTEGER(9), family_name TEXT(50), spouse ENUM('Y', 'N'), child TEXT(50), divorced ENUM('Y', 'N'), single ENUM('Y', 'N'), gender ENUM('M', 'F'), dob DATE, PRIMARY KEY (family_ss), FOREIGN KEY (tenant_ss) REFERENCES Tenant(tenant_ss));

CREATE  TABLE Complaints (complaint_id INTEGER(5), complaint_date DATE, rental_complaint TEXT, apt_complaint TEXT, rental_no INTEGER(6), apt_no INTEGER(3), status ENUM('F', 'P', '-'), PRIMARY KEY (complaint_id), FOREIGN KEY (rental_no) REFERENCES Handle_rents(rental_no), FOREIGN KEY (apt_no) REFERENCES Apartments(apt_no));

CREATE TABLE Invoices (invoice_no INTEGER(4), invoice_date DATE, invoice_due FLOAT(5), CC_no BIGINT(16), CC_type ENUM('Visa', 'Mastercard', 'American Express', 'Discover'), CC_exp_date DATE, CC_amt FLOAT(5), rental_no INTEGER(6) NOT NULL, PRIMARY KEY (invoice_no), FOREIGN KEY (rental_no) REFERENCES Handle_rents(rental_no));

CREATE TABLE Testimonies (testimonial_id INTEGER(3), testimonial_content TEXT, testimonial_date DATE, tenant_ss INTEGER(9) NOT NULL, PRIMARY KEY (testimonial_id), FOREIGN KEY (tenant_ss) REFERENCES Tenant(tenant_ss));

INSERT INTO Staff VALUES ('SA200', "Joe", "White", 'Assistant', 'M', '1982-07-08', 24000, 'ASSISTANT1', 'ASSISTANT1#');
INSERT INTO Staff VALUES ('SA210', "Ann", "Tremble", 'Assistant', 'F', '1981-06-12', 26000, 'ASSISTANT2', 'ASSISTANT2#');
INSERT INTO Staff VALUES ('SA220', "Terry", "Ford", 'Manager', 'M', '1967-10-20', 53000, 'MANAGER', 'MANAGER#');
INSERT INTO Staff VALUES ('SA230', "Susan", "Brandon", 'Supervisor', 'F', '1977-03-10', 46000, 'SUPERVISOR', 'SUPERVISOR#');
INSERT INTO Staff VALUES ('SA240', "Julia", "Roberts", 'Assistant', 'F', '1982-09-12', 28000, 'ASSISTANT3', 'ASSISTANT3#');

INSERT INTO Apartments VALUES (100, 0, 'R', 'Y', 200, 300);
INSERT INTO Apartments VALUES (101, 0, 'R', 'N', 200, 300);
INSERT INTO Apartments VALUES (102, 0, 'R', 'Y', 200, 300);
INSERT INTO Apartments VALUES (103, 1, 'V', 'N', 300, 400);
INSERT INTO Apartments VALUES (104, 1, 'R', 'Y', 300, 400);
INSERT INTO Apartments VALUES (200, 2, 'V', 'Y', 400, 500);
INSERT INTO Apartments VALUES (201, 2, 'R', 'Y', 400, 500);
INSERT INTO Apartments VALUES (202, 3, 'V', 'Y', 500, 700);
INSERT INTO Apartments VALUES (203, 3, 'R', 'Y', 500, 700);

INSERT INTO Handle_rents VALUES  (100101, '2001-05-12', 'O', '2001-06-30', 'One', '2001-06-01', '2003-05-31', '2003-03-31', 'SA200', 201);
INSERT INTO Handle_rents VALUES  (100102, '2001-05-21', 'O', '2001-06-30', 'Six', '2001-06-01', '2003-05-31', '2003-03-31', 'SA220', 102);
INSERT INTO Handle_rents VALUES  (100103, '2001-10-12', 'O', '2001-11-30', 'Six', '2001-11-01', '2003-11-30', '2003-09-30', 'SA240', 203);
INSERT INTO Handle_rents VALUES  (100104, '2002-03-06', 'O', '2002-04-30', 'One', '2002-04-02', '2003-03-31', '2003-01-31', 'SA210', 101);
INSERT INTO Handle_rents VALUES  (100105, '2002-04-15', 'O', '2002-05-30', 'One', '2002-05-02', '2003-04-30', '2003-02-28', 'SA220', 104);
INSERT INTO Handle_rents VALUES  (100106, '2002-07-15', 'S', '2002-08-30', 'One', '2002-08-02', '2003-06-30', '2003-06-30', 'SA200', 100);

INSERT INTO Complaints VALUES (10010, '2001-06-12', " ", "kitchen sink clogged", 100103, 203, 'F');
INSERT INTO Complaints VALUES (10011, '2001-08-17', " ", "water heater not working", 100105, 104, 'F');
INSERT INTO Complaints VALUES (10012, '2002-09-17', " ", "room heater problem", 100105, 104, 'F');
INSERT INTO Complaints VALUES (10013, '2002-09-17', " ", "Air conditioning not working", NULL, 103, '-');
INSERT INTO Complaints VALUES (10014, '2002-10-20', "Car parking not proper", " ", 100103, NULL, '-');
INSERT INTO Complaints VALUES (10015, '2002-11-08', "Delay in payment", " ", 100102, NULL, 'F');
INSERT INTO Complaints VALUES (10016, '2002-11-16', " ", "Utility not working", NULL, 202, '-');

INSERT INTO Tenant VALUES(123456789, "Jack Robin",'1960-06-21', 'M', 4173452323, 4175556565, "Kraft Inc", 'M', 'TENANT1', 'TENANT1#', 100101);
INSERT INTO Tenant VALUES(723556089, "Mary Stackles",'1980-08-02', 'S', 4175453320, 4176667565, "Kraft Inc", 'F', 'TENANT2', 'TENANT2#', 100102);
INSERT INTO Tenant VALUES(450452267, "Ramu Reddy",'1962-04-11', 'M', 4178362323, 4172220565, "SMFU", 'M', 'TENANT3', 'TENANT3#', 100103);
INSERT INTO Tenant VALUES(223056180, "Marion Black",'1981-05-25', 'S', 4174257766, 4176772364, "SMFU", 'M', 'TENANT4', 'TENANT4#', 100104);
INSERT INTO Tenant VALUES(173662690, "Venessa Williams",'1970-03-12', 'M', 4175557878, 4173362565, "Kraft Inc", 'F', 'TENANT5', 'TENANT5#', 100105);

INSERT INTO Automobiles VALUES (123456789, 'SYK332', "Ford", "Taurus", 1999, "Red");
INSERT INTO Automobiles VALUES (123456789, 'TTS430', "Volvo", 'GL 740', 1990, "Green");
INSERT INTO Automobiles VALUES (723556089, 'ABC260', "Toyota", 'Lexus', 2000, "Maroon");
INSERT INTO Automobiles VALUES (450452267, 'LLT322', "Honda", 'Accord', 2001, "Blue");
INSERT INTO Automobiles VALUES (450452267, 'KYK100', "Toyota", 'Camry', 1999, "Black");
INSERT INTO Automobiles VALUES (223056180, 'FLT232', "Honda", 'Civic', 1999, "Red");
INSERT INTO Automobiles VALUES (173662690, 'LLT668', "Volvo", 'GL 980', 2000, "Velvet");

INSERT INTO Tenant_Family VALUES (123456789, 444663434, "Kay Robin", 'Y', 'N', 'N', 'N', 'F', '1965-06-21');
INSERT INTO Tenant_Family VALUES (450452267, 222664343, "Saria Reddy", 'Y', 'N', 'N', 'N', 'F', '1965-06-11');
INSERT INTO Tenant_Family VALUES (450452267, 222663434, "Anjali Reddy", 'N', 'Y', 'N', 'N', 'F', '1990-08-10');
INSERT INTO Tenant_Family VALUES (173662690, 111444663, "Terry Williams", 'Y', 'N', 'N', 'N', 'F', '1968-03-21');
INSERT INTO Tenant_Family VALUES (173662690, 242446634, "Tom Williams", 'N', 'Y', 'N', 'N', 'M', '1991-05-20');

INSERT INTO Invoices VALUES (1000, '2001-03-12', 500, 1234567890123456, 'Visa', '2002-12-01', 500, 100101);
INSERT INTO Invoices VALUES (1001, '2001-04-30', 500, 1234567890123456, 'Visa', '2002-12-01', 500, 100101);
INSERT INTO Invoices VALUES (1002, '2001-05-30', 500, 1234567890123456, 'Visa', '2002-12-01', 500, 100101);
INSERT INTO Invoices VALUES (1003, '2001-06-30', 500, 1234567890123456, 'Visa', '2002-12-01', 500, 100101);
INSERT INTO Invoices VALUES (1004, '2001-07-30', 500, 1234567890123456, 'Mastercard', '2002-12-01', 500, 100101);
INSERT INTO Invoices VALUES (1005, '2001-08-30', 500, 1234567890123456, 'Mastercard', '2002-12-01', 500, 100101);
INSERT INTO Invoices VALUES (1006, '2001-09-30', 500, 1234567890123456, 'Visa', '2002-12-01', 500, 100101);
INSERT INTO Invoices VALUES (1007, '2001-10-30', 500, 1234567890123456, 'Visa', '2002-12-01', 500, 100101);
INSERT INTO Invoices VALUES (1008, '2001-11-30', 500, 1234567890123456, 'Visa', '2002-12-01', 500, 100101);

INSERT INTO Invoices VALUES (1009, '2001-05-21', 300, 3343567890123456, 'Mastercard', '2003-10-01', 300, 100102);
INSERT INTO Invoices VALUES (1010, '2001-06-30', 300, 3343567890123456, 'Mastercard', '2003-10-01', 300, 100102);
INSERT INTO Invoices VALUES (1011, '2001-07-30', 300, 3343567890123456, 'Mastercard', '2003-10-01', 300, 100102);
INSERT INTO Invoices VALUES (1012, '2001-08-30', 300, 3343567890123456, 'Mastercard', '2003-10-01', 300, 100102);
INSERT INTO Invoices VALUES (1013, '2001-09-30', 300, 3343567890123456, 'Mastercard', '2003-10-01', 300, 100102);
INSERT INTO Invoices VALUES (1014, '2001-10-30', 300, 3343567890123456, 'Mastercard', '2003-10-01', 300, 100102);
INSERT INTO Invoices VALUES (1015, '2001-11-30', 300, 3343567890123456, 'Mastercard', '2003-10-01', 300, 100102);

INSERT INTO Invoices VALUES (1016, '2001-10-12', 700, 8654567890123296, 'Discover', '2003-11-03', 700, 100103);
INSERT INTO Invoices VALUES (1017, '2001-11-30', 700, 8654567890123296, 'Discover', '2003-11-03', 700, 100103);

INSERT INTO Invoices VALUES (1018, '2002-03-06', 500, 7766567890123203, 'Visa', '2003-09-01', 500, 100104);
INSERT INTO Invoices VALUES (1019, '2002-04-30', 300, 7766567890123203, 'Visa', '2003-09-01', 300, 100104);
INSERT INTO Invoices VALUES (1020, '2002-05-30', 300, 7766567890123203, 'Visa', '2003-09-01', 300, 100104);
INSERT INTO Invoices VALUES (1021, '2002-06-30', 300, 7766567890123203, 'Visa', '2003-09-01', 300, 100104);
INSERT INTO Invoices VALUES (1022, '2002-07-30', 300, 7766567890123203, 'Visa', '2003-09-01', 300, 100104);

INSERT INTO Invoices VALUES (1023, '2002-04-15', 700, 6599567890126211, 'Visa', '2003-12-01', 700, 100105);
INSERT INTO Invoices VALUES (1024, '2002-05-30', 400, 6599567890126211, 'Visa', '2003-12-01', 400, 100105);
INSERT INTO Invoices VALUES (1025, '2002-06-30', 400, 6599567890126211, 'Discover', '2003-12-01', 400, 100105);
INSERT INTO Invoices VALUES (1026, '2002-07-30', 400, 6599567890126211, 'Discover', '2003-12-01', 400, 100105);

INSERT INTO Testimonies VALUES (001, "I really like TEAM2OARS Online Apartment Rental System!", '2002-03-31', 123456789);
INSERT INTO Testimonies VALUES (002, "I think that this TEAM2OARS website can be improved!", '2002-04-09', 450452267);
INSERT INTO Testimonies VALUES (003, "I believe that the Tenants and Visitors will like TEAM2OARS since the can rent and manage apartments online.", '2002-04-25', 173662690);