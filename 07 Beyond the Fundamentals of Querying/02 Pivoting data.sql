-- Get total order quantity for each employee and customer
SELECT empid
     , custid
     , SUM(qty) AS sumqty
FROM dbo.Orders
GROUP BY empid
       , custid;

-- Pivoting with a grouped query
SELECT empid
     , SUM(CASE WHEN custid = 'A' THEN qty END) AS A
     , SUM(CASE WHEN custid = 'B' THEN qty END) AS B
     , SUM(CASE WHEN custid = 'C' THEN qty END) AS C
     , SUM(CASE WHEN custid = 'D' THEN qty END) AS D
FROM dbo.Orders
GROUP BY empid;

-- Pivoting with the PIVOT operator
SELECT empid, A, B, C, D
FROM
(
    SELECT empid, custid, qty
    FROM dbo.Orders
) AS D PIVOT(SUM(qty) FOR custid IN(A, B, C, D)) AS P;

-- Pivoting with custid as grouping element and empid as spreading element
SELECT custid, [1], [2], [3]
FROM
(
    SELECT empid, custid, qty
    FROM dbo.Orders
) AS D PIVOT(SUM(qty) FOR empid IN([1], [2], [3])) AS P;