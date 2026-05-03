# Data

All datasets for this paper are publicly archived on **Harvard Dataverse**.

**DOI:** [10.7910/DVN/FA75PH](https://doi.org/10.7910/DVN/FA75PH)

---

## Contents

| File | Description | Source |
|---|---|---|
| `onet_task_shares.csv` | O*NET v30.0 GWA Importance scores and d̂_s proxies for 5 occupations | O*NET Online v30.0 + code/onet_task_shares.R |
| `t_star_calibrations.csv` | T* values by sector under conservative and alternative baselines | code/t_star_calibrations.R |
| `pharma_pipeline_data.csv` | Phase I/II clinical trial success rates (historical vs. AI era) | Jayatunga et al. (2024); Paul et al. (2010); Hay et al. (2014) |

## Replication

```r
# Install dependencies
install.packages(c("tidyverse"))

# Run analyses
source("code/onet_task_shares.R")      # Table 2 + sensitivity
source("code/t_star_calibrations.R")   # Table 1 + Figure 2
```

See [REPLICATION.md](../replication/REPLICATION.md) for full instructions.

## License

CC BY 4.0 — [creativecommons.org/licenses/by/4.0](https://creativecommons.org/licenses/by/4.0/)

**Citation:**
> Lester, Ryan S. 2026. "Replication Data for: The Regime Boundaries of AI-Amplified Research." Harvard Dataverse. https://doi.org/10.7910/DVN/FA75PH
