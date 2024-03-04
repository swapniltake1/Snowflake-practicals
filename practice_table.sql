-- Create a table called "practice_table"
CREATE TABLE practice_table (
    id INT,
    name VARCHAR,
    age INT
);

-- Insert multiple records into the table
INSERT INTO practice_table (id, name, age)
VALUES
    (1, 'John', 30),
    (2, 'Alice', 25),
    (3, 'Bob', 35),
    (4, 'Emily', 28),
    (5, 'Michael', 40);

-- Get all details

select * from practice_table;
