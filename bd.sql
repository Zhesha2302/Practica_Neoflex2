-- Создаем базу данных
CREATE DATABASE carsharing;

-- Звезда
USE carsharing;

-- Таблица измерений: Автомобили
CREATE TABLE dim_car (
    car_key INT,
    brand STRING,
    model STRING,
    car_class STRING, 
    fuel_type STRING,  
    license_plate STRING
)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY ',' 
STORED AS TEXTFILE;

-- Заполняем таблицу
INSERT INTO dim_car VALUES
(1, 'Hyundai', 'Solaris', 'economy', 'petrol', 'А123ВВ777'),
(2, 'Kia', 'Rio', 'economy', 'petrol', 'В456АА777'),
(3, 'Toyota', 'Camry', 'comfort', 'petrol', 'С789ВВ777'),
(4, 'BMW', 'X5', 'business', 'diesel', 'Е012ХХ777'),
(5, 'Tesla', 'Model 3', 'business', 'electric', 'Н345НН777');

-- Таблица измерений: Клиенты
CREATE TABLE dim_customer (
    customer_key INT,
    name STRING,
    age INT,
    gender STRING,
    membership_type STRING,  
    registration_date STRING
)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY ',' 
STORED AS TEXTFILE;

INSERT INTO dim_customer VALUES
(101, 'Иван Петров', 28, 'M', 'gold', '2024-01-15'),
(102, 'Елена Смирнова', 32, 'F', 'platinum', '2023-11-20'),
(103, 'Алексей Иванов', 25, 'M', 'basic', '2024-05-10'),
(104, 'Ольга Козлова', 41, 'F', 'gold', '2023-08-05'),
(105, 'Дмитрий Сидоров', 35, 'M', 'basic', '2024-02-28');

-- Таблица измерений: Локации
CREATE TABLE dim_location (
    location_key INT,
    city STRING,
    district STRING,
    zone_type STRING  
)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY ',' 
STORED AS TEXTFILE;

INSERT INTO dim_location VALUES
(201, 'Москва', 'ЦАО', 'center'),
(202, 'Москва', 'ЗАО', 'residential'),
(203, 'Москва', 'ЮАО', 'residential'),
(204, 'Москва', 'САО', 'business_district'),
(205, 'СПб', 'Центральный', 'center'),
(206, 'СПб', 'Василеостровский', 'residential');

-- Таблица измерений: Дата
CREATE TABLE dim_date (
    date_key INT,
    date_value STRING,
    year INT,
    month INT,
    day_of_week STRING,
    is_weekend BOOLEAN
)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY ',' 
STORED AS TEXTFILE;

INSERT INTO dim_date VALUES
(20241001, '2024-10-01', 2024, 10, 'Tuesday', FALSE),
(20241002, '2024-10-02', 2024, 10, 'Wednesday', FALSE),
(20241003, '2024-10-03', 2024, 10, 'Thursday', FALSE),
(20241004, '2024-10-04', 2024, 10, 'Friday', FALSE),
(20241005, '2024-10-05', 2024, 10, 'Saturday', TRUE),
(20241006, '2024-10-06', 2024, 10, 'Sunday', TRUE),
(20241007, '2024-10-07', 2024, 10, 'Monday', FALSE);

-- Таблица фактов: Поездки
CREATE TABLE fact_trips (
    trip_key INT,
    customer_key INT,
    car_key INT,
    location_key INT,
    date_key INT,
    duration_min INT,
    distance_km FLOAT,
    trip_cost FLOAT,
    rating INT  
)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY ',' 
STORED AS TEXTFILE;

INSERT INTO fact_trips VALUES
(10001, 101, 1, 201, 20241001, 45, 15.2, 450.50, 5),
(10002, 102, 3, 204, 20241001, 30, 8.5, 380.00, 4),
(10003, 103, 2, 202, 20241002, 120, 35.7, 1200.00, 5),
(10004, 101, 4, 205, 20241003, 25, 6.3, 350.00, 3),
(10005, 104, 5, 206, 20241005, 60, 22.1, 890.00, 5),
(10006, 105, 1, 203, 20241005, 15, 3.5, 180.00, 4),
(10007, 102, 3, 201, 20241006, 90, 28.4, 1150.00, 5),
(10008, 103, 2, 204, 20241007, 40, 12.8, 520.00, 4);


-- Снежинка
USE carsharing;

