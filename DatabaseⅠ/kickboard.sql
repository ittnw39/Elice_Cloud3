-- 데이터 베이스 생성
CREATE DATABASE kickboard;

-- 테이블 생성
CREATE TABLE customer(
    customer_number VARCHAR(10) PRIMARY KEY,
    name VARCHAR(10) NOT NULL,
    id VARCHAR(15) NOT NULL UNIQUE,
    pw VARCHAR(20) NOT NULL,
    phone_number VARCHAR(11),
    birth_date DATE
);

CREATE TABLE brand(
    brand_number INT PRIMARY KEY,
    name VARCHAR(20) NOT NULL UNIQUE,
    company VARCHAR(20) NOT NULL
);

CREATE TABLE kickboard(
    id VARCHAR(4) PRIMARY KEY,
    brand_number INT NOT NULL,
    model_year INT NOT NULL,
    basic_price INT NOT NULL,
    price_per_minute INT NOT NULL,
    FOREIGN KEY (brand_number) REFERENCES brand(brand_number)
);

CREATE TABLE borrow(
    customer_number VARCHAR(10),
    rental_time DATETIME,
    lat_location FLOAT NOT NULL,
    lon_location FLOAT NOT NULL,
    rental_status ENUM('대여', '반납') NOT NULL,
    kickboard_id VARCHAR(4) NOT NULL,
    CONSTRAINT borrow_pk PRIMARY KEY (customer_number, rental_time),
    FOREIGN KEY (customer_number) REFERENCES customer(customer_number),
    FOREIGN KEY (kickboard_id) REFERENCES kickboard(id)
);

-- 데이터 삽입
INSERT INTO customer VALUES('0187642351', '김민준', 'kmax6', 'HASH-lui235dfi2', '08786173448', '1989-03-09');
INSERT INTO customer VALUES('0012616925', '이서연', 'flykite', 'HASH-u73ylz5jao', '21865059766', '1995-07-12');

INSERT INTO brand VALUES(100, 'boardkick', 'elice');
INSERT INTO brand VALUES(200, 'willgo', 'everythere');
INSERT INTO brand VALUES(201, 'fastgoing', 'everythere');

INSERT INTO kickboard VALUES('7YWC', 100, 2015, 1000, 100);
INSERT INTO kickboard VALUES('54JP', 100, 2015, 1000, 100);
INSERT INTO kickboard VALUES('672Z', 200, 2018, 950, 110);
INSERT INTO kickboard VALUES('7L3D', 100, 2018, 1050, 100);

INSERT INTO borrow VALUES('0187642351', '2020-08-20 13:01:02', 37.514194, 127.065038, '대여', '7YWC');
INSERT INTO borrow VALUES('0187642351', '2020-08-20 13:12:32', 37.5141, 127.0600, '반납', '7YWC');
INSERT INTO borrow VALUES('0187642351', '2020-09-01 20:39:52', 37.4664, 126.931, '대여', '672Z');
INSERT INTO borrow VALUES('0187642351', '2020-09-01 20:48:55', 37.4694, 126.9449, '반납', '672Z');
INSERT INTO borrow VALUES('0012616925', '2020-11-11 22:01:30', 36.6638, 127.5013, '대여', '7L3D');
INSERT INTO borrow VALUES('0012616925', '2020-11-11 22:16:50', 36.6372, 127.4904, '반납', '7L3D');

SELECT * FROM customer;

-- 모든 회원 데이터를 대여 이력과 함께 출력

SELECT * FROM customer c
LEFT JOIN borrow b
ON c.customer_number = b.customer_number;

-- elice 회사가 보유한 킥보드 정보를 출력

SELECT * FROM kickboard k
INNER JOIN brand b
ON b.company = 'elice'
AND k.brand_number = b.brand_number;

-- flykite 회원이 2020-11-11 22:01:30에 대여해서 2020-11-11 22:16:50에 반납한 킥보드 이용료를 계산

SELECT TIMESTAMPDIFF(minute, '2020-11-11 22:01:30', '2020-11-11 22:16:50') * price_per_minute + basic_price AS price FROM customer c
INNER JOIN borrow b
ON c.id = 'flykite'
AND b.rental_time = '2020-11-11 22:01:30'
INNER JOIN kickboard k
ON b.kickboard_id = k.id;
-- TIMESTAMPDIFF()를 이용하면 시간의 차이를 계산할 수 있다.