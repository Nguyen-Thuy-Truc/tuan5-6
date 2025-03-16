USE KTRA
CREATE DATABASE BANHANG
ON PRIMARY
( NAME = 'BANHANG', FILENAME = 'D:\CSDL\BANHANG.mdf' , 
SIZE = 4048KB , MAXSIZE = 10240KB , FILEGROWTH = 20%)
LOG ON
( NAME = 'BANHANG_log', FILENAME = 'D:\CSDL\BANHANG_log1.ldf' , 
SIZE = 1024KB , MAXSIZE = 10240KB , FILEGROWTH = 10%)

USE KTRA
CREATE TABLE Products
(ProductID INT PRIMARY KEY NOT NULL,
ProductName VARCHAR(255) NOT NULL,
SupplierID INT,
UnitPrice DECIMAL(10,2),
UnitInStock INT)

CREATE TABLE Customers
(CustomerID INT PRIMARY KEY,      
CompanyName VARCHAR(255),        
Address VARCHAR(255),           
City VARCHAR(100),             
Region VARCHAR(100),             
Country VARCHAR(100))

CREATE TABLE Employees 
(EmployeeID INT PRIMARY KEY NOT NULL,      
LastName VARCHAR(100),           
FirstName VARCHAR(100),         
BirthDate DATE,                  
City VARCHAR(100))  

CREATE TABLE Orders 
(OrderID INT PRIMARY KEY,         
CustomerID INT,                  
EmployeeID INT,                
OrderDate DATE,                  
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID))

CREATE TABLE OrderDetails 
(OrderID INT NOT NULL,                    
ProductID INT NOT NULL,                  
UnitPrice DECIMAL(10,2),      
Quantity INT,                     
Discount DECIMAL(5,2),           
PRIMARY KEY (OrderID, ProductID),
FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
FOREIGN KEY (ProductID) REFERENCES Products(ProductID))

CREATE TABLE Suppliers 
(SupplierID INT PRIMARY KEY NOT NULL,
SupplierName VARCHAR(255))

INSERT INTO Products VALUES
(1, 'Cà phê đen', 1, 25000, 100),
(2, 'Trà xanh', 2, 20000, 50),
(3, 'Bánh ngọt', 3, 15000, 30),
(4, 'Panacotta', 4, 16000, 20)

INSERT INTO Customers VALUES
(1, 'Công ty A', '123 Đường ABC', 'Hà Nội', 'Miền Bắc', 'Việt Nam'),
(2, 'Công ty B', '456 Đường XYZ', 'TP. HCM', 'Miền Nam', 'Việt Nam'),
(3, 'Công ty C', '789 Đường DEF', 'Đà Nẵng', 'Miền Trung', 'Việt Nam'),
(4, 'Banali', '356 Lê Lợi', 'LonDon', 'Trung','Anh'),
(5, 'Manali', '123 Lê Lai', 'Boise', 'Idaho', 'Hoa Kỳ'),
(6, 'Beauty', '64 Trần Hưng Đạo', 'Paris', 'France', 'Pháp'),
(7, 'GoGo', '25 Lê Quang Định', 'Lyon', 'Rhone', 'Pháp'),
(8, 'Meme', '25 Lê Quang Định', 'Mianma', 'Rhone', 'Pháp')

INSERT INTO Employees VALUES
(1, 'Nguyễn', 'Văn A', '1990-05-10', 'Hà Nội'),
(2, 'Trần', 'Thị B', '1995-08-20', 'TP. HCM'),
(3, 'Lê', 'Văn C', '2000-12-15', 'Đà Nẵng'),
(4, 'Phạm', 'Vy', '1960-03-10', 'Lyon'),
(5, 'Nguyễn', 'My', '1960-01-13', 'LonDon'),
(6, 'Trần', 'Mạnh', '1960-09-01', 'Boise'),
(7, 'Huỳnh', 'Vinh', '1960-03-02', 'Paris')

