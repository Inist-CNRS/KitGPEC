DROP TABLE IF EXISTS family CASCADE ;
CREATE TABLE family (
family_id VARCHAR(10) NOT NULL,
family_name VARCHAR(100),
family_rule VARCHAR(5),
CONSTRAINT pk_family PRIMARY KEY (family_id)
);
