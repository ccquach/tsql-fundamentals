-- Can NOT refer to column aliases assigned in the SELECT clause within the same SELECT clause
SELECT orderid
     , YEAR(orderdate) AS orderyear
     , orderyear + 1 AS nextyear
FROM Sales.Orders;