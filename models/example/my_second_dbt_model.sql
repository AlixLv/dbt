{{ config(
   tags=["example"]
) }}
select id
from {{ ref('my_first_dbt_model') }}
where id = 1
union all
select id
from {{ ref('my_third_model') }}
where id = 2