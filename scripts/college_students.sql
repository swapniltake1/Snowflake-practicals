-- Create a table called "college_students"
CREATE TABLE college_students (
    student_id INT AUTOINCREMENT PRIMARY KEY,
    name VARCHAR(100),
    address VARCHAR(255),
    phone VARCHAR(15),
    email VARCHAR(100),
    class VARCHAR(50)
);

-- Insert 100 records into the table
INSERT INTO college_students (name, address, phone, email, class)
SELECT
    'Student ' || SEQ4(), -- Generates a unique student name for each record
    'Address ' || SEQ4(), -- Generates a unique address for each record
    '1234567890', -- Sample phone number
    'student' || SEQ4() || '@college.edu', -- Generates a unique email for each record
    'Class ' || SEQ4() -- Generates a class for each record
FROM TABLE(GENERATOR(ROWCOUNT => 100));

-- get all records
select * from college_students;

-- get one student from db
select * from college_students where student_id=86
