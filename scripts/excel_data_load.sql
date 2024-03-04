create OR REPLACE database exceldata;

CREATE OR REPLACE STAGE exceldata.public.aws_stage_load
url='s3://test-bucket15485'
credentials=(aws_key_id='' aws_secret_key='');

-- list @aws_stage_load;

CREATE OR REPLACE TABLE public.customer (
    customer_id integer NOT NULL,
    store_id smallint NOT NULL,
    first_name text NOT NULL,
    last_name text NOT NULL,
    email text,
    address_id smallint NOT NULL,
    activebool boolean DEFAULT true NOT NULL,
    create_date date ,
    last_update timestamp_ntz,
    active integer
);

COPY INTO PUBLIC.customer
    FROM @aws_stage_load
    file_format= (type = csv field_delimiter=',' skip_header=1
    FIELD_OPTIONALLY_ENCLOSED_BY='"')
    pattern='.*customer.*';
-- select * from customer;

CREATE OR REPLACE TABLE public.film (
    film_id integer NOT NULL,
    title text NOT NULL,
    description text,
    release_year varchar,
    language_id smallint NOT NULL,
    original_language_id varchar,
    rental_duration smallint DEFAULT 3 NOT NULL,
    rental_rate numeric(4,2) DEFAULT 4.99 NOT NULL,
    length smallint,
    replacement_cost numeric(5,2) DEFAULT 19.99 NOT NULL,
    rating  varchar,
    last_update timestamp_ntz,
    special_features text,
    fulltext varchar NOT NULL
);

COPY INTO PUBLIC.film
    FROM @aws_stage_load
    file_format= (type = csv field_delimiter=',' skip_header=1
    FIELD_OPTIONALLY_ENCLOSED_BY='"')
    pattern='.*film.csv';

-- select * from film;


CREATE OR REPLACE TABLE public.film_actor (
    actor_id smallint NOT NULL,
    film_id smallint NOT NULL,
    last_update timestamp_ntz NOT NULL
);
    
COPY INTO PUBLIC.film_actor
    FROM @aws_stage_load
    file_format= (type = csv field_delimiter=',' skip_header=1
    FIELD_OPTIONALLY_ENCLOSED_BY='"')
    pattern='.*film_actor.csv';

-- select * from public.film_actor;

CREATE OR REPLACE TABLE public.film_category (
    film_id smallint NOT NULL,
    category_id smallint NOT NULL,
    last_update timestamp_ntz NOT NULL
);
COPY INTO PUBLIC.film_category
    FROM @aws_stage_load
    file_format= (type = csv field_delimiter=',' skip_header=1
    FIELD_OPTIONALLY_ENCLOSED_BY='"')
    pattern='.*film_category.csv';

    -- select * from film_category;
CREATE OR REPLACE TABLE public.address (
    address_id integer  NOT NULL,
    address text NOT NULL,
    address2 text,
    district text NOT NULL,
    city_id smallint NOT NULL,
    postal_code text,
    phone text NOT NULL,
    last_update timestamp_ntz NOT NULL
);
COPY INTO PUBLIC.address
    FROM @aws_stage_load
    file_format= (type = csv field_delimiter=',' skip_header=1
    FIELD_OPTIONALLY_ENCLOSED_BY='"')
    pattern='.*address.csv';

    -- select * from address;

CREATE OR REPLACE TABLE public.city (
    city_id integer NOT NULL,
    city text NOT NULL,
    country_id smallint NOT NULL,
    last_update timestamp_ntz NOT NULL
);
COPY INTO PUBLIC.city
    FROM @aws_stage_load
    file_format= (type = csv field_delimiter=',' skip_header=1
    FIELD_OPTIONALLY_ENCLOSED_BY='"')
    pattern='city.csv';

-- select * from city;

CREATE OR REPLACE TABLE public.inventory (
    inventory_id integer  NOT NULL,
    film_id smallint NOT NULL,
    store_id smallint NOT NULL,
    last_update timestamp_ntz NOT NULL
);

