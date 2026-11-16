sysfonts::font_add_google("Source Sans 3")
showtext::showtext_auto()
showtext::showtext_opts(dpi = 150)

theme_din <- function(base_family = "Source Sans 3", base_size = 14, ...) {
    stylehaven::theme_din(
        base_family = base_family,
        base_size = base_size,
        ...
    ) +
        ggplot2::theme(
            plot.title = ggtext::element_textbox_simple(
                lineheight = 0.85,
                margin = ggplot2::margin(0.2, 0, 0.2, 0, "lines")
            ),
            plot.subtitle = ggtext::element_textbox_simple(
                lineheight = 0.95,
                margin = ggplot2::margin(0.2, 0, 0.5, 0, "lines")
            ),
            plot.caption = ggtext::element_textbox_simple(
                lineheight = 0.85,
                margin = ggplot2::margin(0.5, 0, 0, 0, "lines"),
                hjust = 1
            ),
            legend.text = ggplot2::element_text(
                margin = ggplot2::margin(0, 0.4, 0, 0.4, "lines")
            ),
            axis.text = ggplot2::element_text(lineheight = 1.05),
            strip.text.x = ggplot2::element_text(hjust = 0),
            plot.caption.position = "plot"
        )
}
# pal_mtx <- stylehaven::palx("#2828ddff", n_hues = 11, n_shades = 6)
# qual_pal <- unname(c(
#     pal_mtx[["shade03"]][c("gray")],
#     pal_mtx[["shade03"]][c("violet")],
#     pal_mtx[["shade04"]][c("cyan", "orange")],
#     pal_mtx[["shade04"]][c("red", "green")]
# ))
qual_pal <- rcartocolor::carto_pal(name = "Vivid")
qual_pal <- c("gray40", qual_pal[1:11])

seq_pal <- RColorBrewer::brewer.pal(n = 5, name = "YlGnBu")

tf_pal <- c("TRUE" = "gray30", "FALSE" = "white")

ggplot2::theme_set(theme_din(ygrid = FALSE, base_size = 15))
ggplot2::update_geom_defaults(
    "text",
    list(
        family = "Source Sans 3",
        color = "white",
        fontface = "bold",
        size = 3.5
    )
)
ggplot2::update_geom_defaults("col", list(fill = qual_pal[4]))
ggplot2::update_geom_defaults("histogram", list(fill = qual_pal[4]))
