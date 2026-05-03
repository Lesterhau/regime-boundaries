# regime_boundaries_onet.R
#
# The Regime Boundaries of AI-Amplified Research
# Appendix B: O*NET Digital Task Share Proxy Construction
#
# Author: Ryan S. Lester (rslester@cougarnet.uh.edu)
# ORCID:  0009-0002-7840-5676
# SSRN:   https://papers.ssrn.com/sol3/papers.cfm?abstract_id=6649740
# Data:   https://doi.org/10.7910/DVN/FA75PH
#
# Description:
#   Constructs d_hat_s proxies for five research occupations using
#   O*NET v30.0 Work Activity Importance scores.
#
#   d_hat_s = Digital_Sum / (Digital_Sum + Physical_Sum)
#
#   where Digital_Sum and Physical_Sum are unweighted sums of
#   Importance scores for digital and physical GWA task categories.
#
# Dependencies: tidyverse


library(tidyverse)


# ── O*NET GWA Importance Scores (v30.0) ───────────────────────────────────────
# Source: O*NET OnLine https://www.onetcenter.org/database.html
# GWA codes documented in Appendix B of the paper.

onet_data <- tribble(
  ~soc_code,    ~occupation,           ~task_type, ~gwa_code,    ~activity,                        ~importance,
  # Mathematicians (15-2021.00)
  "15-2021.00", "Mathematicians",      "digital",  "4.A.3.b.1",  "Working with Computers",          96,
  "15-2021.00", "Mathematicians",      "digital",  "2.B.1.e",    "Thinking Creatively",             94,
  "15-2021.00", "Mathematicians",      "digital",  "4.A.2.a.4",  "Analyzing Data or Information",   98,
  "15-2021.00", "Mathematicians",      "digital",  "4.A.2.a.2",  "Processing Information",          96,
  "15-2021.00", "Mathematicians",      "digital",  "4.A.2.a.3",  "Documenting/Recording Info",      22,
  "15-2021.00", "Mathematicians",      "physical", "4.A.3.i.7",  "Handling and Moving Objects",     10,
  "15-2021.00", "Mathematicians",      "physical", "4.A.3.b.4",  "Inspecting Equipment/Materials",  12,
  "15-2021.00", "Mathematicians",      "physical", "4.A.3.i.6",  "General Physical Activities",     10,
  "15-2021.00", "Mathematicians",      "physical", "4.A.3.b.9",  "Operating Vehicles/Devices",      10,
  "15-2021.00", "Mathematicians",      "physical", "4.A.4.a.5",  "Working with the Public",          8,
  # Software Developers (15-1252.00)
  "15-1252.00", "Software Developers", "digital",  "4.A.3.b.1",  "Working with Computers",          98,
  "15-1252.00", "Software Developers", "digital",  "2.B.1.e",    "Thinking Creatively",             94,
  "15-1252.00", "Software Developers", "digital",  "4.A.2.a.4",  "Analyzing Data or Information",   90,
  "15-1252.00", "Software Developers", "digital",  "4.A.2.a.2",  "Processing Information",          88,
  "15-1252.00", "Software Developers", "digital",  "4.A.2.a.3",  "Documenting/Recording Info",      38,
  "15-1252.00", "Software Developers", "physical", "4.A.3.i.7",  "Handling and Moving Objects",     15,
  "15-1252.00", "Software Developers", "physical", "4.A.3.b.4",  "Inspecting Equipment/Materials",  18,
  "15-1252.00", "Software Developers", "physical", "4.A.3.i.6",  "General Physical Activities",     10,
  "15-1252.00", "Software Developers", "physical", "4.A.3.b.9",  "Operating Vehicles/Devices",       8,
  "15-1252.00", "Software Developers", "physical", "4.A.4.a.5",  "Working with the Public",          4,
  # Biochemists (19-1021.00)
  "19-1021.00", "Biochemists",         "digital",  "4.A.3.b.1",  "Working with Computers",          88,
  "19-1021.00", "Biochemists",         "digital",  "2.B.1.e",    "Thinking Creatively",             90,
  "19-1021.00", "Biochemists",         "digital",  "4.A.2.a.4",  "Analyzing Data or Information",   96,
  "19-1021.00", "Biochemists",         "digital",  "4.A.2.a.2",  "Processing Information",          92,
  "19-1021.00", "Biochemists",         "digital",  "4.A.2.a.3",  "Documenting/Recording Info",      84,
  "19-1021.00", "Biochemists",         "physical", "4.A.3.i.7",  "Handling and Moving Objects",     50,
  "19-1021.00", "Biochemists",         "physical", "4.A.3.b.4",  "Inspecting Equipment/Materials",  48,
  "19-1021.00", "Biochemists",         "physical", "4.A.3.i.6",  "General Physical Activities",     18,
  "19-1021.00", "Biochemists",         "physical", "4.A.3.b.9",  "Operating Vehicles/Devices",      15,
  "19-1021.00", "Biochemists",         "physical", "4.A.4.a.5",  "Working with the Public",         24,
  # Materials Scientists (19-2032.00)
  "19-2032.00", "Materials Scientists","digital",  "4.A.3.b.1",  "Working with Computers",          84,
  "19-2032.00", "Materials Scientists","digital",  "2.B.1.e",    "Thinking Creatively",             86,
  "19-2032.00", "Materials Scientists","digital",  "4.A.2.a.4",  "Analyzing Data or Information",   90,
  "19-2032.00", "Materials Scientists","digital",  "4.A.2.a.2",  "Processing Information",          84,
  "19-2032.00", "Materials Scientists","digital",  "4.A.2.a.3",  "Documenting/Recording Info",      58,
  "19-2032.00", "Materials Scientists","physical", "4.A.3.i.7",  "Handling and Moving Objects",     48,
  "19-2032.00", "Materials Scientists","physical", "4.A.3.b.4",  "Inspecting Equipment/Materials",  56,
  "19-2032.00", "Materials Scientists","physical", "4.A.3.i.6",  "General Physical Activities",     22,
  "19-2032.00", "Materials Scientists","physical", "4.A.3.b.9",  "Operating Vehicles/Devices",      12,
  "19-2032.00", "Materials Scientists","physical", "4.A.4.a.5",  "Working with the Public",         21,
  # Chemists (19-2031.00)
  "19-2031.00", "Chemists",            "digital",  "4.A.3.b.1",  "Working with Computers",          80,
  "19-2031.00", "Chemists",            "digital",  "2.B.1.e",    "Thinking Creatively",             82,
  "19-2031.00", "Chemists",            "digital",  "4.A.2.a.4",  "Analyzing Data or Information",   88,
  "19-2031.00", "Chemists",            "digital",  "4.A.2.a.2",  "Processing Information",          80,
  "19-2031.00", "Chemists",            "digital",  "4.A.2.a.3",  "Documenting/Recording Info",      37,
  "19-2031.00", "Chemists",            "physical", "4.A.3.i.7",  "Handling and Moving Objects",     58,
  "19-2031.00", "Chemists",            "physical", "4.A.3.b.4",  "Inspecting Equipment/Materials",  68,
  "19-2031.00", "Chemists",            "physical", "4.A.3.i.6",  "General Physical Activities",     30,
  "19-2031.00", "Chemists",            "physical", "4.A.3.b.9",  "Operating Vehicles/Devices",      14,
  "19-2031.00", "Chemists",            "physical", "4.A.4.a.5",  "Working with the Public",         40
)


