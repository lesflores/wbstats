# DATOS BANCO MUNDIAL - Ejemplo de indicador: EFECTIVIDAD DEL GOBIERNO

library(wbstats) # Acceso a datos del Banco Mundial-API
library(ggplot2)   
library(dplyr)     
library(scales)    

# ---------------------------
# 1. Lista de países
# ---------------------------

paises <- c(
  "ARG", "BOL", "BRA", "CHL", "COL", "CRI", "CUB", "DOM", "ECU", "SLV",
  "GTM", "HND", "HTI", "MEX", "NIC", "PAN", "PRY", "PER", "URY", "VEN",
  "USA", "CAN"
)

# ---------------------------
# 2. Descargar datos del indicador GE.EST (efectividad del gobierno)
# ---------------------------

datos <- wb_data(
  indicator = "GE.EST", # Indicador: Government Effectiveness (WGI)
  country = paises,
  start_date = 2010,
  end_date = 2023,
  return_wide = FALSE
)

# ---------------------------
# 3. Gráfica
# ---------------------------

ggplot(datos, aes(x = date, y = value, color = country)) +
  geom_line(size = 1.1) +
  facet_wrap(~ country, scales = "free_y") +
  scale_x_continuous(
    breaks = seq(2010, 2023, 1),
    expand = expansion(mult = c(0.01, 0.01))
  ) +
  scale_y_continuous(labels = number_format(accuracy = 0.1)) +
  scale_color_manual(
    values = rep(RColorBrewer::brewer.pal(12, "Set3"), length.out = length(unique(datos$country)))
  ) +
  labs(
    title = "Efectividad del gobierno",
    subtitle = "América Latina, EE. UU. y Canadá (2010–2023)",
    x = " ",
    y = "Valor (-2.5 a 2.5)",
    color = "País",
    caption = "Fuente: Worldwide Governance Indicators (WGI)"
  ) +
  theme_minimal(base_family = "Arial") +
  theme(
    plot.title = element_text(size = 18, face = "bold", color = "#2c3e50"),
    plot.subtitle = element_text(size = 13, color = "#555555"),
    plot.caption = element_text(size = 9, color = "#888888"),
    axis.title = element_text(size = 12, face = "bold"),
    axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1, size = 8),
    axis.text.y = element_text(size = 9),
    strip.text = element_text(size = 11, face = "bold", color = "#1a1a1a"),
    panel.grid.minor = element_blank(),
    legend.position = "none"
  )

