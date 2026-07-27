create database ecommmerce;
use ecommmerce;
select * from customers;
select * from orders;
select * from campaigns;
select * from products;
select * from returns;
describe orders;

ALTER TABLE customers
ADD CONSTRAINT PK_Customers
PRIMARY KEY (Customer_ID);

ALTER TABLE customers
MODIFY Customer_ID VARCHAR(50) NOT NULL;

ALTER TABLE customers
ADD CONSTRAINT PK_Customers
PRIMARY KEY (Customer_ID);

ALTER TABLE Products
ADD CONSTRAINT PK_Products
PRIMARY KEY (Product_ID);

ALTER TABLE products
MODIFY Product_ID VARCHAR(50) NOT NULL;

ALTER TABLE Orders
ADD CONSTRAINT PK_Orders
PRIMARY KEY (Order_ID);

ALTER TABLE orders
MODIFY order_ID VARCHAR(50) NOT NULL;

ALTER TABLE Returns
ADD CONSTRAINT PK_Returns
PRIMARY KEY (Return_ID);

ALTER TABLE returns
MODIFY return_ID VARCHAR(50) NOT NULL;

ALTER TABLE Campaigns
ADD CONSTRAINT PK_Campaigns
PRIMARY KEY (Campaign_ID);

ALTER TABLE campaigns
MODIFY Campaign_ID VARCHAR(50) NOT NULL;

ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_Customers
FOREIGN KEY (Customer_ID)
REFERENCES Customers(Customer_ID);

ALTER TABLE Customers
MODIFY Customer_ID VARCHAR(50) NOT NULL;

ALTER TABLE Orders
MODIFY Customer_ID VARCHAR(50) NOT NULL;

ALTER TABLE Returns
ADD CONSTRAINT FK_Returns_Orders
FOREIGN KEY (Order_ID)
REFERENCES Orders(Order_ID);

ALTER TABLE Orders
MODIFY Order_ID VARCHAR(50) NOT NULL;

ALTER TABLE Returns
MODIFY Order_ID VARCHAR(50) NOT NULL;

ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_Products
FOREIGN KEY (Product_ID)
REFERENCES Products(Product_ID);

ALTER TABLE Orders
MODIFY product_ID VARCHAR(50) NOT NULL;

ALTER TABLE products
MODIFY Product_ID VARCHAR(50) NOT NULL;

ALTER TABLE Returns
ADD CONSTRAINT FK_Returns_Customers
FOREIGN KEY (Customer_ID)
REFERENCES Customers(Customer_ID);

ALTER TABLE Customers
MODIFY Customer_ID VARCHAR(50) NOT NULL;

ALTER TABLE Returns
MODIFY Customer_ID VARCHAR(50) NOT NULL;

ALTER TABLE Returns
ADD CONSTRAINT FK_Returns_Products
FOREIGN KEY (Product_ID)
REFERENCES Products(Product_ID);

ALTER TABLE Products
MODIFY COLUMN Product_ID VARCHAR(50) NOT NULL;

ALTER TABLE Returns
MODIFY COLUMN Product_ID VARCHAR(50) NOT NULL;

#AOV BY STATE
SELECT
    c.State,
    SUM(o.Gross_Amount_INR) / COUNT(DISTINCT o.Order_ID) AS AOV
FROM orders o
JOIN customers c
    ON o.Customer_ID = c.Customer_ID
GROUP BY c.State
ORDER BY AOV DESC;

# TOTAL ORDERS
SELECT COUNT(DISTINCT Order_ID) AS Total_Orders
FROM orders;

# TOP 10 PRODUCTS BY REVENUE
SELECT
    Product_Name,
    SUM(Gross_Amount_INR) AS Revenue
FROM orders
GROUP BY Product_Name
ORDER BY Revenue DESC
LIMIT 10;

# TOP 5 REVENUE CITIES
SELECT
    c.City,
    SUM(o.Gross_Amount_INR) AS Revenue
FROM orders o
JOIN customers c
    ON o.Customer_ID = c.Customer_ID
GROUP BY c.City
ORDER BY Revenue DESC
LIMIT 5;

# REVENUE BY CATEGORY
SELECT
    Category,
    SUM(Gross_Amount_INR) AS Revenue
FROM orders
GROUP BY Category
ORDER BY Revenue DESC;

# REFUND PROCESSING RATE
SELECT
    (COUNT(CASE WHEN Refund_Status = 'Processed' THEN 1 END) * 100.0)
    / COUNT(*) AS Refund_Processing_Rate
FROM returns;

# ORDERS BY STATE
SELECT
    c.State,
    COUNT(DISTINCT o.Order_ID) AS Total_Orders
FROM orders o
JOIN customers c
    ON o.Customer_ID = c.Customer_ID
GROUP BY c.State
ORDER BY Total_Orders DESC;

# NET REVENUE
SELECT SUM(Final_Amount_INR) AS Net_Revenue
FROM orders
WHERE Order_Status = 'Delivered';

#GMV
SELECT SUM(Gross_Amount_INR) AS GMV
FROM orders;

# BRAND REVENUE SHARE
SELECT
    Brand,
    ROUND(
        SUM(Gross_Amount_INR) * 100.0 /
        (SELECT SUM(Gross_Amount_INR) FROM orders),
        2
    ) AS Brand_Revenue_Share_Percentage
FROM orders
GROUP BY Brand
ORDER BY Brand_Revenue_Share_Percentage DESC;

# AVERAGE SHIPPING DATE
SELECT AVG(Shipping_Days) AS Avg_Shipping_Days
FROM orders
WHERE Order_Status = 'Delivered';

#AOV
SELECT
    SUM(Final_Amount_INR) / COUNT(DISTINCT Order_ID) AS AOV
FROM orders;




