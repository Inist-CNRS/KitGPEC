DROP TABLE IF EXISTS agents_services CASCADE ;
CREATE TABLE agents_services (
agent_id int NOT NULL,
serv_code VARCHAR(20) NOT NULL,
CONSTRAINT pk_agents_services PRIMARY KEY (serv_code,agent_id),
CONSTRAINT fk_agents_services_services FOREIGN KEY (serv_code) REFERENCES services(serv_code),
CONSTRAINT fk_agents_services_agent FOREIGN KEY (agent_id) REFERENCES agents(agent_id)
);

