-- ============================================================
-- SCRIPT DE CREACIÓN DE LA BASE DE DATOS NorthwindMart
-- Examen: Analítica de Sistemas Empresariales (NRC 7041)
-- Alumno: OROZCO
-- ============================================================

-- Crear la base de datos
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'NorthwindMart')
    DROP DATABASE NorthwindMart;
GO

CREATE DATABASE NorthwindMart;
GO

USE NorthwindMart;
GO

-- ============================================================
-- TABLA: Category_Dim (Categorías de productos)
-- ============================================================
CREATE TABLE Category_Dim (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(50) NOT NULL,
    Description NVARCHAR(255)
);
GO

-- ============================================================
-- TABLA: Product_Dim (Dimensión Producto)
-- ============================================================
CREATE TABLE Product_Dim (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName NVARCHAR(100) NOT NULL,
    CategoryID INT NOT NULL,
    UnitPrice DECIMAL(10,2),
    UnitsInStock INT,
    CONSTRAINT FK_Product_Category FOREIGN KEY (CategoryID) 
        REFERENCES Category_Dim(CategoryID)
);
GO

-- ============================================================
-- TABLA: Employee_Dim (Dimensión Empleado)
-- ============================================================
CREATE TABLE Employee_Dim (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    FullName AS (FirstName + ' ' + LastName) PERSISTED,
    Title NVARCHAR(50),
    City NVARCHAR(50),
    Region NVARCHAR(50),
    Country NVARCHAR(50)
);
GO

-- ============================================================
-- TABLA: Time_Dim (Dimensión Tiempo)
-- ============================================================
CREATE TABLE Time_Dim (
    TimeID INT PRIMARY KEY,
    FullDate DATE NOT NULL,
    [Day] INT,
    [Month] INT,
    MonthName NVARCHAR(20),
    Quarter INT,
    [Year] INT
);
GO

-- ============================================================
-- TABLA: Sales_Fact (Tabla de Hechos)
-- ============================================================
CREATE TABLE Sales_Fact (
    SalesID INT IDENTITY(1,1) PRIMARY KEY,
    ProductID INT NOT NULL,
    EmployeeID INT NOT NULL,
    TimeID INT NOT NULL,
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    SalesAmount DECIMAL(15,2),
    CONSTRAINT FK_Sales_Product FOREIGN KEY (ProductID) 
        REFERENCES Product_Dim(ProductID),
    CONSTRAINT FK_Sales_Employee FOREIGN KEY (EmployeeID) 
        REFERENCES Employee_Dim(EmployeeID),
    CONSTRAINT FK_Sales_Time FOREIGN KEY (TimeID) 
        REFERENCES Time_Dim(TimeID)
);
GO

-- ============================================================
-- POBLAR: Category_Dim (8 categorías)
-- ============================================================
INSERT INTO Category_Dim (CategoryName, Description) VALUES
('Bebidas', 'Refrescos, cafes, tes, cervezas'),
('Condimentos', 'Salsas dulces y saladas, aderezos'),
('Confites', 'Postres, dulces y panes dulces'),
('Lacteos', 'Quesos y derivados lacteos'),
('Granos/Cereales', 'Panes, galletas, pasta y cereales'),
('Carnes', 'Carnes preparadas'),
('Productos del mar', 'Algas marinas y pescados'),
('Frutas/Verduras', 'Frutas y vegetales frescos');
GO

-- ============================================================
-- POBLAR: Product_Dim (30 productos)
-- ============================================================
INSERT INTO Product_Dim (ProductName, CategoryID, UnitPrice, UnitsInStock) VALUES
('Chai', 1, 18.00, 39),
('Chang', 1, 19.00, 17),
('Aniseed Syrup', 2, 10.00, 13),
('Chef Anton Cajun Seasoning', 2, 22.00, 53),
('Grandma Boysenberry Spread', 2, 25.00, 120),
('Uncle Bob Organic Dried Pears', 8, 30.00, 15),
('Northwoods Cranberry Sauce', 2, 40.00, 6),
('Mishi Kobe Niku', 6, 97.00, 29),
('Ikura', 7, 31.00, 31),
('Queso Cabrales', 4, 21.00, 22),
('Queso Manchego La Pastora', 4, 38.00, 86),
('Konbu', 7, 6.00, 24),
('Tofu', 7, 23.25, 35),
('Genen Shouyu', 2, 15.50, 39),
('Pavlova', 3, 17.45, 29),
('Alice Mutton', 6, 39.00, 0),
('Carnarvon Tigers', 7, 62.50, 42),
('Teatime Chocolate Biscuits', 3, 9.20, 25),
('Sir Rodney Marmalade', 3, 81.00, 40),
('Sir Rodney Scones', 3, 10.00, 3),
('Gustaf Knackebrod', 5, 21.00, 104),
('Tunnbrod', 5, 9.00, 61),
('Guarana Fantastica', 1, 4.50, 20),
('NuNuCa Nuss-Nougat-Creme', 3, 14.00, 76),
('Gumbar Gummibarchen', 3, 31.23, 15),
('Schoggi Schokolade', 3, 43.90, 49),
('Rossle Sauerkraut', 8, 45.60, 26),
('Thuringer Rostbratwurst', 6, 123.79, 0),
('Nord-Ost Matjeshering', 7, 25.89, 10),
('Gravad lax', 7, 26.00, 11);
GO

