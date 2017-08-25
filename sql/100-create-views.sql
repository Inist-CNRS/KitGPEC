CREATE VIEW view_skills_without_family AS
select c.skill_code,skill_shortname from skills c
where not exists (select null FROM family_skills fc where c.skill_code=fc.skill_code)
ORDER BY skill_code;


CREATE VIEW view_family_full_restriction AS
select distinct family_id from family_skills
 where family_id not in(
                        select distinct family_id from family_skills
                            where  discriminante='NON')
 ORDER BY family_id;

CREATE VIEW view_family_without_restriction AS
select distinct family_id from family_skills
 where family_id not in(
                        select distinct family_id from family_skills
                            where  discriminante='OUI')
 ORDER BY family_id;


CREATE VIEW view_family_without_rules AS
select fc.family_id,agent_id, count(fc.skill_code) as nb_comp,table2.nb_comp_neccessaire
from agents_skills ac,family_skills fc inner join (
   				 select fc.family_id,count(skill_code) as nb_comp_neccessaire from family_skills fc,family f
				where discriminante='OUI' and fc.family_id=f.family_id and family_rule is null
                 group by fc.family_id order by fc.family_id) table2 on fc.family_id= table2.family_id
where fc.skill_code=ac.skill_code
AND discriminante='OUI' AND ac_level >=2
GROUP BY fc.family_id, agent_id,table2.nb_comp_neccessaire
HAVING count(fc.skill_code)>=table2.nb_comp_neccessaire
ORDER BY family_id, agent_id;

CREATE VIEW view_agents_family_4X2_discriminantes AS
select fc.family_id,agent_id, count(fc.skill_code) as nb_comp,table2.nb_comp_neccessaire
from agents_skills ac,family_skills fc inner join (
   				 select fc.family_id,count(skill_code) as nb_comp_neccessaire from family_skills fc,family f
				where discriminante='OUI' and fc.family_id=f.family_id and family_rule = '4X2'
                 group by fc.family_id order by fc.family_id) table2 on fc.family_id= table2.family_id
where fc.skill_code=ac.skill_code
AND discriminante='OUI' AND ac_level >=2
GROUP BY fc.family_id, agent_id,table2.nb_comp_neccessaire
HAVING count(fc.skill_code)>=table2.nb_comp_neccessaire
ORDER BY family_id, agent_id;



CREATE VIEW view_agents_family_4X2_discriminant AS
select fc.family_id,ac.agent_id, count(fc.skill_code) as nb_comp
from agents_skills ac,family_skills fc inner join view_agents_family_4X2_discriminantes va on va.family_id=fc.family_id
where fc.skill_code=ac.skill_code
AND ac_level >=2
and va.agent_id=ac.agent_id
GROUP BY fc.family_id, ac.agent_id
HAVING count(fc.skill_code)>=4
ORDER BY family_id, agent_id;

CREATE VIEW view_agents_family_4X2_without_discriminant AS
select fc.family_id,ac.agent_id, count(fc.skill_code) as nb_comp
from agents_skills ac,family_skills fc inner join view_family_without_restriction vs on vs.family_id=fc.family_id ,family f
where ac_level >=2 and f.family_id = vs.family_id
and ac.skill_code=fc.skill_code and family_rule='4X2'
GROUP BY fc.family_id, ac.agent_id
HAVING count(fc.skill_code)>=4
ORDER BY family_id, agent_id;

CREATE VIEW view_agents_family_4X2 AS
select * from view_agents_family_4X2_without_discriminant vs union (select * from view_agents_family_4X2_discriminant va) order by family_id,agent_id;



CREATE VIEW view_agents_family_3X3_discriminantes AS
select fc.family_id,agent_id, count(fc.skill_code) as nb_comp,table2.nb_comp_neccessaire
from agents_skills ac,family_skills fc inner join (
   				 select fc.family_id,count(skill_code) as nb_comp_neccessaire from family_skills fc,family f
				where discriminante='OUI' and fc.family_id=f.family_id and family_rule = '3X3'
                 group by fc.family_id order by fc.family_id) table2 on fc.family_id= table2.family_id
where fc.skill_code=ac.skill_code
AND discriminante='OUI' AND ac_level >=3
GROUP BY fc.family_id, agent_id,table2.nb_comp_neccessaire
HAVING count(fc.skill_code)>=table2.nb_comp_neccessaire
ORDER BY family_id, agent_id;



CREATE VIEW view_agents_family_3X3_discriminant AS
select fc.family_id,ac.agent_id, count(fc.skill_code) as nb_comp
from agents_skills ac,family_skills fc inner join view_agents_family_3X3_discriminantes va on va.family_id=fc.family_id
where fc.skill_code=ac.skill_code
AND ac_level >=3
and va.agent_id=ac.agent_id
GROUP BY fc.family_id, ac.agent_id
HAVING count(fc.skill_code)>=3
ORDER BY family_id, agent_id;

