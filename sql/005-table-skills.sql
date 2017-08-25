
DROP TABLE IF EXISTS skills CASCADE;
CREATE TABLE skills (
skill_code VARCHAR(20) NOT NULL,
skill_type VARCHAR(20),
skill_domaine VARCHAR(50),
skill_shortname Varchar (255),
skill_referens int,
CONSTRAINT pk_skills PRIMARY KEY (skill_code)
);