-- ============================================================
-- POBLAR: Employee_Dim (9 empleados)
-- ============================================================
INSERT INTO Employee_Dim (FirstName, LastName, Title, City, Region, Country) VALUES
('Nancy', 'Davolio', 'Sales Representative', 'Seattle', 'WA', 'USA'),
('Andrew', 'Fuller', 'Vice President Sales', 'Tacoma', 'WA', 'USA'),
('Janet', 'Leverling', 'Sales Representative', 'Kirkland', 'WA', 'USA'),
('Margaret', 'Peacock', 'Sales Representative', 'Redmond', 'WA', 'USA'),
('Steven', 'Buchanan', 'Sales Manager', 'London', 'British Isles', 'UK'),
('Michael', 'Suyama', 'Sales Representative', 'London', 'British Isles', 'UK'),
('Robert', 'King', 'Sales Representative', 'London', 'British Isles', 'UK'),
('Laura', 'Callahan', 'Inside Sales Coordinator', 'Seattle', 'WA', 'USA'),
('Anne', 'Dodsworth', 'Sales Representative', 'London', 'British Isles', 'UK');
GO

-- ============================================================
-- POBLAR: Time_Dim (años 2022, 2023, 2024 = 1096 dias)
-- ============================================================
DECLARE @StartDate DATE = '2022-01-01';
DECLARE @EndDate DATE = '2024-12-31';
DECLARE @CurrentDate DATE = @StartDate;

WHILE @CurrentDate <= @EndDate
BEGIN
    INSERT INTO Time_Dim (TimeID, FullDate, [Day], [Month], MonthName, Quarter, [Year])
    VALUES (
        CONVERT(INT, CONVERT(VARCHAR, @CurrentDate, 112)),
        @CurrentDate,
        DAY(@CurrentDate),
        MONTH(@CurrentDate),
        DATENAME(MONTH, @CurrentDate),
        DATEPART(QUARTER, @CurrentDate),
        YEAR(@CurrentDate)
    );
    SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate);
END;
GO

-- ============================================================
-- POBLAR: Sales_Fact (2000 ventas aleatorias)
-- ============================================================
DECLARE @i INT = 1;
DECLARE @ProductID INT, @EmployeeID INT, @TimeID INT;
DECLARE @Quantity INT, @UnitPrice DECIMAL(10,2);

WHILE @i <= 2000
BEGIN
    SET @ProductID = (ABS(CHECKSUM(NEWID())) % 30) + 1;
    SET @EmployeeID = (ABS(CHECKSUM(NEWID())) % 9) + 1;
    
    SELECT TOP 1 @TimeID = TimeID 
    FROM Time_Dim 
    ORDER BY NEWID();
    
    SET @Quantity = (ABS(CHECKSUM(NEWID())) % 50) + 1;
    
    SELECT @UnitPrice = UnitPrice FROM Product_Dim WHERE ProductID = @ProductID;
    
    INSERT INTO Sales_Fact (ProductID, EmployeeID, TimeID, Quantity, UnitPrice, SalesAmount)
    VALUES (@ProductID, @EmployeeID, @TimeID, @Quantity, @UnitPrice, @Quantity * @UnitPrice);
    
    SET @i = @i + 1;
END;
GO

-- ============================================================
-- VERIFICACIÓN FINAL
-- ============================================================
PRINT '=== Verificacion de tablas ===';
SELECT 'Category_Dim' AS Tabla, COUNT(*) AS Registros FROM Category_Dim
UNION ALL SELECT 'Product_Dim', COUNT(*) FROM Product_Dim
UNION ALL SELECT 'Employee_Dim', COUNT(*) FROM Employee_Dim
UNION ALL SELECT 'Time_Dim', COUNT(*) FROM Time_Dim
UNION ALL SELECT 'Sales_Fact', COUNT(*) FROM Sales_Fact;
GO

PRINT 'OK Base de datos NorthwindMart creada exitosamente!';
GO