COPY INTO PUBLIC.inventory
    FROM @aws_stage_load
    file_format= (type = csv field_delimiter=',' skip_header=1
    FIELD_OPTIONALLY_ENCLOSED_BY='"')
    pattern='.*inventory.csv';

    -- select * from inventory;

    CREATE OR REPLACE TABLE public.payment (
    payment_id integer NOT NULL,
    customer_id smallint NOT NULL,
    staff_id smallint NOT NULL,
    rental_id integer NOT NULL,
    amount numeric(5,2) NOT NULL,
    payment_date timestamp_ntz NOT NULL
);

COPY INTO PUBLIC.payment
    FROM @aws_stage_load
    file_format= (type = csv field_delimiter=',' skip_header=1
    FIELD_OPTIONALLY_ENCLOSED_BY='"')
    pattern='.*payment.csv';
-- select * from payment;
CREATE or replace TABLE public.rental (
    rental_id integer NOT NULL,
    rental_date timestamp with time zone NOT NULL,
    inventory_id integer NOT NULL,
    customer_id smallint NOT NULL,
    return_date varchar ,
    staff_id smallint NOT NULL,
    last_update timestamp_ntz NOT NULL
);


COPY INTO PUBLIC.rental
    FROM @aws_stage_load
    file_format= (type = csv field_delimiter=',' skip_header=1
    FIELD_OPTIONALLY_ENCLOSED_BY='"')
    pattern='.*rental.csv';

    -- select * from rental;

    CREATE OR REPLACE TABLE public.staff (
    staff_id integer NOT NULL,
    first_name text NOT NULL,
    last_name text NOT NULL,
    address_id smallint NOT NULL,
    email text,
    store_id smallint NOT NULL,
    active boolean DEFAULT true NOT NULL,
    username text NOT NULL,
    password text,
    last_update timestamp_ntz NOT NULL,
    picture varchar
);


COPY INTO PUBLIC.staff
    FROM @aws_stage_load
    file_format= (type = csv field_delimiter=',' skip_header=1
    FIELD_OPTIONALLY_ENCLOSED_BY='"')
    pattern='.*staff.csv';

    -- select * from staff;

CREATE OR REPLACE TABLE public.store (
    store_id integer NOT NULL,
    manager_staff_id smallint NOT NULL,
    address_id smallint NOT NULL,
    last_update timestamp_ntz NOT NULL
);


COPY INTO PUBLIC.store
    FROM @aws_stage_load
    file_format= (type = csv field_delimiter=',' skip_header=1
    FIELD_OPTIONALLY_ENCLOSED_BY='"')
    pattern='.*store.csv';

    -- select * from store;



CREATE OR REPLACE TABLE public.actor (
    actor_id integer NOT NULL,
    first_name text NOT NULL,
    last_name text NOT NULL,
    last_update timestamp_ntz NOT NULL
);

COPY INTO PUBLIC.actor
    FROM @aws_stage_load
    file_format= (type = csv field_delimiter=',' skip_header=1
    FIELD_OPTIONALLY_ENCLOSED_BY='"')
    pattern='actor.csv';

    -- select * from actor;

    CREATE OR REPLACE TABLE public.category (
    category_id integer NOT NULL,
    name text NOT NULL,
    last_update timestamp_ntz NOT NULL
);


COPY INTO PUBLIC.category
    FROM @aws_stage_load
    file_format= (type = csv field_delimiter=',' skip_header=1
    FIELD_OPTIONALLY_ENCLOSED_BY='"')
    pattern='category.csv';

select * from category;
CREATE OR REPLACE TABLE public.country (
    country_id integer NOT NULL,
    country text NOT NULL,
    last_update timestamp_ntz NOT NulL
);

COPY INTO PUBLIC.country
    FROM @aws_stage_load
    file_format= (type = csv field_delimiter=',' skip_header=1
    FIELD_OPTIONALLY_ENCLOSED_BY='"')
    pattern='country.csv';

-- select * from country;

CREATE OR REPLACE TABLE public.language (
    language_id integer NOT NULL,
    name character(20) NOT NULL,
    last_update timestamp_ntz NOT NULL
);

COPY INTO PUBLIC.language
    FROM @aws_stage_load
    file_format= (type = csv field_delimiter=',' skip_header=1
    FIELD_OPTIONALLY_ENCLOSED_BY='"')
    pattern='language.csv';

-- select * from language;

