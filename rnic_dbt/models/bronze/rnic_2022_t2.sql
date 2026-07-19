-- depends_on: {{ source('raw_rnic', 'rnic_2022_t2_csv') }}

{{ load_rnic_csv_file('data/raw/2022/RNIC T2 2022.csv', 2022, 2) }}
