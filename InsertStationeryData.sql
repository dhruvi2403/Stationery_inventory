-- Stationery Inventory Dummy Data Insertion Script
-- Instructions: Run this script against your 'ECommerce1' database using SQL Server Management Studio (SSMS)

USE ECommerce1;
GO

-- 1. Create a dummy Admin user if one doesn't exist
IF NOT EXISTS(SELECT 1 FROM users WHERE Username = 'admin' AND RoleId = 1)
BEGIN
    INSERT INTO users (Name, Username, Mobile, Email, Password, RoleId, CreatedDate)
    VALUES ('Super Admin', 'admin', '1234567890', 'admin@stationery.com', 'admin123', 1, GETDATE());
    PRINT 'Created default admin user (Username: admin, Password: admin123)';
END

-- 2. Insert dummy Categories
IF NOT EXISTS(SELECT 1 FROM Category WHERE CategoryName = 'Writing Instruments')
BEGIN
    INSERT INTO Category (CategoryName, IsActive, CreatedDate) VALUES ('Writing Instruments', 1, GETDATE());
    INSERT INTO Category (CategoryName, IsActive, CreatedDate) VALUES ('Notebooks & Paper', 1, GETDATE());
    INSERT INTO Category (CategoryName, IsActive, CreatedDate) VALUES ('Art Supplies', 1, GETDATE());
    INSERT INTO Category (CategoryName, IsActive, CreatedDate) VALUES ('Office Organization', 1, GETDATE());
    PRINT 'Inserted dummy categories.';
END

-- 3. Insert dummy SubCategories
DECLARE @WritingId INT = (SELECT Top 1 CategoryId FROM Category WHERE CategoryName = 'Writing Instruments');
DECLARE @PaperId INT = (SELECT Top 1 CategoryId FROM Category WHERE CategoryName = 'Notebooks & Paper');

IF @WritingId IS NOT NULL AND NOT EXISTS(SELECT 1 FROM SubCategory WHERE SubCategoryName = 'Pens')
BEGIN
    INSERT INTO SubCategory (CategoryId, SubCategoryName, IsActive, CreatedDate) VALUES (@WritingId, 'Pens', 1, GETDATE());
    INSERT INTO SubCategory (CategoryId, SubCategoryName, IsActive, CreatedDate) VALUES (@WritingId, 'Pencils', 1, GETDATE());
    
    INSERT INTO SubCategory (CategoryId, SubCategoryName, IsActive, CreatedDate) VALUES (@PaperId, 'Spiral Notebooks', 1, GETDATE());
    INSERT INTO SubCategory (CategoryId, SubCategoryName, IsActive, CreatedDate) VALUES (@PaperId, 'Printer Paper', 1, GETDATE());
    PRINT 'Inserted dummy subcategories.';
END

-- 4. Insert dummy Products
DECLARE @PenId INT = (SELECT Top 1 SubCategoryId FROM SubCategory WHERE SubCategoryName = 'Pens');
DECLARE @NotebookId INT = (SELECT Top 1 SubCategoryId FROM SubCategory WHERE SubCategoryName = 'Spiral Notebooks');

IF @PenId IS NOT NULL AND NOT EXISTS(SELECT 1 FROM Product WHERE ProductName = 'Pilot G2 Retractable Premium Gel Pens')
BEGIN
    INSERT INTO Product (ProductName, ShortDescription, LongDescription, AdditionalDescription, Price, Quantity, Size, Color, CompanyName, CategoryId, SubCategoryId, IsActive, IsCustomised, CreatedDate)
    VALUES (
        'Pilot G2 Retractable Premium Gel Pens', 
        'Fine Point, Black Ink.', 
        'Pilot G2 Premium Gel Roller pens are engineered for smooth writing. They feature a comfortable rubber grip and refillable ink.', 
        'Pack of 4.', 
        150.00, 
        100, 
        'Fine (0.7mm)', 
        'Black', 
        'Pilot', 
        @WritingId, 
        @PenId, 
        1, 0, GETDATE()
    );

    INSERT INTO Product (ProductName, ShortDescription, LongDescription, AdditionalDescription, Price, Quantity, Size, Color, CompanyName, CategoryId, SubCategoryId, IsActive, IsCustomised, CreatedDate)
    VALUES (
        'Classic College Ruled Spiral Notebook', 
        '1 subject notebook, 100 pages.', 
        'Perfect for school or office use. College ruled with margin. Durable spiral binding.', 
        'Dimensions: 8.5 x 11 inches', 
        60.00, 
        250, 
        'A4', 
        'Assorted Colors', 
        'Mead', 
        @PaperId, 
        @NotebookId, 
        1, 0, GETDATE()
    );

    INSERT INTO Product (ProductName, ShortDescription, LongDescription, AdditionalDescription, Price, Quantity, Size, Color, CompanyName, CategoryId, SubCategoryId, IsActive, IsCustomised, CreatedDate)
    VALUES (
        'Faber-Castell Grip 1345 Mechanical Pencil', 
        '0.5mm lead size, ergonomic grip.', 
        'Features a spring-loaded lead, protected against breakage. Includes a twist-out eraser.', 
        'Perfect for drafting or everyday writing.', 
        200.00, 
        50, 
        '0.5mm', 
        'Blue', 
        'Faber-Castell', 
        @WritingId, 
        (SELECT Top 1 SubCategoryId FROM SubCategory WHERE SubCategoryName = 'Pencils'), 
        1, 0, GETDATE()
    );
    
    PRINT 'Inserted dummy products.';
END
ELSE
BEGIN
    PRINT 'Dummy products already exist.';
END
GO
