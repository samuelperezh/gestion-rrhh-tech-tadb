-- Script PostgreSQL
-- Curso de Tópicos Avanzados de base de datos - UPB 202320
-- Samuel Pérez Hurtado ID 000459067 - Luisa María Flórez Múnera ID 000449529

-- Proyecto: Sistema de gestión de recursos humanos y empleos en la industria tecnológica en los años 2020, 2021 y 2022
-- Motor de Base de datos: PostgreSQL 15.3 (Trabajado por Luisa María Florez)

-- Crear el esquema de la base de datos
create database gestion_rrhh_tech_db;

-- Crear el usuario con el que se realizarán las acciones con privilegios mínimos
create user gestion_rrhh_tech_usr with encrypted password 'gestion_rrhh';

-- Asignar privilegios al nuevo usuario solo en la base de datos creada
grant create, connect on database gestion_rrhh_tech_db to gestion_rrhh_tech_usr;
grant create on schema public to gestion_rrhh_tech_usr;
grant select, insert, update, delete, trigger on all tables in schema public to gestion_rrhh_tech_usr;

-- ***********************************************
-- Creación de las tablas en el esquema inicial
-- ***********************************************

create schema inicial;
grant create on schema inicial to gestion_rrhh_tech_usr;
grant select, insert, update, delete, trigger on all tables in schema inicial to gestion_rrhh_tech_usr;

-- Tabla: employment_statuses
create table inicial.employment_statuses
(
    id int not null,
    employment_status varchar(50) not null
);

comment on table inicial.employment_statuses is 'Tabla que contiene los estados de empleo de los empleados';
comment on column inicial.employment_statuses.id is 'Identificador único del estado de empleo';
comment on column inicial.employment_statuses.employment_status is 'Estado de empleo';

-- Tabla: employment_types
create table inicial.employment_types
(
    id int not null,
    employment_type varchar(50) not null
);

comment on table inicial.employment_types is 'Tabla que contiene los tipos de empleo de los empleados';
comment on column inicial.employment_types.id is 'Identificador único del tipo de empleo';
comment on column inicial.employment_types.employment_type is 'Tipo de empleo';

-- Tabla: experience_levels
create table inicial.experience_levels
(
    id int not null,
    experience_level varchar(50) not null
);

comment on table inicial.experience_levels is 'Tabla que contiene los niveles de experiencia de los empleados';
comment on column inicial.experience_levels.id is 'Identificador único del nivel de experiencia';
comment on column inicial.experience_levels.experience_level is 'Nivel de experiencia';

-- Tabla: job_titles
create table inicial.job_titles
(
    id int not null,
    job_title varchar(200) not null
);

comment on table inicial.job_titles is 'Tabla que contiene los cargos de los empleados';
comment on column inicial.job_titles.id is 'Identificador único del cargo';
comment on column inicial.job_titles.job_title is 'Cargo';

-- Tabla: company_locations
create table inicial.company_locations
(
    id int not null,
    company_location varchar(50) not null
);

comment on table inicial.company_locations is 'Tabla que contiene las ubicaciones de las empresas';
comment on column inicial.company_locations.id is 'Identificador único de la ubicación';
comment on column inicial.company_locations.company_location is 'Ubicación';

-- Tabla: company_sizes
create table inicial.company_sizes
(
    id int not null,
    company_size varchar(50) not null
);

comment on table inicial.company_sizes is 'Tabla que contiene los tamaños de las empresas';
comment on column inicial.company_sizes.id is 'Identificador único del tamaño';
comment on column inicial.company_sizes.company_size is 'Tamaño';

-- Tabla: companies
create table inicial.companies
(
    id int not null,
    company_location_id int not null,
    company_size_id int not null
);

comment on table inicial.companies is 'Tabla que contiene las empresas';
comment on column inicial.companies.id is 'Identificador único de la empresa';
comment on column inicial.companies.company_location_id is 'Identificador único de la ubicación de la empresa';
comment on column inicial.companies.company_size_id is 'Identificador único del tamaño de la empresa';

-- Tabla: remote_ratios
create table inicial.remote_ratios
(
    id int not null,
    remote_ratio varchar(50) not null
);

comment on table inicial.remote_ratios is 'Tabla que contiene los porcentajes de trabajo remoto';
comment on column inicial.remote_ratios.id is 'Identificador único del porcentaje de trabajo remoto';
comment on column inicial.remote_ratios.remote_ratio is 'Porcentaje de trabajo remoto';

-- Tabla: employee_residences
create table inicial.employee_residences
(
    id int not null,
    employee_residence varchar(50) not null
);

comment on table inicial.employee_residences is 'Tabla que contiene los lugares de residencia de los empleados';
comment on column inicial.employee_residences.id is 'Identificador único del lugar de residencia del empleado';
comment on column inicial.employee_residences.employee_residence is 'Lugar de residencia del empleado';

-- Tabla: employees
create table inicial.employees
(
    id int generated always as identity,
    experience_level_id int not null,
    employment_type_id int not null,
    job_title_id int not null,
    employment_status_id int not null,
    employee_residence_id int not null,
    remote_ratio_id int not null,
    company_id int not null,
    work_year int not null,
    salary_usd int not null
);

