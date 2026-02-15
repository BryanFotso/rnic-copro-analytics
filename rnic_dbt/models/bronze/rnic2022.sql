{{ config(materialized='view', alias='RNIC2022') }}

select
    *,
    filename as source_file,
    2022 as source_year,
    regexp_extract(filename, 'T\\s*([1-4])\\s*2022', 1) as source_quarter
from read_csv_auto(
    'data/raw/2022/*.csv',
    header=true,
    delim=',',
    quote='"',
    filename=true,
    union_by_name=true
)
