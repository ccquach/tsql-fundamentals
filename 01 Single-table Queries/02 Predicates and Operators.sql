-- IN predicate
SELECT orderid, 
       empid, 
       orderdate
FROM Sales.Orders
WHERE orderid IN(10248, 10249, 10250);

-- BETWEEN predicate
SELECT orderid, 
       empid, 
       orderdate
FROM Sales.Orders
WHERE orderid BETWEEN 10300 AND 10310;

-- LIKE predicate
SELECT empid, 
       firstname, 
       lastname
FROM HR.Employees
WHERE lastname LIKE N'D%';

-- Comparison operators
SELECT orderid, 
       empid, 
       orderdate
FROM Sales.Orders
WHERE orderdate >= '20160101';

SELECT orderid, 
       empid, 
       orderdate
FROM Sales.Orders
WHERE orderdate >= '20160101'
      AND empid IN(1, 3, 5);

-- Arithmetic operators
SELECT orderid, 
       productid, 
       qty, 
       unitprice, 
       discount, 
       qty * unitprice * (1 - discount) AS val
FROM Sales.OrderDetails;

-- Operator precedence rules
SELECT orderid, 
       custid, 
       empid, 
       orderdate
FROM Sales.Orders
WHERE custid = 1
      AND empid IN(1, 3, 5)
OR custid = 85
AND empid IN(2, 4, 6);

SELECT orderid, 
       custid, 
       empid, 
       orderdate
FROM Sales.Orders
WHERE(custid = 1
      AND empid IN(1, 3, 5))
OR (custid = 85
    AND empid IN(2, 4, 6));