INSERT INTO Orders VALUES
(1, 1, 1, '2025-03-10'),
(2, 2, 2, '2025-03-11'),
(3, 3, 3, '2025-03-12'),
(4, 4, 4, '1997-07-12'),
(5, 5, 5, '1997-01-04')
SELECT*FROM OrderDetails

INSERT INTO OrderDetails VALUES
(1, 1, 25000, 2, 0.05),
(2, 2, 20000, 1, 0.00),
(3, 3, 15000, 5, 0.10),
(4, 4, 16000, 4, 0)

INSERT INTO Suppliers VALUES
(1, 'Nhà cung cấp X'),
(2, 'Nhà cung cấp Y'),
(3, 'Nhà cung cấp Z')

/*TUAN5*/
SELECT*FROM Products 
SELECT CustomerID,CompanyName,City, Phone FROM Customers 
SELECT ProductID, ProductName, UnitPrice FROM Products
SELECT EmployeeID, LastName +''+ FirstName AS EmployeeName, Year(getdate()) - Year(BirthDate) Age FROM Employees
SELECT*FROM Customers WHERE CONTACTTITLE LIKE '0%'
SELECT*FROM Customers WHERE City IN ('LonDon', 'Boise', 'Paris')
SELECT*FROM Customers WHERE CustomerID LIKE 'V%' AND City = 'Lyon'
SELECT*FROM Customers WHERE Fax IS NULL
SELECT*FROM Customers WHERE Fax IS NOT NULL
SELECT*FROM Employees WHERE BirthDate <= '1960-12-31'
SELECT*FROM Products WHERE QuantityPerUnit LIKE '%Boxes%'
SELECT*FROM Products WHERE UnitPrice > 12.00 AND UnitPrice < 20.00
SELECT*FROM Orders WHERE OrderDate >= '1996-09-01' AND OrderDate <= '1990-10-01' ORDER BY CustomerID, OrderDate DESC
SELECT*FROM Orders WHERE OrderDate >= '1997-10-01' AND OrderDate < '1998-01-01' ORDER BY OrderDate
SELECT OrderID, CustomerID, EmployeeID, OrderDate, DATENAME(WEEKDAY, OrderDate) AS WEEKDAY 
FROM Orders WHERE MONTH(OrderDate) = 12 AND YEAR(OrderDate) = 1997 AND DATENAME(WEEKDAY, OrderDate) = 'Saturday' OR DATENAME(WEEKDAY, OrderDate) = 'Sunday'
SELECT ProductID, ProductName, UniPrice, UnitInStock, UniPrice*UnitInStock AS Total FROM Products 
SELECT TOP 5 * FROM Customers WHERE City LIKE 'M%'
SELECT TOP 2 EmployeeID, LastName + ' ' + FirstName AS EmployeeName, YEAR(GETDATE()) - YEAR(BirthDate) AS Age FROM Employees ORDER BY Age DESC
SELECT*FROM Products WHERE UnitInStock < 20
SELECT OrderID, ProductID, UnitPrice, Quantity, Discount, (UnitPrice*Quantity - 0.2*Discount) AS Total FROM OrderDetails

/*TUAN6*/
SELECT Customers.CustomerID, Customers.CompanyName, Customers.Address, Orders.OrderID, Orders.OrderDate 
FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID 
WHERE OrderDate >=' 1997-07-01' AND OrderDate <= '1997-08-01'
ORDER BY OrderDate DESC

SELECT*FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.OrderID 
WHERE OrderDate >= '1997-01-01' AND OrderDate <= '1997-01-15'

SELECT*FROM Products INNER JOIN OrderDetails ON Products.ProductID = OrderDetails.ProductID
INNER JOIN Orders ON Orders.OrderID = OrderDetails.OrderID
WHERE OrderDate = '1997-07-12'

ALTER TABLE Orders ADD RequiredDate DATE NULL
INSERT INTO Orders VALUES 
(6, 1, 1, '1997-04-01', '1997-03-22'),
(7, 2, 2, '1997-04-01', '1997-03-22')
select*from Orders
SELECT Orders.OrderID, Customers.CompanyName, Orders.OrderDate, Orders.RequiredDate
FROM Orders INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID
WHERE MONTH(OrderDate) IN (4, 9) AND YEAR(OrderDate) = 1997
ORDER BY Customers.CompanyName, Orders.OrderDate DESC