CREATE OR REPLACE TABLE aircrafts_data (
    aircraft_code character(3) NOT NULL,
    model variant NOT NULL,
    range integer NOT NULL

);

COPY INTO PUBLIC.aircrafts_data
    FROM @aws_stage_load
    file_format= (type = csv field_delimiter=',' skip_header=1
    FIELD_OPTIONALLY_ENCLOSED_BY='"')
    pattern='aircrafts_data.csv';

--select * from aircrafts_data;

CREATE or replace TABLE airports_data (
    airport_code character(3) NOT NULL,
    airport_name variant NOT NULL,
    city variant NOT NULL,
    coordinates varchar NOT NULL,
    timezone text NOT NULL
);

COPY INTO PUBLIC.airports_data
    FROM @aws_stage_load
    file_format= (type = csv field_delimiter=',' skip_header=1
    FIELD_OPTIONALLY_ENCLOSED_BY='"')
    pattern='airports_data.csv';

--select * from airports_data;

CREATE or replace TABLE boarding_passes (
    ticket_no character(13) NOT NULL,
    flight_id integer NOT NULL,
    boarding_no integer NOT NULL,
    seat_no VARCHAR NOT NULL
);

COPY INTO PUBLIC.boarding_passes
    FROM @aws_stage_load
    file_format= (type = csv field_delimiter=',' skip_header=1
    FIELD_OPTIONALLY_ENCLOSED_BY='"')
    pattern='boarding_passes.csv';

-- SELECT * FROM BOAR    DING_PASSES LIMIT 100;

CREATE or replace TABLE bookings (
    book_ref character(6) NOT NULL,
    book_date timestamp_NTZ NOT NULL,
    total_amount numeric(10,2) NOT NULL
);

COPY INTO PUBLIC.bookings
    FROM @aws_stage_load
    file_format= (type = csv field_delimiter=',' skip_header=1
    FIELD_OPTIONALLY_ENCLOSED_BY='"')
    pattern='bookings.csv';

-- SELECT * FROM BOOKINGS;

CREATE OR replace TABLE flights (
    flight_id integer NOT NULL,
    flight_no character(6) NOT NULL,
    scheduled_departure timestamp_NTZ,
    scheduled_arrival timestamp_NTZ,
    departure_airport character(3) NOT NULL,
    arrival_airport character(3) NOT NULL,
    status character varying(20) NOT NULL,
    aircraft_code character(3) NOT NULL,
    actual_departure varchar,
    actual_arrival varchar
   
);

COPY INTO PUBLIC.flights
    FROM @aws_stage_load
    file_format= (type = csv field_delimiter=',' skip_header=1
    FIELD_OPTIONALLY_ENCLOSED_BY='"')
    pattern='flights.csv';
-- select * from flights;

CREATE OR REPLACE TABLE seats (
    aircraft_code character(3) NOT NULL,
    seat_no character varying(4) NOT NULL,
    fare_conditions character varying(10) NOT NULL
    
);

COPY INTO PUBLIC.seats
    FROM @aws_stage_load
    file_format= (type = csv field_delimiter=',' skip_header=1
    FIELD_OPTIONALLY_ENCLOSED_BY='"')
    pattern='seats.csv';

-- select * from seats;

CREATE OR REPLACE TABLE ticket_flights (
    ticket_no character(13) NOT NULL,
    flight_id integer NOT NULL,
    fare_conditions character varying(10) NOT NULL,
    amount numeric(10,2) NOT NULL
    
);
COPY INTO PUBLIC.ticket_flights
    FROM @aws_stage_load
    file_format= (type = csv field_delimiter=',' skip_header=1
    FIELD_OPTIONALLY_ENCLOSED_BY='"')
    pattern='ticket_flights.csv';

-- select * from ticket_flights;
CREATE OR REPLACE TABLE tickets (
    ticket_no character(13) NOT NULL,
    book_ref character(6) NOT NULL,
    passenger_id character varying(20) NOT NULL,
    passenger_name text NOT NULL,
    contact_data variant
);
COPY INTO PUBLIC.tickets
    FROM @aws_stage_load
    file_format= (type = csv field_delimiter=',' skip_header=1
    FIELD_OPTIONALLY_ENCLOSED_BY='"')
    pattern='tickets.csv';


-- select * from tickets;

