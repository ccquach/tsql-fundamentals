/* Collation */

-- Get supported collations and their descriptions
SELECT name
     , description
FROM sys.fn_helpcollations();

-- Convert collation of an expression
SELECT empid
     , firstname
     , lastname
FROM HR.Employees
WHERE lastname = N'davis';	-- default database collation is case INSENSITIVE

SELECT empid
     , firstname
     , lastname
FROM HR.Employees
WHERE lastname COLLATE Latin1_General_CS_AS = N'davis';	-- returns empty set when case SENSITIVE comparison



/* Operators and functions */

-- Concatenate with plus-sign (+) operator
SELECT empid
     , firstname + N' ' + lastname AS fullname
FROM HR.Employees;

-- Concatenation with NULL yields NULL
SELECT custid
     , country
     , region
     , city
     , country + N', ' + region + N', ' + city AS location
FROM Sales.Customers;

SELECT custid
     , country
     , region
     , city
     , country + COALESCE(N', ' + region, N'') + N', ' + city AS location
FROM Sales.Customers;

-- Concatenation using CONCAT function
SELECT custid
     , country
     , region
     , city
     , CONCAT(country, N', ' + region, N', ' + city) AS location
FROM Sales.Customers;


-- SUBSTRING function
SELECT SUBSTRING('abcde', 1, 3);

-- LEFT and RIGHT functions
SELECT LEFT('abcde', 3);
SELECT RIGHT('abcde', 3);

-- LEN and DATALENGTH functions
SELECT LEN(N'abcde  ');	-- EXCLUDES trailing blanks, so returns 5 (characters)
SELECT DATALENGTH(N'abcde  ');	-- INCLUDES trailing blanks, so returns 14 (bytes)

-- CHARINDEX function
SELECT CHARINDEX(' ', 'Itzik Ben-Gan');

-- PATINDEX function (pattern)
SELECT PATINDEX('%[0-9]%', 'abcd123efgh');

-- REPLACE function
SELECT REPLACE('1-a 2-b', '-', ':');

SELECT empid
     , lastname
     , LEN(lastname) - LEN(replace(lastname, 'e', '')) AS numoccur
FROM HR.Employees;

-- REPLICATE function
SELECT REPLICATE('abc', 3);

SELECT supplierid
     , RIGHT(REPLICATE('0', 9) + CAST(supplierid AS VARCHAR(10)), 10) AS strsupplierid
FROM Production.Suppliers;

-- STUFF function
SELECT STUFF('xyz', 2, 1, 'abc');

-- UPPER and LOWER functions
SELECT UPPER('Itzik Ben-Gan');
SELECT LOWER('Itzik Ben-Gan');

-- LTRIM and RTRIM functions
SELECT RTRIM(LTRIM('   abc   '));	-- remove both leading and trailing spaces

-- FORMAT function
SELECT format(1759, '0000000000');
SELECT format(1759, 'd10');

-- STRING_SPLIT function (SQL Server 2016)
SELECT CAST(value AS INT) AS myvalue
FROM STRING_SPLIT('10248,10249,10250', ',') AS S;




/* LIKE predicate */

-- % (percent) wildcard: represents string of any size, including empty string
SELECT empid
     , lastname
FROM HR.Employees
WHERE lastname LIKE N'D%';	-- starts with 'D'

-- _ (underscore) wildcard: represents single character
SELECT empid
     , lastname
FROM HR.Employees
WHERE lastname LIKE N'_e%';	-- second letter is 'e'

-- [] (list of characters) wildcard
SELECT empid
     , lastname
FROM HR.Employees
WHERE lastname LIKE N'[ABC]%';

-- [<char>-<char>] (range of characters) wildcard
SELECT empid
     , lastname
FROM HR.Employees
WHERE lastname LIKE N'[A-E]%';

-- [^<char list or range>] (not specified char) wildcard
SELECT empid
     , lastname
FROM HR.Employees
WHERE lastname LIKE N'[^A-E]%';