DROP TABLE IF EXISTS agents_skills CASCADE;
CREATE TABLE agents_skills (
skill_code VARCHAR(20) NOT NULL,
agent_id int NOT NULL,
ac_level DECIMAL(2,1),
CONSTRAINT pk_agents_skills PRIMARY KEY (skill_code,agent_id),
CONSTRAINT fk_agents_skills_skills FOREIGN KEY (skill_code) REFERENCES skills(skill_code),
CONSTRAINT fk_agents_skills_agents FOREIGN KEY (agent_id) REFERENCES agents(agent_id)
);