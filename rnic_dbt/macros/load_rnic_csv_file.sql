{% macro load_rnic_csv_file(file_path, source_year, source_quarter) %}
select
    *,
    '{{ file_path | replace("'", "''") }}' as source_file,
    {{ source_year }}::integer as source_year,
    {{ source_quarter }}::integer as source_quarter
from read_csv_auto(
    '../{{ file_path | replace("'", "''") }}',
    header = true,
    delim = ',',
    quote = '"',
    nullstr = ['NA', 'N/A', ''],
    all_varchar = true,
    strict_mode = false
)
{% endmacro %}
