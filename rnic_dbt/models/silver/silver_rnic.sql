{{ config(alias='silver_rnic') }}

with unioned as (
    select * from {{ ref('rnic2022') }}
    union all by name
    select * from {{ ref('rnic2023') }}
    union all by name
    select * from {{ ref('rnic2024') }}
    union all by name
    select * from {{ ref('rnic2025') }}
),
normalized as (
    select
        coalesce(cast("EPCI" as varchar), cast("epci" as varchar)) as epci,
        coalesce(cast("Commune" as varchar), cast("commune" as varchar)) as commune,
        coalesce(
            cast("Numéro d'immatriculation" as varchar),
            cast("numero_d_immatriculation" as varchar)
        ) as numero_d_immatriculation,
        coalesce(
            try_cast("Date d'immatriculation" as date),
            try_cast("date_d_immatriculation" as date),
            try_strptime(cast("Date d'immatriculation" as varchar), '%d/%m/%Y')::date,
            try_strptime(cast("date_d_immatriculation" as varchar), '%Y-%m-%d')::date
        ) as date_d_immatriculation,
        coalesce(
            try_cast("Date de la dernière MAJ" as date),
            try_cast("date_de_la_derniere_maj" as date),
            try_strptime(cast("Date de la dernière MAJ" as varchar), '%d/%m/%Y')::date,
            try_strptime(cast("date_de_la_derniere_maj" as varchar), '%Y-%m-%d')::date
        ) as date_de_la_derniere_maj,
        coalesce(
            cast("Type de syndic : bénévole / professionnel / non connu" as varchar),
            cast("type_de_syndic_benevole_professionnel_non_connu" as varchar)
        ) as type_de_syndic,
        coalesce(
            cast(
                "Identification du représentant légal  (raison sociale et le numéro SIRET du syndic professionnel ou Civilité/prénom/ nom du syndic bénévole ou coopératif)"
                as varchar
            ),
            cast("identification_du_representant_legal_raison_sociale_et_le_numer" as varchar)
        ) as identification_representant_legal,
        coalesce(
            cast("SIRET du représentant légal" as varchar),
            cast("Siret représentant légal (si existe)" as varchar),
            cast("siret_du_representant_legal" as varchar)
        ) as siret_du_representant_legal,
        coalesce(cast("Code APE" as varchar), cast("code_ape" as varchar)) as code_ape,
        coalesce(
            cast("Commune du représentant légal" as varchar),
            cast("commune_du_representant_legal" as varchar)
        ) as commune_du_representant_legal,
        coalesce(
            cast("Mandat en cours dans la copropriété" as varchar),
            cast("mandat_en_cours_dans_la_copropriete" as varchar)
        ) as mandat_en_cours,
        coalesce(
            try_cast("Date de fin du dernier mandat" as date),
            try_cast("date_de_fin_du_dernier_mandat" as date),
            try_strptime(cast("Date de fin du dernier mandat" as varchar), '%d/%m/%Y')::date,
            try_strptime(cast("date_de_fin_du_dernier_mandat" as varchar), '%Y-%m-%d')::date
        ) as date_de_fin_du_dernier_mandat,
        coalesce(
            cast("Nom d’usage de la copropriété" as varchar),
            cast("nom_d_usage_de_la_copropriete" as varchar)
        ) as nom_usage_copropriete,
        coalesce(cast("Adresse de référence" as varchar), cast("adresse_de_reference" as varchar)) as adresse_de_reference,
        coalesce(
            cast("Numéro et Voie (adresse de référence)" as varchar),
            cast("numero_et_voie_adresse_de_reference" as varchar)
        ) as numero_et_voie_adresse_de_reference,
        coalesce(
            cast("Code postal (adresse de référence)" as varchar),
            cast("code_postal_adresse_de_reference" as varchar)
        ) as code_postal_adresse_de_reference,
        coalesce(
            cast("Commune (adresse de référence)" as varchar),
            cast("commune_adresse_de_reference" as varchar)
        ) as commune_adresse_de_reference,
        coalesce(cast("Adresse complémentaire 1" as varchar), cast("adresse_complementaire_1" as varchar)) as adresse_complementaire_1,
        coalesce(cast("Adresse complémentaire 2" as varchar), cast("adresse_complementaire_2" as varchar)) as adresse_complementaire_2,
        coalesce(cast("Adresse complémentaire 3" as varchar), cast("adresse_complementaire_3" as varchar)) as adresse_complementaire_3,
        coalesce(
            try_cast("Nombre d'adresses complémentaires" as integer),
            try_cast("nombre_d_adresses_complementaires" as integer)
        ) as nombre_d_adresses_complementaires,
        coalesce(try_cast("long" as double), try_cast("long" as double)) as longitude,
        coalesce(try_cast("lat" as double), try_cast("lat" as double)) as latitude,
        coalesce(
            try_cast("Date du règlement de copropriété" as date),
            try_cast("date_du_reglement_de_copropriete" as date),
            try_strptime(cast("Date du règlement de copropriété" as varchar), '%d/%m/%Y')::date,
            try_strptime(cast("date_du_reglement_de_copropriete" as varchar), '%Y-%m-%d')::date
        ) as date_du_reglement_de_copropriete,
        coalesce(cast("Résidence service" as varchar), cast("residence_service" as varchar)) as residence_service,
        coalesce(cast("Syndicat coopératif" as varchar), cast("syndicat_cooperatif" as varchar)) as syndicat_cooperatif,
        coalesce(
            cast("Syndicat principal ou syndicat secondaire" as varchar),
            cast("syndicat_principal_ou_syndicat_secondaire" as varchar)
        ) as syndicat_principal_ou_secondaire,
        coalesce(
            cast("Si secondaire, n° d’immatriculation du principal" as varchar),
            cast("si_secondaire_n_d_immatriculation_du_principal" as varchar)
        ) as immatriculation_principal,
        try_cast("Nombre total de lots" as integer) as nombre_total_de_lots,
        coalesce(
            try_cast("Nombre total de lots à usage d’habitation, de bureaux ou de commerces" as integer),
            try_cast("nombre_total_de_lots_a_usage_d_habitation_de_bureaux_ou_de_comm" as integer)
        ) as nombre_total_lots_habitation_bureaux_commerces,
        coalesce(
            try_cast("Nombre de lots à usage d’habitation" as integer),
            try_cast("nombre_de_lots_a_usage_d_habitation" as integer)
        ) as nombre_lots_habitation,
        coalesce(
            try_cast("Nombre de lots de stationnement" as integer),
            try_cast("nombre_de_lots_de_stationnement" as integer)
        ) as nombre_lots_stationnement,
        coalesce(cast("Période de construction" as varchar), cast("periode_de_construction" as varchar)) as periode_de_construction,
        coalesce(cast("Code INSEE commune 1" as varchar), cast("code_insee_commune_1" as varchar)) as code_insee_commune_1,
        coalesce(cast("Code INSEE commune 2" as varchar), cast("code_insee_commune_2" as varchar)) as code_insee_commune_2,
        coalesce(cast("Code INSEE commune 3" as varchar), cast("code_insee_commune_3" as varchar)) as code_insee_commune_3,
        coalesce(
            try_cast("Nombre de parcelles cadastrales" as integer),
            try_cast("nombre_de_parcelles_cadastrales" as integer)
        ) as nombre_parcelles_cadastrales,
        coalesce(cast("nom_qp_2015" as varchar), cast("nom_qp" as varchar)) as nom_qp_2015,
        coalesce(cast("code_qp_2015" as varchar), cast("code_qp" as varchar)) as code_qp_2015,
        cast("nom_qp_2024" as varchar) as nom_qp_2024,
        cast("code_qp_2024" as varchar) as code_qp_2024,
        coalesce(cast("Copro dans ACV" as varchar), cast("copro_dans_acv" as varchar)) as copro_dans_acv,
        coalesce(cast("Copro dans PVD" as varchar), cast("copro_dans_pvd" as varchar)) as copro_dans_pvd,
        coalesce(cast("Code de PDP" as varchar), cast("code_de_pdp" as varchar)) as code_de_pdp,
        coalesce(cast("Copro dans PDP" as varchar), cast("copro_dans_pdp" as varchar)) as copro_dans_pdp,
        coalesce(cast("Copro aidée" as varchar), cast("copro_aidee" as varchar)) as copro_aidee,
        coalesce(cast("Code Officiel Commune" as varchar), cast("code_officiel_commune" as varchar)) as code_officiel_commune,
        coalesce(cast("Nom Officiel Commune" as varchar), cast("nom_officiel_commune" as varchar)) as nom_officiel_commune,
        coalesce(cast("Code Officiel Département" as varchar), cast("code_officiel_departement" as varchar)) as code_officiel_departement,
        coalesce(cast("Nom Officiel Département" as varchar), cast("nom_officiel_departement" as varchar)) as nom_officiel_departement,
        coalesce(cast("Code Officiel Région" as varchar), cast("code_officiel_region" as varchar)) as code_officiel_region,
        coalesce(cast("Nom Officiel Région" as varchar), cast("nom_officiel_region" as varchar)) as nom_officiel_region,
        cast("source_file" as varchar) as source_file,
        try_cast("source_year" as integer) as source_year,
        try_cast("source_quarter" as integer) as source_quarter
    from unioned
)

select *
from normalized
where numero_d_immatriculation is not null
