DROP TABLE IF EXISTS agents_organigramme CASCADE ;
CREATE TABLE agents_organigramme (
agent_id int NOT NULL,
orga_code VARCHAR(20) NOT NULL,
CONSTRAINT pk_agents_organigramme PRIMARY KEY (orga_code,agent_id),
CONSTRAINT fk_agents_organigramme_organigramme FOREIGN KEY (orga_code) REFERENCES organigramme(orga_code),
CONSTRAINT fk_agents_organigramme_agent FOREIGN KEY (agent_id) REFERENCES agents(agent_id)
);

