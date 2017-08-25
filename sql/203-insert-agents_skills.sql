CREATE TEMPORARY TABLE temp_agents_skills
(
    skill_code VARCHAR(20) NOT NULL,
agent_id int NOT NULL,
ac_level VARCHAR(3)
);


COPY temp_agents_skills FROM '/docker-entrypoint-initdb.d/Agents_Comp.csv' DELIMITER ';' CSV HEADER encoding 'windows-1251';

UPDATE temp_agents_skills
SET ac_level = REPLACE(ac_level, ',', '.');

alter table temp_agents_skills
alter column ac_level TYPE numeric(2,1) USING (ac_level::numeric(2,1));

insert into agents_skills (skill_code,agent_id,ac_level)
    select * from temp_agents_skills;

drop table temp_agents_skills;