INSERT INTO Employees VALUES (14, 'Fuller', 'Mary', '2005-01-04', 'TP. HCM')
INSERT INTO Orders VALUES (17, 1, 14, '1996-12-06', '1996-12-17')
SELECT*FROM Orders INNER JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
WHERE Employees.LastName = 'Fuller'

INSERT INTO Orders VALUES (41, 1, 1, '1997-05-15', '1997-06-01')
INSERT INTO OrderDetails VALUES (41, 1, 25000, 1, 0)
SELECT*FROM Products INNER JOIN OrderDetails ON Products.ProductID = OrderDetails.ProductID
INNER JOIN Orders ON OrderDetails.OrderID = Orders.OrderID
WHERE Products.SupplierID IN (1, 3, 6) AND Orders.OrderDate BETWEEN '1997-04-01' AND '1997-06-30'
ORDER BY Products.SupplierID, Products.ProductID

SELECT * FROM Products 
WHERE UnitPrice = (SELECT UnitPrice FROM OrderDetails WHERE Products.ProductID = OrderDetails.ProductID)

INSERT INTO Orders VALUES(10248, 1, 1, '1996-12-14', '1996-12-28')					
INSERT INTO OrderDetails VALUES (10248, 1, 25000, 1,0)
SELECT*FROM Products INNER JOIN OrderDetails ON Products.ProductID = OrderDetails.ProductID
WHERE OrderDetails.OrderID = 10248

INSERT INTO Orders VALUES (9, 1, 1, '1996-07-14', '1996-12-28')
SELECT*FROM Orders INNER JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
WHERE Orders.OrderDate BETWEEN '1996-07-01' AND '1996-07-31'

SELECT Products.ProductID, Products.ProductName, Orders.OrderID, Orders.OrderDate, Orders.CustomerID, OrderDetails.UnitPrice, OrderDetails.Quantity, OrderDetails.Quantity*OrderDetails.UnitPrice AS Total, DATENAME(WEEKDAY, OrderDate) AS WEEKDAY
FROM OrderDetails INNER JOIN Products ON OrderDetails.ProductID = Products.ProductID 
INNER JOIN Orders ON OrderDetails.OrderID = Orders.OrderID
WHERE Month(OrderDate) = 12 and Year(OrderDate) = 1996 AND DATENAME(WEEKDAY, OrderDate) = 'Saturday' OR  DATENAME(WEEKDAY, OrderDate) = 'Sunday' 
ORDER BY OrderDetails.ProductID, OrderDetails.Quantity DESC

SELECT Employees.EmployeeID, Employees.LastName + ' ' + Employees.FirstName AS EmployName, Orders.OrderID, Orders.OrderDate, OrderDetails.ProductID, OrderDetails.Quantity, OrderDetails.UnitPrice, OrderDetails.Quantity * OrderDetails.UnitPrice AS Total
FROM Employees
JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
WHERE YEAR(OrderDate) = 1996

SELECT Orders.OrderID, Orders.OrderDate, Orders.RequiredDate, DATENAME(WEEKDAY, OrderDate) AS WEEKDAY
FROM Orders
WHERE Month(OrderDate) = 12 and Year(OrderDate) = 1996 AND DATENAME(WEEKDAY, OrderDate) = 'Saturday'

SELECT*FROM Employees LEFT JOIN OrderS ON Employees.EmployeeID = Orders.EmployeeID
WHERE Orders.EmployeeID IS NULL

INSERT INTO Products VALUES (10, 'Phấn phủ', 1, 300000, 9)
SELECT*FROM Products LEFT JOIN OrderDetails ON Products.ProductID = OrderDetails.ProductID
WHERE OrderDetails.ProductID IS NULL

SELECT*FROM Customers LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Orders.CustomerID IS NULL
