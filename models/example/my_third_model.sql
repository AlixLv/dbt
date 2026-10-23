{{ config(
   materialized='operation',
   tags=["example"]
) }}
create or replace table {{this.database}}.{{this.schema}}.{{this.name}} (
    id       int64        
   ,comments string       
);
insert into {{this.database}}.{{this.schema}}.{{this.name}} (id, comments)
select
  1                 as id       
  , 'Some comments' as comments 
union all
select
  2                 as id       
  , 'Some comments' as comments 
;