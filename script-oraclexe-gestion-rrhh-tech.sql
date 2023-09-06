-- Script Oracle
-- Curso de Tópicos Avanzados de base de datos - UPB 202320
-- Samuel Pérez Hurtado ID 000459067 - Luisa María Flórez Múnera ID 000449529

-- Proyecto: Sistema de gestión de recursos humanos y empleos en la industria tecnológica en los años 2020, 2021 y 2022
-- Motor de Base de datos: Oracle XE 21c (Trabajado por Samuel Pérez Hurtado)

-- Tener presente el contenedor al que está conectado
alter session set container=xepdb1;

-- Creación del usuario
CREATE USER GESTION_RRHH_TECH_USR IDENTIFIED BY "gestion_rrhh"  
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP;

-- Privilegios
GRANT CREATE SESSION TO GESTION_RRHH_TECH_USR;
GRANT ALTER SESSION TO GESTION_RRHH_TECH_USR;

GRANT CREATE ANY TABLE TO GESTION_RRHH_TECH_USR;
GRANT ALTER ANY TABLE TO GESTION_RRHH_TECH_USR;
GRANT DROP ANY TABLE TO GESTION_RRHH_TECH_USR;
GRANT COMMENT ANY TABLE TO GESTION_RRHH_TECH_USR;
GRANT READ ANY TABLE TO GESTION_RRHH_TECH_USR;

GRANT SELECT ANY TABLE TO GESTION_RRHH_TECH_USR;
GRANT INSERT ANY TABLE TO GESTION_RRHH_TECH_USR;
GRANT UPDATE ANY TABLE TO GESTION_RRHH_TECH_USR;
GRANT DELETE ANY TABLE TO GESTION_RRHH_TECH_USR;

GRANT CREATE ANY VIEW TO GESTION_RRHH_TECH_USR;
GRANT DROP ANY VIEW TO GESTION_RRHH_TECH_USR;

GRANT CREATE ANY INDEX TO GESTION_RRHH_TECH_USR;
GRANT ALTER ANY INDEX TO GESTION_RRHH_TECH_USR;
GRANT DROP ANY INDEX TO GESTION_RRHH_TECH_USR;

GRANT CREATE ANY TRIGGER TO GESTION_RRHH_TECH_USR;
GRANT ALTER ANY TRIGGER TO GESTION_RRHH_TECH_USR;
GRANT DROP ANY TRIGGER TO GESTION_RRHH_TECH_USR;

GRANT ALTER ANY PROCEDURE TO GESTION_RRHH_TECH_USR;
GRANT CREATE ANY PROCEDURE TO GESTION_RRHH_TECH_USR;
GRANT DEBUG ANY PROCEDURE TO GESTION_RRHH_TECH_USR;
GRANT DROP ANY PROCEDURE TO GESTION_RRHH_TECH_USR;
GRANT EXECUTE ANY PROCEDURE TO GESTION_RRHH_TECH_USR;

GRANT CREATE ANY SEQUENCE TO GESTION_RRHH_TECH_USR;
GRANT ALTER ANY SEQUENCE TO GESTION_RRHH_TECH_USR;
GRANT DROP ANY SEQUENCE TO GESTION_RRHH_TECH_USR;
GRANT SELECT ANY SEQUENCE TO GESTION_RRHH_TECH_USR;

GRANT CREATE ANY MATERIALIZED VIEW TO GESTION_RRHH_TECH_USR;
GRANT ALTER ANY MATERIALIZED VIEW TO GESTION_RRHH_TECH_USR;
GRANT DROP ANY MATERIALIZED VIEW TO GESTION_RRHH_TECH_USR;

GRANT SELECT ANY DICTIONARY TO GESTION_RRHH_TECH_USR;

-- Creación del esquema inicial
CREATE USER INICIAL IDENTIFIED BY "gestion_rrhh"  
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP;
ALTER USER INICIAL QUOTA UNLIMITED ON USERS;

-- Creación del esquema optimizado
CREATE USER OPTIMIZADO IDENTIFIED BY "gestion_rrhh"  
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP;
ALTER USER OPTIMIZADO QUOTA UNLIMITED ON USERS;

-- Privilegios específicos para el esquema optimizado
GRANT CREATE TABLE TO OPTIMIZADO;

-- ***********************************************
-- Creación de las tablas en el esquema inicial
-- ***********************************************

-- Tabla: employment_statuses
create table inicial.employment_statuses
(
    id number not null,
    employment_status varchar2(50) not null
);

comment on table inicial.employment_statuses is 'Tabla que contiene los estados de empleo de los empleados';
comment on column inicial.employment_statuses.id is 'Identificador único del estado de empleo';
comment on column inicial.employment_statuses.employment_status is 'Estado de empleo';

-- Tabla: employment_types
create table inicial.employment_types
(
    id number not null,
    employment_type varchar2(50) not null
);

comment on table inicial.employment_types is 'Tabla que contiene los tipos de empleo de los empleados';
comment on column inicial.employment_types.id is 'Identificador único del tipo de empleo';
comment on column inicial.employment_types.employment_type is 'Tipo de empleo';

-- Tabla: experience_levels
create table inicial.experience_levels
(
    id number not null,
    experience_level varchar2(50) not null
);

comment on table inicial.experience_levels is 'Tabla que contiene los niveles de experiencia de los empleados';
comment on column inicial.experience_levels.id is 'Identificador único del nivel de experiencia';
comment on column inicial.experience_levels.experience_level is 'Nivel de experiencia';

-- Tabla: job_titles
create table inicial.job_titles
(
    id number not null,
    job_title varchar2(200) not null
);

