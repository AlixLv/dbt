-- dbt fournit déjà une macro nommée generate_schema_name, en créant un fichier avec le même nom dans macros/
-- je remplace la version par défaut par la mienne.
-- fichier exécuté par dbt automatiquement pour chaque modèle, ) chaque commande qui change le projet
-- (compile, run, build, test, docs generate, etc.)
{% macro generate_schema_name(custom_schema_name, node) -%}
   {%- set default_schema = target.schema -%}
   {%- if custom_schema_name is none -%}
       {{ default_schema }}
   {%- else -%}
       {{ custom_schema_name | trim }}
   {%- endif -%}
{%- endmacro %}