# t_star_calibrations.R
#
# The Regime Boundaries of AI-Amplified Research
# Table 1: T* Calibrations by Sector
#
# Author: Ryan S. Lester | SSRN 6649740 | doi:10.7910/DVN/FA75PH
#
# Description:
#   Computes T* — the time at which a sector transitions from Regime II
#   back to the Jones (1995) semi-endogenous growth attractor — for five
#   research sectors under two baseline calibrations.
#
#   Formula (Corollary 2.1):
#   T* = (1 / alpha*(g_K - n)) * log(ceiling / Phi_0)
#   where ceiling = d_V_s / (1 - d_V_s) and Phi_0 = (K_AI_0 / H_0)^alpha


library(tidyverse)


# ── Parameters ────────────────────────────────────────────────────────────────

params_conservative <- list(
  alpha = 0.30,
  g_K   = 0.30,
  n     = 0.01,
  Phi_0 = 0.10    # conservative: (K_AI_0 / H_0)^alpha
)

params_alternative <- list(
  alpha = 0.30,
  g_K   = 0.30,
  n     = 0.01,
  Phi_0 = 0.50    # alternative: higher initial AI capital intensity
)


# ── Sector validation-stage digital task shares ───────────────────────────────

sectors <- tribble(
  ~sector,                    ~d_V_s,
  "Formalized mathematics",    1.00,
  "Software engineering",      0.70,
  "Materials science",         0.30,
  "Biochemistry",              0.15,
  "Pharmaceuticals (val.)",    0.10
)


# ── T* computation ────────────────────────────────────────────────────────────

compute_t_star <- function(d_V_s, params) {
  alpha <- params$alpha
  g_K   <- params$g_K
  n     <- params$n
  Phi_0 <- params$Phi_0

  if (d_V_s >= 1.0) return(Inf)

  ceiling_val <- d_V_s / (1 - d_V_s)
  if (ceiling_val <= Phi_0) return(0)  # already in Regime I

  t_star <- (1 / (alpha * (g_K - n))) * log(ceiling_val / Phi_0)
  return(t_star)
}


# ── Table 1 Replication ───────────────────────────────────────────────────────

results <- sectors |>
  mutate(
    ceiling        = ifelse(d_V_s >= 1, Inf, d_V_s / (1 - d_V_s)),
    t_star_cons    = map_dbl(d_V_s, compute_t_star, params = params_conservative),
    t_star_alt     = map_dbl(d_V_s, compute_t_star, params = params_alternative),
    t_star_cons_fmt = case_when(
      is.infinite(t_star_cons) ~ "∞",
      t_star_cons == 0         ~ "Already Regime I",
      TRUE                     ~ paste0("~", round(t_star_cons, 0), " yrs")
    ),
    t_star_alt_fmt = case_when(
      is.infinite(t_star_alt) ~ "∞",
      t_star_alt == 0         ~ "Already Regime I",
      TRUE                    ~ paste0("~", round(t_star_alt, 0), " yrs")
    )
  )

cat("\nTable 1: T* Calibrations by Sector\n")
cat("Parameters: alpha=0.3, g_K=0.30, n=0.01\n")
cat(rep("=", 72), "\n", sep = "")
print(
  results |>
    select(sector, d_V_s, ceiling, t_star_cons_fmt, t_star_alt_fmt) |>
    rename(
      "Sector"           = sector,
      "d_V_s"            = d_V_s,
      "Ceiling"          = ceiling,
      "T* (conservative)" = t_star_cons_fmt,
      "T* (alternative)"  = t_star_alt_fmt
    )
)


# ── Figure 2: Regime Boundary ─────────────────────────────────────────────────

phi_grid <- seq(0, 5, by = 0.01)
threshold <- phi_grid / (1 + phi_grid)

sector_colors <- c(
  "Formalized mathematics" = "#1f4e79",
  "Software engineering"   = "#2e75b6",
  "Materials science"      = "#70ad47",
  "Biochemistry"           = "#ffc000",
  "Pharmaceuticals (val.)" = "#c00000"
)

plot_df <- tibble(Phi = phi_grid, threshold = threshold)

p <- ggplot(plot_df, aes(x = Phi, y = threshold)) +
  geom_line(color = "black", lwd = 1.2) +
  geom_ribbon(aes(ymin = threshold, ymax = 1),
              fill = "#d6e4f0", alpha = 0.5) +
  annotate("text", x = 4, y = 0.92, label = "Regime II\n(Capital-driven)",
           color = "#1f4e79", fontface = "bold", size = 3.5) +
  annotate("text", x = 4, y = 0.60, label = "Regime I\n(Jones attractor)",
           color = "gray40", size = 3.5) +
  geom_hline(data = sectors,
             aes(yintercept = d_V_s, color = sector),
             lty = "dashed", lwd = 0.8) +
  scale_color_manual(values = sector_colors, name = "Sector") +
  labs(
    x     = "AI Capital Intensity Φ(t) = (K_AI/H)^α",
    y     = "Digital Task Share d_V_s",
    title = "Figure 2: The Regime Boundary",
    subtitle = "Threshold d_V*(t) = Φ/(1+Φ) rises as AI capital grows.\nSectors above the curve are in Regime II; sectors below are in Regime I."
  ) +
  theme_minimal(base_size = 11) +
  theme(legend.position = "right")

dir.create("output", showWarnings = FALSE)
ggsave("output/figure2_regime_boundary.png", p, width = 8, height = 5, dpi = 150)
cat("\nSaved: output/figure2_regime_boundary.png\n")

# Save Table 1
write_csv(results, "output/t_star_calibrations.csv")
cat("Saved: output/t_star_calibrations.csv\n")
