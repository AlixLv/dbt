{{ config(
   tags=["example"]
) }}
select *
from {{ ref('my_first_dbt_model') }}
where id = 1
union all
select *
from {{ ref('my_third_model') }}
where id = 2
-- select 1;