dfs <- list()

food_read <- dcws::fetch_cws(
    grepl("^Have there been times .+ food", question),
    .unnest = TRUE
) |>
    dplyr::filter(grepl("^\\d{4}$", span)) |>
    dcws::sub_nonanswers() |>
    dplyr::filter(response == "Yes") |>
    dplyr::mutate(value = round(value, 2)) |>
    dplyr::mutate(
        group2 = ifelse(
            as.character(group) == name,
            "Total",
            as.character(group)
        ) |>
            forcats::as_factor()
    )

dfs[["food_trend_state"]] <- food_read |>
    dplyr::filter(name == "Connecticut") |>
    dplyr::filter(
        group2 %in%
            c(
                "Total",
                "White",
                "Black",
                "Latino",
                "No kids",
                "Kids in home"
            )
    )

dfs[["food_demo_gnh"]] <- food_read |>
    dplyr::filter(
        name %in%
            c(
                "Connecticut",
                "Greater New Haven",
                cwi::regions[["Greater New Haven"]]
            ),
        year == 2024
    ) |>
    dplyr::filter(
        category %in%
            c(
                "Total",
                "Gender",
                "Age",
                "Race/Ethnicity",
                "Education",
                "Income",
                "With children",
                "Sexual orientation & gender identity",
                "Place of birth"
            )
    )

dfs[["food_total_towns"]] <- food_read |>
    dplyr::filter(name %in% cwi::xwalk$town, category == "Total", year == 2024)

purrr::iwalk(dfs, function(df, id) {
    path <- file.path("data", sprintf("dcws_%s.csv", id))
    readr::write_csv(df, path)
})
