-- depends_on: {{ source('raw_rnic', 'rnic_2025_t3_csv') }}

{{ load_rnic_csv_file('data/raw/2025/RNIC T3 2025.csv', 2025, 3) }}
