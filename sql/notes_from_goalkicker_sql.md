## SQL

- Structured Query Language (SQL) is a special-purpose programming language designed for managing data held in a Relational Database Management System (RDBMS).
- SQL comprises of 3 major sub-languages:
    - Data Definition Language (DDL): to create and modify the structure of the database;
    - Data Manipulation Language (DML): to perform Read, Insert, Update and Delete operations on the data of the database;
    - Data Control Language (DCL): to control the access of the data stored in the database.

- The core DML operations are Create, Read, Update and Delete (CRUD for short) which are performed by the statements INSERT , SELECT , UPDATE and DELETE .

___

&nbsp;

### Data Types

1) DECIMAL and NUMERIC
    - Fixed precision and scale decimal numbers. DECIMAL and NUMERIC are functionally equivalent.
    ```
    Syntax:
        DECIMAL ( precision [ , scale] )
        NUMERIC ( precision [ , scale] )

        Examples:
        SELECT CAST(123 AS DECIMAL(5,2)) --returns 123.00
        SELECT CAST(12345.12 AS NUMERIC(10,5)) --returns 12345.12000
    ```

2) FLOAT and REAL
    - Approximate-number data types for use with floating point numeric data.
    
    ```
    SELECT CAST( PI() AS FLOAT) --returns 3.14159265358979
    SELECT CAST( PI() AS REAL) --returns 3.141593
    ```

3) Integers
    - Exact-number data types that use integer data.
    bigint,int, smallint, tinyint

4) MONEY and SMALLMONEY
    - Data types that represent monetary or currency values.
    money, smallmoney

5) CHAR and VARCHAR
    - String data types of either fixed length or variable length.

    ```
        Syntax:
        CHAR [ ( n_chars ) ]
        VARCHAR [ ( n_chars ) ]

        Examples:
        SELECT CAST('ABC' AS CHAR(10)) -- 'ABC      '
        '(padded with spaces on the right)
        SELECT CAST('ABC' AS VARCHAR(10)) -- 'ABC' (no padding due to variable character)
        SELECT CAST('ABCDEFGHIJKLMNOPQRSTUVWXYZ' AS CHAR(10)) -- 'ABCDEFGHIJ' (truncated to 10 characters)
    ```


### NULL
- NULL in SQL, as well as programming in general, means literally "nothing". In SQL, it is easier to understand as "the absence of any value".
- It is important to distinguish it from seemingly empty values, such as the empty string '' or the number 0 , neither of which are actually NULL .
- It is also important to be careful not to enclose NULL in quotes, like 'NULL' , which is allowed in columns that accept text, but is not NULL and can          cause errors and incorrect data sets.

### Filtering for NULL in queries
- The syntax for filtering for NULL (i.e. the absence of a value) in WHERE blocks is slightly different than filtering for specific values.

    ```
    SELECT * FROM Employees WHERE ManagerId IS NULL ;
    SELECT * FROM Employees WHERE ManagerId IS NOT NULL ;
    ```

- Note that because NULL is not equal to anything, not even to itself, using equality operators = NULL or <> NULL (or != NULL ) will always yield the truth      value of UNKNOWN which will be rejected by WHERE .


### Nullable columns in tables
- When creating tables it is possible to declare a column as nullable or non-nullable.

    ```
    CREATE TABLE MyTable
    (
        Mycol1 INT NOT NULL,
        Mycol2 INT NULL 
    );
    ```

- By default every column (except those in primary key constraint) is nullable unless we explicitly set NOT NULL constraint. 
- Attempting to assign NULL to a non-nullable column will result in an error.
    ```
    INSERT INTO MyTable (MyCol1, MyCol2) VALUES (1, NULL) ; -- works fine
    INSERT INTO MyTable (MyCol1, MyCol2) VALUES (NULL, 2) ;
                                -- cannot insert
                                -- the value NULL into column 'MyCol1', table 'MyTable';
                                -- column does not allow nulls. INSERT fails.


### Updating fields to NULL
- Setting a field to NULL works exactly like with any other value:
    ```
        UPDATE Employees
        SET ManagerId = NULL
        WHERE Id = 4
    ```

### Inserting rows with NULL fields
- For example inserting an employee with no phone number and no manager into the Employees example table:

    ```
        INSERT INTO Employees
        (Id, FName, LName, PhoneNumber, ManagerId, DepartmentId, Salary, HireDate)
        VALUES
        (5, 'Jane', 'Doe', NULL, NULL, 2, 800, '2016-07-22') ;
    ```

### Example Databases and Tables





















