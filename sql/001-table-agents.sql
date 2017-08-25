ALTER DATABASE "kitgpec" SET DateStyle =iso, dmy;

DROP TABLE IF EXISTS agents CASCADE ;
CREATE TABLE agents (
agent_id int NOT NULL,
agent_birthdate DATE,
agent_contrat Varchar(8) default 'CDI',
agent_corps varchar(3),
CONSTRAINT pk_agents PRIMARY KEY (agent_id)
);

