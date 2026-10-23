{% macro generate_alias_name(custom_alias_name=none, node=none) -%}
   {% set apply_alias_suffix = var('apply_alias_suffix') %}
       {%- if custom_alias_name -%}
           {{ custom_alias_name }}{{  apply_alias_suffix | trim }}
       {%- elif node.version -%}
           {{ return(node.name ~ "_v" ~ (node.version | replace(".", "_")) ~ apply_alias_suffix | trim) }}
       {%- else -%}
           {{ node.name }}{{  apply_alias_suffix | trim }}
       {%- endif -%}
{%- endmacro %}