comment on table inicial.employees is 'Tabla que contiene los empleados';
comment on column inicial.employees.id is 'Identificador único del empleado';
comment on column inicial.employees.experience_level_id is 'Identificador único del nivel de experiencia del empleado';
comment on column inicial.employees.employment_type_id is 'Identificador único del tipo de empleo del empleado';
comment on column inicial.employees.job_title_id is 'Identificador único del cargo del empleado';
comment on column inicial.employees.employment_status_id is 'Identificador único del estado de empleo del empleado';
comment on column inicial.employees.employee_residence_id is 'Identificador único del lugar de residencia del empleado';
comment on column inicial.employees.remote_ratio_id is 'Identificador único del porcentaje de trabajo remoto del empleado';
comment on column inicial.employees.company_id is 'Identificador único de la empresa del empleado';
comment on column inicial.employees.work_year is 'Año de trabajo';
comment on column inicial.employees.salary_usd is 'Salario en dólares';

-- ***********************************************
-- Creación de las tablas en el esquema optimizado
-- ***********************************************

create schema optimizado;

-- Antes de crear las tablas se revisa la longitud máxima de las variables tipo varchar,
-- esto con el fin de tomar mejores decisiones sobre la longitud del campo
select max(length(employee_residence)) from inicial.employee_residences;
select max(length(remote_ratio)) from inicial.remote_ratios;
select max(length(company_size)) from inicial.company_sizes;
select max(length(company_location)) from inicial.company_locations;
select max(length(job_title)) from inicial.job_titles;
select max(length(experience_level)) from inicial.experience_levels;
select max(length(employment_type)) from inicial.employment_types;
select max(length(employment_status)) from inicial.employment_statuses;

-- Tabla: employment_statuses
create table optimizado.employment_statuses
(
    id int not null
        constraint employment_statuses_pk primary key,
    employment_status varchar(10) not null constraint employment_status_uk unique
);

comment on table optimizado.employment_statuses is 'Tabla que contiene los estados de empleo de los empleados';
comment on column optimizado.employment_statuses.id is 'Identificador único del estado de empleo';
comment on column optimizado.employment_statuses.employment_status is 'Estado de empleo';

insert into optimizado.employment_statuses (id, employment_status)
(
    select id, employment_status
    from inicial.employment_statuses
);

-- Tabla: employment_types
create table optimizado.employment_types
(
    id int not null
        constraint employment_types_pk primary key,
    employment_type varchar(15) not null constraint employment_type_uk unique
);

comment on table optimizado.employment_types is 'Tabla que contiene los tipos de empleo de los empleados';
comment on column optimizado.employment_types.id is 'Identificador único del tipo de empleo';
comment on column optimizado.employment_types.employment_type is 'Tipo de empleo';

insert into optimizado.employment_types (id, employment_type)
(
    select id, employment_type
    from inicial.employment_types
);

-- Tabla: experience_levels
create table optimizado.experience_levels
(
    id int not null
        constraint experience_levels_pk primary key,
    experience_level varchar(15) not null constraint experience_level_uk unique
);

comment on table optimizado.experience_levels is 'Tabla que contiene los niveles de experiencia de los empleados';
comment on column optimizado.experience_levels.id is 'Identificador único del nivel de experiencia';
comment on column optimizado.experience_levels.experience_level is 'Nivel de experiencia';

insert into optimizado.experience_levels (id, experience_level)
(
    select id, experience_level
    from inicial.experience_levels
);

-- Tabla: job_titles
create table optimizado.job_titles
(
    id int not null
        constraint job_titles_pk primary key,
    job_title varchar(50) not null
);

comment on table optimizado.job_titles is 'Tabla que contiene los cargos de los empleados';
comment on column optimizado.job_titles.id is 'Identificador único del cargo';
comment on column optimizado.job_titles.job_title is 'Cargo';

insert into optimizado.job_titles (id, job_title)
(
    select id, job_title
    from inicial.job_titles
);

-- Tabla: company_locations
create table optimizado.company_locations
(
    id int not null
        constraint company_locations_pk primary key,
    company_location varchar(5) not null constraint company_location_uk unique
);

comment on table optimizado.company_locations is 'Tabla que contiene las ubicaciones de las empresas';
comment on column optimizado.company_locations.id is 'Identificador único de la ubicación';
comment on column optimizado.company_locations.company_location is 'Ubicación';

insert into optimizado.company_locations (id, company_location)
(
    select id, company_location
    from inicial.company_locations
);

-- Tabla: company_sizes
create table optimizado.company_sizes
(
    id int not null
        constraint company_sizes_pk primary key,
    company_size varchar(5) not null constraint company_size_uk unique
);

comment on table optimizado.company_sizes is 'Tabla que contiene los tamaños de las empresas';
comment on column optimizado.company_sizes.id is 'Identificador único del tamaño';
comment on column optimizado.company_sizes.company_size is 'Tamaño de la empresa';