CREATE VIEW view_agents_family_3X3_without_discriminant AS
select fc.family_id,ac.agent_id, count(fc.skill_code) as nb_comp
from agents_skills ac,family_skills fc inner join view_family_without_restriction vs on vs.family_id=fc.family_id ,family f
where ac_level >=3 and f.family_id = vs.family_id
and ac.skill_code=fc.skill_code and family_rule='3X3'
GROUP BY fc.family_id, ac.agent_id
HAVING count(fc.skill_code)>=3
ORDER BY family_id, agent_id;

CREATE VIEW view_agents_family_3X3 AS
select * from view_agents_family_3X3_without_discriminant vs union (select * from view_agents_family_3X3_discriminant va) order by family_id,agent_id;

--nombre agents par famille
CREATE VIEW view_nb_agents_family AS
select finalvue.family_id, nb_agent
from
(select family_id, count(agent_id) as nb_agent from view_agents_family_4X2 group by family_id UNION
    select family_id, count(agent_id) as nb_agent from view_agents_family_3X3 vaf group by family_id
    UNION select family_id, count(agent_id) as nb_agent from view_family_without_rules group by family_id) as finalvue
group by finalvue.family_id,nb_agent
order by finalvue.family_id;


CREATE VIEW view_agents_family AS
select finalvue.family_id, agent_id
from
(select family_id, agent_id from view_agents_family_4X2 group by family_id,agent_id UNION
    select family_id, agent_id from view_agents_family_3X3 vaf group by family_id,agent_id
    UNION select family_id, agent_id from view_family_without_rules group by family_id,agent_id)
     as finalvue
group by finalvue.family_id,agent_id
order by finalvue.family_id,agent_id;

CREATE VIEW view_agents_without_family AS
select distinct agent_id from agents
 where agent_id not in(select distinct agent_id from view_agents_family)
  ORDER BY agent_id;

CREATE VIEW view_nb_agents_without_family AS
select count(agent_id) from view_agents_without_family;

CREATE VIEW view_age_agents_family AS
select family_id,date_part('year', avg(AGE(agent_birthdate))) as moyenne_age
 from agents a , view_agents_family vaf
 where 	a.agent_id= vaf.agent_id
    group by family_id
    order by family_id ;

CREATE VIEW view_retirement_65 AS
 select family_id,count(date_part('year', (AGE(agent_birthdate)))+5) as nb_depart
 from agents a , view_agents_family vaf
 where 	a.agent_id = vaf.agent_id
 and 	date_part('year', (AGE(agent_birthdate)))+5 >65
    group by family_id
    order by family_id ;

CREATE VIEW view_distribution_corps AS
select vaf.family_id,sum(CASE WHEN agent_contrat = 'CDD' THEN 1 ELSE 0 END) as nb_CDD,
sum(CASE WHEN agent_contrat = 'CDI' THEN 1 ELSE 0 END) as nb_CDI,
	sum(CASE WHEN agent_corps = 'IR' THEN 1 ELSE 0 END) as nb_IR,
    sum(CASE WHEN agent_corps = 'IE' THEN 1 ELSE 0 END) as nb_IE,
     sum(CASE WHEN agent_corps = 'AI' THEN 1 ELSE 0 END) as nb_AI,
    sum(CASE WHEN agent_corps = 'T' THEN 1 ELSE 0 END) as nb_T,
         sum(CASE WHEN agent_corps = 'ATR' THEN 1 ELSE 0 END) as nb_ATR
    from view_agents_family vaf,agents ag
where ag.agent_id = vaf.agent_id
group by vaf.family_id;



CREATE VIEW view_family_without_agents AS
select distinct family_id from family
 where family_id not in(select distinct family_id from view_agents_family)
  ORDER BY family_id;

--test entitee

--insert into  agents VALUES (999,'1999-12-31','CDI','IR','DPI','TEST');

--insert into agents_skills VALUES ('c-se-gene-09',999,0);
--insert into agents_skills VALUES ('c-se-gene-17',999,0);
--insert into agents_skills VALUES ('c-s-logi-03',999,5);
--insert into agents_skills VALUES ('c-s-logi-07',999,5);
--insert into agents_skills VALUES ('c-s-logi-08',999,5);

-- Recherche agent,son niveau et nom competence par family_id et agent_id
--select agent_id,discriminante,ac_level,skill_shortname
--from agents_skills ac,family_skills fc, skills c
--where ac.skill_code=fc.skill_code and c.skill_code = fc.skill_code
--and agent_id in (41,110) and family_id='PROSP'
--group by discriminante,agent_id,ac_level,skill_shortname
--order by agent_id;