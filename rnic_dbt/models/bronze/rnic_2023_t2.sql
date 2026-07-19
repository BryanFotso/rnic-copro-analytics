-- depends_on: {{ source('raw_rnic', 'rnic_2023_t2_csv') }}

{{ load_rnic_csv_file('data/raw/2023/RNIC T2 2023.csv', 2023, 2) }}
