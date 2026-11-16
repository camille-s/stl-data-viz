rule download_eq:
    output:
        cdc = "data/cdc_health_all_lvls_2025.csv",
        ejscreen = "data/epa_ej_index_2024.csv",
        wage = "data/wage_gap_race_sex_2023.csv",
    shell:
        """
        gh release download dist --repo ct-data-haven/equity2025 --clobber
        mv data.zip data/eq.zip
        unzip -j -u -d data data/eq.zip \
            data/health/cdc_health_all_lvls_2025.csv \
            data/environ/epa_ej_index_2024.csv \
            data/econ/wage_gap_race_sex_2023.csv
        """

rule prep_acs:
    output:
        "data/median_hh_income_tract.csv",
    script:
        "prep_scripts/prep_acs.R"

rule prep_dcws:
    output:
        "data/dcws_food_trend_state.csv",
        "data/dcws_food_demo_gnh.csv",
        "data/dcws_food_total_towns.csv",
    script:
        "prep_scripts/prep_cws.R"

rule all_data:
    input:
        rules.download_eq.output,
        rules.prep_acs.output,
        rules.prep_dcws.output,

rule slides:
    input:
        rules.all_data.input,
        refs = "references.json",
        csl = "apa-cv.csl",
        utils = "plotting_utils.R",
        scss = "custom.scss",
        qmd = "index.qmd",
    output:
        html = "index.html",
    shell:
        "quarto render {input.qmd}"

rule all:
    input:
        "index.html",
    default_target: True