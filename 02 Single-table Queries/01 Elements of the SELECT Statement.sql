/*
Elements of the SELECT Statement
*/

USE TSQLV4;

SELECT empid, 
	  YEAR(orderdate) AS orderyear, 
	  COUNT(*) AS numorders
FROM Sales.Orders
WHERE custid = 71
GROUP BY empid, 
	    YEAR(orderdate)
HAVING COUNT(*) > 1
ORDER BY empid, 
	    orderyear; 

-- FROM clause
SELECT orderid, 
	  custid, 
	  empid, 
	  orderdate, 
	  freight
FROM Sales.Orders;

-- WHERE clause
SELECT orderid, 
	  empid, 
	  orderdate, 
	  freight
FROM Sales.Orders
WHERE custid = 71;

-- GROUP BY clause
SELECT empid, 
	  YEAR(orderdate) AS orderyear, 
	  SUM(freight) AS totalfreight, 
	  COUNT(*) AS numorders
FROM Sales.Orders
WHERE custid = 71
GROUP BY empid, 
	    YEAR(orderdate);

SELECT empid, 
	  YEAR(orderdate) AS orderyear, 
	  COUNT(DISTINCT custid) AS numcusts
FROM Sales.Orders
GROUP BY empid, 
	    YEAR(orderdate);

-- HAVING clause
SELECT empid, 
	  YEAR(orderdate) AS orderyear
FROM Sales.Orders
WHERE custid = 71
GROUP BY empid, 
	    YEAR(orderdate)
HAVING COUNT(*) > 1;

-- SELECT clause
SELECT orderid orderdate  -- missing comma results in SQL Server using "orderdate" as an alias for "orderid"
FROM Sales.Orders;

SELECT empid, 
	  YEAR(orderdate) AS orderyear, 
	  COUNT(*) AS numorders
FROM Sales.Orders
WHERE custid = 71
GROUP BY empid, 
	    YEAR(orderdate)
HAVING COUNT(*) > 1;

SELECT empid, 
	  YEAR(orderdate) AS orderyear, 
	  COUNT(*) AS numorders
FROM Sales.Orders
WHERE orderyear > 2015; -- cannot reference expression aliases in clauses processed before SELECT clause

SELECT empid, 
	  YEAR(orderdate) AS orderyear, 
	  COUNT(*) AS numorders
FROM Sales.Orders
WHERE custid = 71
GROUP BY empid, 
	    YEAR(orderdate)
HAVING numorders > 1;   -- cannot reference expression aliases in clauses processed before SELECT clause

-- Query returning duplicate rows
SELECT empid, 
	  YEAR(orderdate) AS orderyear
FROM Sales.Orders
WHERE custid = 71;

-- DISTINCT clause
SELECT DISTINCT 
	  empid, 
	  YEAR(orderdate) AS orderyear
FROM Sales.Orders
WHERE custid = 71;

-- Selecting all attributes
SELECT *
FROM Sales.Shippers;

-- Not allowed to refer to column aliases created in SELECT clause in other expressions within same SELECT clause
SELECT orderid, 
	  YEAR(orderdate) AS orderyear, 
	  orderyear + 1 AS nextyear
FROM Sales.Orders;

SELECT orderid, 
	  YEAR(orderdate) AS orderyear, 
	  YEAR(orderdate) + 1 AS nextyear
FROM Sales.Orders;

-- ORDER BY clause
SELECT empid, 
	  YEAR(orderdate) AS orderyear, 
	  COUNT(*) AS numorders
FROM Sales.Orders
WHERE custid = 71
GROUP BY empid, 
	    YEAR(orderdate)
HAVING COUNT(*) > 1
ORDER BY 1, 
	    2; -- BAD PRACTICE to specify columns by ordinal position in SELECT clause

SELECT empid, 
	  firstname, 
	  lastname, 
	  country
FROM HR.Employees
ORDER BY hiredate;	-- order by column not specified in SELECT clause

SELECT DISTINCT 
	  country
FROM HR.Employees
ORDER BY empid; -- DISTINCT clause restricts ORDER BY to columns specified in SELECT clause

-- TOP filter

-- Retrieve the five most recent orders (non-deterministic)
SELECT TOP 5 orderid, 
		   orderdate, 
		   custid, 
		   empid
FROM Sales.Orders
ORDER BY orderdate DESC;

-- Retrieve the five most recent orders (deterministic)
SELECT TOP 5 orderid, 
		   orderdate, 
		   custid, 
		   empid
FROM Sales.Orders
ORDER BY orderdate DESC, orderid DESC;

-- TOP n PERCENT rows
SELECT TOP 1 PERCENT orderid, 
				 orderdate, 
				 custid, 
				 empid
FROM Sales.Orders
ORDER BY orderdate DESC;

-- WITH TIES option
SELECT TOP 5 WITH TIES orderid, -- result set is deterministic when using WITH TIES option
				   orderdate, 
				   custid, 
				   empid
FROM Sales.Orders
ORDER BY orderdate DESC;	   -- but presentation order among rows with same order date is not, since ORDER BY list not unique

-- OFFSET-FETCH filter
SELECT orderid, 
	  orderdate, 
	  custid, 
	  empid
FROM Sales.Orders
ORDER BY orderdate, 
	    orderid
OFFSET 50 ROWS FETCH NEXT 25 ROWS ONLY;



/* Window Functions */

-- ROW_NUMBER function
SELECT orderid, 
	  custid, 
	  val, 
	  ROW_NUMBER() OVER(PARTITION BY custid
	  ORDER BY val) AS rownum  -- non-deterministic query since ORDER BY list not unique
FROM Sales.OrderValues
ORDER BY custid, 
	    val;

SELECT orderid, 
	  custid, 
	  val, 
	  ROW_NUMBER() OVER(PARTITION BY custid
	  ORDER BY val, orderid) AS rownum  -- deterministic query since ORDER BY list unique
FROM Sales.OrderValues
ORDER BY custid, 
	    val;