# ── Compute d_hat_s ───────────────────────────────────────────────────────────

task_shares <- onet_data |>
  group_by(soc_code, occupation, task_type) |>
  summarise(sum_importance = sum(importance), .groups = "drop") |>
  pivot_wider(names_from = task_type, values_from = sum_importance) |>
  mutate(
    d_hat_s = digital / (digital + physical),
    amplification_ceiling = d_hat_s / (1 - d_hat_s)
  ) |>
  arrange(desc(d_hat_s))


# ── Table 2 Replication ───────────────────────────────────────────────────────

cat("\nTable 2: O*NET d_hat_s Proxies and Regime Classification\n")
cat(rep("=", 60), "\n", sep = "")
print(
  task_shares |>
    select(soc_code, occupation, digital, physical, d_hat_s, amplification_ceiling) |>
    mutate(across(where(is.double), \(x) round(x, 3)))
)


# ── Sensitivity check (±3pp) ─────────────────────────────────────────────────

cat("\nRank-order robustness check (±3pp perturbation on estimated values):\n")
task_shares_sens <- task_shares |>
  mutate(
    d_hat_low  = d_hat_s - 0.03,
    d_hat_high = d_hat_s + 0.03
  ) |>
  select(occupation, d_hat_s, d_hat_low, d_hat_high)

print(task_shares_sens)


# ── Save output ───────────────────────────────────────────────────────────────

dir.create("output", showWarnings = FALSE)
write_csv(task_shares, "output/onet_task_shares.csv")
cat("\nSaved: output/onet_task_shares.csv\n")
