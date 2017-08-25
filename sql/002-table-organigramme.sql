DROP TABLE IF EXISTS organigramme CASCADE ;
CREATE TABLE organigramme (
orga_code VARCHAR(20)  NOT NULL,
orga_name VARCHAR(50),
CONSTRAINT pk_organigramme PRIMARY KEY (orga_code)
);

