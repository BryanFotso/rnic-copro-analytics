-- depends_on: {{ source('raw_rnic', 'rnic_2024_t1_csv') }}

{{ load_rnic_csv_file('data/raw/2024/RNIC T1 2024.csv', 2024, 1) }}
