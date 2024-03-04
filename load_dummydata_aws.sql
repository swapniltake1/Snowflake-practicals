// Database to manage stage objects, fileformats etc.

CREATE OR REPLACE DATABASE Dummy;

CREATE OR REPLACE SCHEMA data;


// Creating external stage

CREATE OR REPLACE STAGE SwapnilDB.practice.aws_stage
    url='s3://test-bucket15485'
    credentials=(aws_key_id='' aws_secret_key='');


// Description of external stage

DESC STAGE SwapnilDB.practice.aws_stage; 
    
    
// Alter external stage   

-- ALTER STAGE aws_stage
    -- SET credentials=(aws_key_id='XYZ_DUMMY_ID' aws_secret_key='987xyz');
    
    
// Publicly accessible staging area    

-- CREATE OR REPLACE STAGE MANAGE_DB.external_stages.aws_stage
    -- url='s3://bucketsnowflakes3';

// List files in stage

LIST @aws_stage;

//CREATE TABLE

CREATE OR REPLACE TABLE DUMMY 
(
emp_no number,
name text,
dept text
);

//Load data using copy command

COPY INTO SwapnilDB.practice.dummy
    FROM @aws_stage
    file_format= (type = csv field_delimiter=',' skip_header=1)
    pattern='.*dummy_data.*'
    ;

select * from dummy;





openssl genrsa 2048 | openssl pkcs8 -topk8 -inform PEM -out rsa_key.p8 -nocrypt