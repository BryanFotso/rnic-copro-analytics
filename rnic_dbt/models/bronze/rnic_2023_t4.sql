-- depends_on: {{ source('raw_rnic', 'rnic_2023_t4_csv') }}

{{ load_rnic_csv_file('data/raw/2023/RNIC T4 2023.csv', 2023, 4) }}
