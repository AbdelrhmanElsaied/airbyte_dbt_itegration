
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table') }}

-- with source_data as (

--     select 1 as id
--     union all
--     select null as id

-- )

-- select *
-- from source_data

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
select
    jsonb_extract_path_text(_airbyte_data, 'branchId') as "branchId",
    jsonb_extract_path_text(_airbyte_data, 'branchNameEn') as "branchNameEn",
    jsonb_extract_path_text(_airbyte_data, 'lastModifiedAt') as "lastModifiedAt",
    jsonb_extract_path_text(_airbyte_data, 'city') as "city",
    
    jsonb_extract_path_text(_airbyte_data, 'branchManager','userId') as "branchManager_userId",
	jsonb_extract_path_text(_airbyte_data, 'branchManager','userName') as "branchManager_userName",

    now() as _airbyte_normalized_at
	
from "dbt-test".airbyte_dbt_itegration._airbyte_raw_branch