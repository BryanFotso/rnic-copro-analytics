{{ config(alias='RNIC2025') }}

select
    *,
    filename as source_file,
    2025 as source_year,
    nullif(regexp_extract(filename, '[Tt] ?([1-4])', 1), '') as source_quarter
from read_csv_auto(
    'data/raw/2025/*.csv',
    header=true,
    delim=',',
    quote='"',
    filename=true,
    union_by_name=true,
    nullstr=['NA','N/A',''],
    all_varchar=true,
  strict_mode=false
)
