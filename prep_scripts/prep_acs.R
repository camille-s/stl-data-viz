readRenviron(".env")

out_path <- "data/median_hh_income_tract.csv"

# median household income by tract
df <- tidycensus::get_acs(
    "tract",
    state = "09",
    year = 2024,
    table = cwi::basic_table_nums$median_income
) |>
    janitor::clean_names() |>
    dplyr::select(geoid, estimate)

readr::write_csv(df, out_path)
