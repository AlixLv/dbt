unit_tests: # dbt test --select "my_second_dbt_model,test_type:unit"
 - name: test_my_second_dbt_model
   description: "Check my my_second_dbt_model logic captures all records from my_first_dbt_model and my_third_model."
   model: my_second_dbt_model
   given:
     - input: ref('my_first_dbt_model')
       rows:
         - {id: 1,    comments: 'Some comments'}
         - {id: 2,    comments: 'Some comments'}
     - input: ref('my_third_model')
       rows:
         - {id: 1,    comments: 'Some comments'}
         - {id: 2,    comments: 'Some comments'}
   expect:
     rows:
       - {id: 1,    comments: 'Some comments'}
       - {id: 2,    comments: 'Some comments'}