ALTER DATABASE "gpecanalyseur" SET DateStyle =iso, dmy;

DROP TABLE IF EXISTS agents CASCADE ;
CREATE TABLE agents (
agent_id int NOT NULL,
agent_birthdate DATE,
agent_contrat Varchar(8) default 'CDI',
agent_corps varchar(3),
family_id VARCHAR(10),
CONSTRAINT pk_agents PRIMARY KEY (agent_id),
CONSTRAINT fk_agents_familly FOREIGN KEY (family_id) REFERENCES family(family_id)
);

