DROP TABLE IF EXISTS services CASCADE ;
CREATE TABLE services (
serv_code VARCHAR(20)  NOT NULL,
serv_name VARCHAR(50),
CONSTRAINT pk_services PRIMARY KEY (serv_code)
);
