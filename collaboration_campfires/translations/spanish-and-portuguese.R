library(ggplot2)

commits <-
    readr::read_csv(
        "collaboration_campfires/translations/4168b6fff27eafad68a4b134dba5c7d09e090fcb.csv"
    )


graph <- commits |>
    dplyr::filter(language %in% c("pt_BR", "es")) |>
    tidyr::pivot_longer(cols = c(n_translated, n_untranslated)) |>
    dplyr::mutate(
        name = dplyr::if_else(name == "n_translated", "Translated",
                              "Untranslated"),
        language = dplyr::if_else(language == "es", "Spanish", "Portuguese")
    )   |>
    ggplot() +
    geom_col(aes(fill = name, y = value, x = language), position = "dodge") +
    facet_wrap( ~ package,) +
    theme_bw() +
    scale_fill_manual(values = c("gray", "#CC0000")) +
    labs(x = "Language",
         y = "Number of translations",
         fill = "Status",
         title = "Translated and untranslated R messages in Portuguese and Spanish")


ggplot2::ggsave(filename = "collaboration_campfires/translations/graph.png", graph, dpi =  600, width = 8)