comment on table inicial.job_titles is 'Tabla que contiene los cargos de los empleados';
comment on column inicial.job_titles.id is 'Identificador único del cargo';
comment on column inicial.job_titles.job_title is 'Cargo';

-- Tabla: company_locations
create table inicial.company_locations
(
    id number not null,
    company_location varchar2(50) not null
);

comment on table inicial.company_locations is 'Tabla que contiene las ubicaciones de las empresas';
comment on column inicial.company_locations.id is 'Identificador único de la ubicación';
comment on column inicial.company_locations.company_location is 'Ubicación';

-- Tabla: company_sizes
create table inicial.company_sizes
(
    id number not null,
    company_size varchar2(50) not null
);

comment on table inicial.company_sizes is 'Tabla que contiene los tamaños de las empresas';
comment on column inicial.company_sizes.id is 'Identificador único del tamaño';
comment on column inicial.company_sizes.company_size is 'Tamaño';

-- Tabla: companies
create table inicial.companies
(
    id number not null,
    company_location_id number not null,
    company_size_id number not null
);

comment on table inicial.companies is 'Tabla que contiene las empresas';
comment on column inicial.companies.id is 'Identificador único de la empresa';
comment on column inicial.companies.company_location_id is 'Identificador único de la ubicación de la empresa';
comment on column inicial.companies.company_size_id is 'Identificador único del tamaño de la empresa';

-- Tabla: remote_ratios
create table inicial.remote_ratios
(
    id number not null,
    remote_ratio varchar2(50) not null
);

comment on table inicial.remote_ratios is 'Tabla que contiene los porcentajes de trabajo remoto';
comment on column inicial.remote_ratios.id is 'Identificador único del porcentaje de trabajo remoto';
comment on column inicial.remote_ratios.remote_ratio is 'Porcentaje de trabajo remoto';

-- Tabla: employee_residences
create table inicial.employee_residences
(
    id number not null,
    employee_residence varchar2(50) not null
);

comment on table inicial.employee_residences is 'Tabla que contiene los lugares de residencia de los empleados';
comment on column inicial.employee_residences.id is 'Identificador único del lugar de residencia del empleado';
comment on column inicial.employee_residences.employee_residence is 'Lugar de residencia del empleado';

-- Tabla: employees
create table inicial.employees
(
    id number generated always as identity,
    experience_level_id number not null,
    employment_type_id number not null,
    job_title_id number not null,
    employment_status_id number not null,
    employee_residence_id number not null,
    remote_ratio_id number not null,
    company_id number not null,
    work_year number not null,
    salary_usd number not null
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
    id number not null,
    employment_status varchar2(10) not null,
    constraint employment_statuses_pk primary key (id),
    constraint employment_status_uk unique (employment_status)
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
    id number not null,
    employment_type varchar2(15) not null,
    constraint employment_types_pk primary key (id),
    constraint employment_type_uk unique (employment_type)
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
    id number not null,
    experience_level varchar2(15) not null,
    constraint experience_levels_pk primary key (id),
    constraint experience_level_uk unique (experience_level)
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
    id number not null,
    job_title varchar2(50) not null,
    constraint job_titles_pk primary key (id)
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
    id number not null,
    company_location varchar2(5) not null,
    constraint company_locations_pk primary key (id),
    constraint company_location_uk unique (company_location)
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
    id number not null,
    company_size varchar2(5) not null,
    constraint company_sizes_pk primary key (id),
    constraint company_size_uk unique (company_size)
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
    id number not null,
    company_location_id number not null,
    company_size_id number not null,
    constraint companies_pk primary key (id),
    constraint companies_company_locations_id_fk foreign key (company_location_id) references optimizado.company_locations(id),
    constraint companies_company_sizes_id_fk foreign key (company_size_id) references optimizado.company_sizes(id)
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
    id number not null,
    remote_ratio varchar2(5) not null,
    constraint remote_ratios_pk primary key (id),
    constraint remote_ratio_uk unique (remote_ratio)
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
    id number not null,
    employee_residence varchar2(5) not null,
    constraint employee_residences_pk primary key (id),
    constraint employee_residence_uk unique (employee_residence)
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
    id number generated always as identity not null,
    experience_level_id number not null,
    employment_type_id number not null,
    job_title_id number not null,
    employment_status_id number not null,
    employee_residence_id number not null,
    remote_ratio_id number not null,
    company_id number not null,
    work_year number not null,
    salary_usd number not null,
    constraint employees_pk primary key (id),
    constraint employees_experience_levels_id_fk foreign key (experience_level_id) references optimizado.experience_levels(id),
    constraint employees_employment_types_id_fk foreign key (employment_type_id) references optimizado.employment_types(id),
    constraint employees_job_titles_id_fk foreign key (job_title_id) references optimizado.job_titles(id),
    constraint employees_employment_statuses_id_fk foreign key (employment_status_id) references optimizado.employment_statuses(id),
    constraint employees_employee_residences_id_fk foreign key (employee_residence_id) references optimizado.employee_residences(id),
    constraint employees_remote_ratios_id_fk foreign key (remote_ratio_id) references optimizado.remote_ratios(id),
    constraint employees_companies_id_fk foreign key (company_id) references optimizado.companies(id)
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
create index employees_location_index on optimizado.employees (experience_level_id,company_id,work_year,salary_usd);
create index employees_on_leave_index on optimizado.employees (company_id,employment_status_id);
create index employees_remote_index on optimizado.employees (company_id,remote_ratio_id,job_title_id);

-- Para la implementación de las vistas y vistas materializadas, no se evidenció la necesidad de la creación de estas, debido a que 
-- no afectaba el rendimiento en ambos motores.