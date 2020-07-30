--Drop all tables
DROP TABLE t;
DROP TABLE v;
DROP TABLE c;

-- Create the table for the Vendor
CREATE TABLE v (
  Vno CHAR(6) PRIMARY KEY,
  Vname CHAR(24) NOT NULL,
  City CHAR(24) NOT NULL,
  Vbalance NUMERIC NOT NULL
);

-- Create the table for the Customer
CREATE TABLE c (
  Account CHAR(6) PRIMARY KEY,
  Cname CHAR(24) NOT NULL,
  Province CHAR(24) NOT NULL,
  Cbalance NUMERIC NOT NULL,
  Crlimit NUMERIC NOT NULL
);

-- Create the table for the Transaction
CREATE TABLE t (
  Tno CHAR(6) PRIMARY KEY,
  Vno CHAR(6) REFERENCES v(Vno),
  Account CHAR(6) REFERENCES c(Account),
  T_Date DATE NOT NULL,
  Amount NUMERIC NOT NULL
);

-- Insert Vendor data into the table v
INSERT INTO v(Vno, Vname, City, Vbalance) VALUES
('V1', 'Sears', 'Toronto', 200.00),
('V2', 'WalMart', 'Waterloo', 671.05),
('V3', 'Esso', 'Windsor', 0.00),
('V4', 'Esso', 'Waterloo', 225.00);

-- Insert Customer data into the table c
INSERT INTO c(Account, Cname, Province, Cbalance, Crlimit) VALUES
('A1', 'Smith', 'ONT', 2515.00, 2000),
('A2', 'Jones', 'BC', 2014.00, 2500),
('A3', 'Doc', 'ONT', 150.00, 1000);

-- Insert Transaction data into the table t
INSERT INTO t(Tno, Vno, Account, T_Date, Amount) VALUES
('T1', 'V2', 'A1', '2019-07-15', 1325.00),
('T2', 'V2', 'A3', '2018-12-16', 1900.00),
('T3', 'V3', 'A1', '2019-09-01', 2500.00),
('T4', 'V4', 'A2', '2019-03-20', 1613.00),
('T5', 'V4', 'A3', '2019-07-31', 3312.00);
