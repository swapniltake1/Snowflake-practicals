-- Create a table called "company_employees"
CREATE TABLE company_employees (
    employee_id INT AUTOINCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(100),
    position VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(15),
    hire_date DATE,
    salary DECIMAL(10, 2),
    address VARCHAR(255)
);

-- Insert 10,000 records into the table
INSERT INTO company_employees (first_name, last_name, department, position, email, phone, hire_date, salary, address)
SELECT
    'First' || SEQ4(), -- Generates a unique first name for each record
    'Last' || SEQ4(), -- Generates a unique last name for each record
    'Department ' || (SEQ4() % 10 + 1), -- Generates a department for each record (10 departments)
    'Position ' || (SEQ4() % 5 + 1), -- Generates a position for each record (5 positions)
    'employee' || SEQ4() || '@csepvtltd.com', -- Generates a unique email for each record
    '1234567890', -- Sample phone number
    CURRENT_DATE - (SEQ4() % 3650), -- Generates a hire date within the last 10 years
    (SEQ4() % 5000 + 50000)::DECIMAL(10,2), -- Generates a salary between $50,000 and $99,999
    'Address ' || SEQ4() -- Generates a unique address for each record
FROM TABLE(GENERATOR(ROWCOUNT => 10000));


-- get all records 
select * from company_employees;
