-- Script Consultas de ambos motores de bases de datos
-- Curso de Tópicos Avanzados de base de datos - UPB 202320
-- Samuel Pérez Hurtado ID 000459067 - Luisa María Flórez Múnera ID 000449529

-- ***********************************************
-- Consultas en el esquema inicial
-- ***********************************************
---------- CONSULTAS ----------
--1. ¿Cuál es el promedio de los salarios por nivel de experiencia, año de trabajo y ubicación de la empresa?
select
    el.experience_level AS "Nivel de Experiencia",
    e.work_year AS "Año de Trabajo",
    cl.location AS "Ubicación de la Empresa",
    ROUND(AVG(e.salary_usd)::numeric, 2) AS "Promedio de Salario"
from inicial.employees e
join inicial.experience_levels el ON e.experience_level_id = el.id
join inicial.companies c ON e.company_id = c.id
join inicial.company_locations cl ON c.company_location_id = cl.id
group by el.experience_level, e.work_year, cl.location
order by el.experience_level, e.work_year, cl.location;

--2. ¿Cuál es la cantidad de empleados en estado "On Leave" por ubicación y tamaño de Empresa?
select
    cl.location AS "Ubicación de la Empresa",
    cs.size AS "Tamaño de Empresa",
    COUNT(e.id) AS "Cantidad de Empleados en Estado On Leave"
from inicial.employees e
join inicial.companies c ON e.company_id = c.id
join inicial.company_locations cl ON c.company_location_id = cl.id
join inicial.company_sizes cs ON c.company_size_id = cs.id
join inicial.employment_statuses es ON e.employment_status_id = es.id
where es.employment_status = 'On Leave'
group by cl.location, cs.size
order by cl.location, cs.size;

--3. ¿Cuál es el análisis de empleados remotos (100%) por título de trabajo y tamaño de empresa?
select
    jt.job_title AS "Título de Trabajo",
    cs.size AS "Tamaño de Empresa",
    COUNT(e.id) AS "Cantidad de Empleados Remotos"
from inicial.employees e
join inicial.companies c ON e.company_id = c.id
join inicial.company_sizes cs ON c.company_size_id = cs.id
join inicial.job_titles jt ON e.job_title_id = jt.id
join inicial.remote_ratios rr ON e.remote_ratio_id = rr.id
where rr.remote_ratio = '100'
group by jt.job_title, cs.size
order by jt.job_title, cs.size;