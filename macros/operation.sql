-- my_dbt/macros/operation.sql
{%- materialization operation, default  -%}
   {%- set identifier = model['alias'] -%}
 {%- set target_relation = api.Relation.create(
       identifier=identifier, schema=schema, database=database,
       type='table') -%}
 -- ... setup database ...
 -- ... run pre-hooks...
 -- build model
 {% call statement('main') -%}
   {{ run_sql_as_simple_script(target_relation, sql) }}
 {%- endcall %}
  -- ... run post-hooks ...
 -- ... clean up the database...
  
   -- COMMIT happens here
   {{ adapter.commit() }}
 -- Return the relations created in this materialization
 {{ return({'relations': [target_relation]}) }}
{%- endmaterialization -%}
-- my_dbt/macros/operation_helper.sql
{%- macro run_sql_as_simple_script(relation, sql) -%}
   {{ log("Creating table " ~ relation) }}
   {{ sql }}
{%- endmacro -%}