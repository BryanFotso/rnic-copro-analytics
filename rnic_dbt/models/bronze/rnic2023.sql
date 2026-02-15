{{ config(materialized='view', alias='RNIC2023') }}

select
    *,
    filename as source_file,
    2023 as source_year,
    regexp_extract(filename, 'T\\s*([1-4])\\s*2023', 1) as source_quarter
from read_csv_auto(
    'data/raw/2023/*.csv',
    header=true,
    delim=',',
    quote='"',
    filename=true,
    union_by_name=true
)
