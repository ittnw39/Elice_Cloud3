CREATE DATABASE devskill;
SHOW DATABASES;
CREATE USER elicer@localhost IDENTIFIED BY 'devpassword';
GRANT ALL PRIVILEGES ON devskill.* TO 유저이름@localhost;
FLUSH PRIVILEGES;
SHOW GRANTS FOR elicer@localhost;