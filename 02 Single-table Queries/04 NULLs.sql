/* Sales.Customers contains 91 records */

-- Get all customers from region WA (returns 3 records)
SELECT custid
     , country
     , region
     , city
FROM Sales.Customers
WHERE region = N'WA';

-- Get all customers NOT from region WA (returns 28 records, not 88 = 91 - 3, since query filter "accept true" discards unknowns (NULLs)
SELECT custid
     , country
     , region
     , city
FROM Sales.Customers
WHERE region != N'WA';

-- Can NOT make equality comparisons against NULL, since can't compare something to missing value (returns empty set)
SELECT custid
     , country
     , region
     , city
FROM Sales.Customers
WHERE region = NULL;

-- Get all customers where region is NULL (returns 60 records)
SELECT custid
     , country
     , region
     , city
FROM Sales.Customers
WHERE region IS NULL;

-- Get all customers where region is different from WA (returns 88 records)
SELECT custid
     , country
     , region
     , city
FROM Sales.Customers
WHERE region != N'WA'
      OR region IS NULL;