-- Справочник классов автомобилей
CREATE TABLE dim_car_class (
    class_key INT,
    class_name STRING,
    base_rate FLOAT,  
    description STRING
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE;

INSERT INTO dim_car_class VALUES
(10, 'economy', 8.5, 'Эконом-класс, доступные автомобили'),
(20, 'comfort', 12.0, 'Комфорт-класс, более просторные авто'),
(30, 'business', 18.5, 'Бизнес-класс, премиальные автомобили');

-- Справочник типов топлива
CREATE TABLE dim_fuel_type (
    fuel_key INT,
    fuel_name STRING,
    eco_rating INT  
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE;

INSERT INTO dim_fuel_type VALUES
(1, 'petrol', 5),
(2, 'diesel', 4),
(3, 'electric', 10),
(4, 'hybrid', 9);

-- Справочник зон города
CREATE TABLE dim_zone_type (
    zone_key INT,
    zone_name STRING,
    parking_rate FLOAT  
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE;

INSERT INTO dim_zone_type VALUES
(100, 'center', 50.0),
(200, 'residential', 0.0),
(300, 'business_district', 30.0),
(400, 'suburb', 0.0);

-- Таблица измерений: Автомобили
CREATE TABLE dim_car_snow (
    car_key INT,
    brand STRING,
    model STRING,
    class_key INT,      
    fuel_key INT,       
    license_plate STRING
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE;

INSERT INTO dim_car_snow VALUES
(1, 'Hyundai', 'Solaris', 10, 1, 'А123ВВ777'),
(2, 'Kia', 'Rio', 10, 1, 'В456АА777'),
(3, 'Toyota', 'Camry', 20, 1, 'С789ВВ777'),
(4, 'BMW', 'X5', 30, 2, 'Е012ХХ777'),
(5, 'Tesla', 'Model 3', 30, 3, 'Н345НН777');

-- Таблица измерений: Локации 
CREATE TABLE dim_location_snow (
    location_key INT,
    city STRING,
    district STRING,
    zone_key INT  
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE;

INSERT INTO dim_location_snow VALUES
(201, 'Москва', 'ЦАО', 100),
(202, 'Москва', 'ЗАО', 200),
(203, 'Москва', 'ЮАО', 200),
(204, 'Москва', 'САО', 300),
(205, 'СПб', 'Центральный', 100),
(206, 'СПб', 'Василеостровский', 200);

-- Таблица фактов остается той же
CREATE TABLE fact_trips_snow LIKE fact_trips;

-- Data Vault
USE carsharing;

-- Включаем поддержку транзакций 
SET hive.support.concurrency=true;
SET hive.enforce.bucketing=true;
SET hive.exec.dynamic.partition.mode=nonstrict;
SET hive.txn.manager=org.apache.hadoop.hive.ql.lockmgr.DbTxnManager;

-- ХАБ: Клиенты
CREATE TABLE hub_customer (
    customer_hash STRING,
    customer_id INT,
    load_date TIMESTAMP,
    record_source STRING
)
CLUSTERED BY (customer_hash) INTO 4 BUCKETS
STORED AS ORC
TBLPROPERTIES ('transactional'='true');

-- ХАБ: Автомобили
CREATE TABLE hub_car (
    car_hash STRING,
    car_id INT,
    load_date TIMESTAMP,
    record_source STRING
)
CLUSTERED BY (car_hash) INTO 4 BUCKETS
STORED AS ORC
TBLPROPERTIES ('transactional'='true');

-- ХАБ: Локации
CREATE TABLE hub_location (
    location_hash STRING,
    location_id INT,
    load_date TIMESTAMP,
    record_source STRING
)
CLUSTERED BY (location_hash) INTO 4 BUCKETS
STORED AS ORC
TBLPROPERTIES ('transactional'='true');

-- ХАБ: Дата
CREATE TABLE hub_date (
    date_hash STRING,
    date_id INT,
    load_date TIMESTAMP,
    record_source STRING
)
CLUSTERED BY (date_hash) INTO 4 BUCKETS
STORED AS ORC
TBLPROPERTIES ('transactional'='true');

-- ЛИНК: Поездка
CREATE TABLE link_trip (
    trip_hash STRING,
    customer_hash STRING,
    car_hash STRING,
    location_hash STRING,
    date_hash STRING,
    load_date TIMESTAMP,
    record_source STRING
)
CLUSTERED BY (trip_hash) INTO 4 BUCKETS
STORED AS ORC
TBLPROPERTIES ('transactional'='true');

-- СПУТНИК: Детали клиента
CREATE TABLE sat_customer_details (
    customer_hash STRING,
    load_date TIMESTAMP,
    name STRING,
    age INT,
    gender STRING,
    membership_type STRING,
    registration_date STRING,
    record_source STRING
)
CLUSTERED BY (customer_hash) INTO 4 BUCKETS
STORED AS ORC
TBLPROPERTIES ('transactional'='true');

-- СПУТНИК: Детали автомобиля
CREATE TABLE sat_car_details (
    car_hash STRING,
    load_date TIMESTAMP,
    brand STRING,
    model STRING,
    car_class STRING,
    fuel_type STRING,
    license_plate STRING,
    record_source STRING
)
CLUSTERED BY (car_hash) INTO 4 BUCKETS
STORED AS ORC
TBLPROPERTIES ('transactional'='true');

-- СПУТНИК: Детали локации
CREATE TABLE sat_location_details (
    location_hash STRING,
    load_date TIMESTAMP,
    city STRING,
    district STRING,
    zone_type STRING,
    record_source STRING
)
CLUSTERED BY (location_hash) INTO 4 BUCKETS
STORED AS ORC
TBLPROPERTIES ('transactional'='true');

-- СПУТНИК: Детали поездки
CREATE TABLE sat_trip_details (
    trip_hash STRING,
    load_date TIMESTAMP,
    duration_min INT,
    distance_km FLOAT,
    trip_cost FLOAT,
    rating INT,
    record_source STRING
)
CLUSTERED BY (trip_hash) INTO 4 BUCKETS
STORED AS ORC
TBLPROPERTIES ('transactional'='true');

-- ХАБ: Клиенты 
INSERT INTO hub_customer
SELECT 
    sha2(CONCAT_WS('|', 'customer', CAST(customer_key AS STRING)), 256) as customer_hash,
    customer_key as customer_id,
    current_timestamp() as load_date,
    'dim_customer' as record_source
FROM dim_customer;

-- ХАБ: Автомобили 
INSERT INTO hub_car
SELECT 
    sha2(CONCAT_WS('|', 'car', CAST(car_key AS STRING)), 256) as car_hash,
    car_key as car_id,
    current_timestamp() as load_date,
    'dim_car' as record_source
FROM dim_car;

-- ХАБ: Локации 
INSERT INTO hub_location
SELECT 
    sha2(CONCAT_WS('|', 'location', CAST(location_key AS STRING)), 256) as location_hash,
    location_key as location_id,
    current_timestamp() as load_date,
    'dim_location' as record_source
FROM dim_location;

-- ХАБ: Дата 
INSERT INTO hub_date
SELECT 
    sha2(CONCAT_WS('|', 'date', CAST(date_key AS STRING)), 256) as date_hash,
    date_key as date_id,
    current_timestamp() as load_date,
    'dim_date' as record_source
FROM dim_date;

-- ЛИНК: Поездка 
INSERT INTO link_trip
SELECT 
    sha2(CONCAT_WS('|', 'trip', CAST(ft.trip_key AS STRING)), 256) as trip_hash,
    hc.customer_hash,
    hca.car_hash,
    hl.location_hash,
    hd.date_hash,
    current_timestamp() as load_date,
    'fact_trips' as record_source
FROM fact_trips ft
JOIN hub_customer hc ON sha2(CONCAT_WS('|', 'customer', CAST(ft.customer_key AS STRING)), 256) = hc.customer_hash
JOIN hub_car hca ON sha2(CONCAT_WS('|', 'car', CAST(ft.car_key AS STRING)), 256) = hca.car_hash
JOIN hub_location hl ON sha2(CONCAT_WS('|', 'location', CAST(ft.location_key AS STRING)), 256) = hl.location_hash
JOIN hub_date hd ON sha2(CONCAT_WS('|', 'date', CAST(ft.date_key AS STRING)), 256) = hd.date_hash;

-- СПУТНИК: Детали клиента 
INSERT INTO sat_customer_details
SELECT 
    sha2(CONCAT_WS('|', 'customer', CAST(customer_key AS STRING)), 256) as customer_hash,
    current_timestamp() as load_date,
    name,
    age,
    gender,
    membership_type,
    registration_date,
    'dim_customer' as record_source
FROM dim_customer;

-- СПУТНИК: Детали автомобиля 
INSERT INTO sat_car_details
SELECT 
    sha2(CONCAT_WS('|', 'car', CAST(car_key AS STRING)), 256) as car_hash,
    current_timestamp() as load_date,
    brand,
    model,
    car_class,
    fuel_type,
    license_plate,
    'dim_car' as record_source
FROM dim_car;

-- СПУТНИК: Детали локации 
INSERT INTO sat_location_details
SELECT 
    sha2(CONCAT_WS('|', 'location', CAST(location_key AS STRING)), 256) as location_hash,
    current_timestamp() as load_date,
    city,
    district,
    zone_type,
    'dim_location' as record_source
FROM dim_location;

-- СПУТНИК: Детали поездки 
INSERT INTO sat_trip_details
SELECT 
    sha2(CONCAT_WS('|', 'trip', CAST(trip_key AS STRING)), 256) as trip_hash,
    current_timestamp() as load_date,
    duration_min,
    distance_km,
    trip_cost,
    rating,
    'fact_trips' as record_source
FROM fact_trips;