insert into optimizado.company_sizes (id, company_size)
(
    select id, company_size
    from inicial.company_sizes
);

-- Tabla: companies
create table optimizado.companies
(
    id int not null
        constraint companies_pk primary key,
    company_location_id int not null
        constraint companies_company_locations_id_fk references optimizado.company_locations,
    company_size_id int not null
        constraint companies_company_sizes_id_fk references optimizado.company_sizes
);

comment on table optimizado.companies is 'Tabla que contiene las empresas';
comment on column optimizado.companies.id is 'Identificador único de la empresa';
comment on column optimizado.companies.company_location_id is 'Identificador único de la ubicación de la empresa';
comment on column optimizado.companies.company_size_id is 'Identificador único del tamaño de la empresa';

insert into optimizado.companies (id, company_location_id, company_size_id)
(
    select id, company_location_id, company_size_id
    from inicial.companies
);

-- Tabla: remote_ratios
create table optimizado.remote_ratios
(
    id int not null
        constraint remote_ratios_pk primary key,
    remote_ratio varchar(5) not null constraint remote_ratio_uk unique
);

comment on table optimizado.remote_ratios is 'Tabla que contiene los porcentajes de trabajo remoto';
comment on column optimizado.remote_ratios.id is 'Identificador único del porcentaje de trabajo remoto';
comment on column optimizado.remote_ratios.remote_ratio is 'Porcentaje de trabajo remoto';

insert into optimizado.remote_ratios (id, remote_ratio)
(
    select id, remote_ratio
    from inicial.remote_ratios
);

-- Tabla: employee_residences
create table optimizado.employee_residences
(
    id int not null
        constraint employee_residences_pk primary key,
    employee_residence varchar(5) not null constraint employee_residence_uk unique
);

comment on table optimizado.employee_residences is 'Tabla que contiene los lugares de residencia de los empleados';
comment on column optimizado.employee_residences.id is 'Identificador único del lugar de residencia del empleado';
comment on column optimizado.employee_residences.employee_residence is 'Lugar de residencia del empleado';

insert into optimizado.employee_residences (id, employee_residence)
(
    select id, employee_residence
    from inicial.employee_residences
);

-- Tabla: employees
create table optimizado.employees
(
    id int not null generated always as identity
        constraint employees_pk primary key,
    experience_level_id int not null
        constraint employees_experience_levels_id_fk references optimizado.experience_levels,
    employment_type_id int not null
        constraint employees_employment_types_id_fk references optimizado.employment_types,
    job_title_id int not null
        constraint employees_job_titles_id_fk references optimizado.job_titles,
    employment_status_id int not null
        constraint employees_employment_statuses_id_fk references optimizado.employment_statuses,
    employee_residence_id int not null
        constraint employees_employee_residences_id_fk references optimizado.employee_residences,
    remote_ratio_id int not null
        constraint employees_remote_ratios_id_fk references optimizado.remote_ratios,
    company_id int not null
        constraint employees_companies_id_fk references optimizado.companies,
    work_year int not null,
    salary_usd int not null
);

comment on table optimizado.employees is 'Tabla que contiene los empleados';
comment on column optimizado.employees.id is 'Identificador único del empleado';
comment on column optimizado.employees.experience_level_id is 'Identificador único del nivel de experiencia del empleado';
comment on column optimizado.employees.employment_type_id is 'Identificador único del tipo de empleo del empleado';
comment on column optimizado.employees.job_title_id is 'Identificador único del cargo del empleado';
comment on column optimizado.employees.employment_status_id is 'Identificador único del estado de empleo del empleado';
comment on column optimizado.employees.employee_residence_id is 'Identificador único del lugar de residencia del empleado';
comment on column optimizado.employees.remote_ratio_id is 'Identificador único del porcentaje de trabajo remoto del empleado';
comment on column optimizado.employees.company_id is 'Identificador único de la empresa del empleado';
comment on column optimizado.employees.work_year is 'Año de trabajo';
comment on column optimizado.employees.salary_usd is 'Salario en dólares';

insert into optimizado.employees (experience_level_id, employment_type_id, job_title_id, employment_status_id, employee_residence_id, remote_ratio_id, company_id, work_year, salary_usd)
(
    select experience_level_id, employment_type_id, job_title_id, employment_status_id, employee_residence_id, remote_ratio_id, company_id, work_year, salary_usd
    from inicial.employees
);

-- ***********************************************
-- Creación de índices para mejorar el desempeño
-- ***********************************************

create index employees_remote_ratio_id_idx on optimizado.employees (remote_ratio_id);
create index employees_employment_status_id_idx on optimizado.employees (employment_status_id);
create index companies_id_index on optimizado.companies (id);
create index employees_id_index on optimizado.employees (id);
create index employees_location_index on optimizado.employees (experience_level_id,company_id,work_year,salary_usd);

-- Para la implementación de las vistas y vistas materializadas, no se evidenció la necesidad de la creación de estas, debido a que 
-- no afectaba el rendimiento en ambos motores.