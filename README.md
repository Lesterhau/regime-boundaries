# The Regime Boundaries of AI-Amplified Research: Task Complementarity, Physical Validation, and the Limits of Semi-Endogenous Growth

[![SSRN](https://img.shields.io/badge/SSRN-6649740-blue?style=flat-square)](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=6649740)
[![Harvard Dataverse](https://img.shields.io/badge/DOI-10.7910%2FDVN%2FFA75PH-C90016?style=flat-square)](https://doi.org/10.7910/DVN/FA75PH)
[![ORCID](https://img.shields.io/badge/ORCID-0009--0002--7840--5676-A6CE39?style=flat-square&logo=orcid)](https://orcid.org/0009-0002-7840-5676)
[![License: CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey?style=flat-square)](https://creativecommons.org/licenses/by/4.0/)

**Author:** Ryan S. Lester · University of Houston, Department of Economics · rslester@cougarnet.uh.edu

**Working Paper — April 2026** | Under consideration for BUPA (Best Undergraduate Paper Award)

---

## Abstract

Two facts organize this paper.

In July 2025, Gemini Deep Think achieved a gold-medal score on the International Mathematical Olympiad. Over the same period, FrontierMath — problems requiring hours to days for expert human mathematicians — moved from 2% to 40% AI success in fourteen months. In formalized mathematics, AI systems now complete the full research cycle: conjecture, proof search, and verification.

In pharmaceutical drug discovery over the same period, AI-assisted lead identification drove Phase I clinical trial success rates from a historical 40–65% to 80–90%. Phase II efficacy rates — where a drug must demonstrate therapeutic effect in human patients — remained approximately 40%, unchanged from historical baselines.

These two facts are not anomalies. They are the predicted consequence of a structural feature that semi-endogenous growth theory has not formalized: **research is a two-stage process, and AI scales those stages differently.**

This paper derives the regime conditions under which Jones (1995) survives intact, under which it is temporarily exceeded, and under which it is permanently dissolved. The answer: Jones survives as the universal long-run attractor everywhere except where validation can be executed digitally and mechanically verified. AI does not rewrite the Jones equation. It extends how long sectors spend above it — and permanently dissolves the ceiling only where proof assistants make validation costless.

---

## Central Result

**Three formal contributions:**

**Theorem 1 — Bounded Amplification under Task Complementarity.** AI amplification of effective research labor is bounded by a complementarity ceiling d_s/(1−d_s) that depends on the sector's digital task share, not AI capacity. Once AI capacity exceeds this ceiling, additional investment cannot raise effective research labor.

**Theorem 2 — Steady-State Bifurcation.** Sectors bifurcate based on whether their validation-stage digital task share d_V_s exceeds a time-varying threshold d_V*(t) = Φ(t)/(1+Φ(t)):
- **Regime I** (d_V_s ≤ d_V*): Validation ceiling binds. BGP growth rate = Jones exactly: λn/(1−φ)
- **Regime II** (d_V_s > d_V*): AI capital scales validation labor. BGP growth rate strictly exceeds Jones: λ[αg_K + (1−α)n]/(1−φ)

**Corollary 2.1 — Regime II Transience.** For any sector with finite d_V_s < 1, the threshold eventually crosses d_V_s and the sector returns to the Jones attractor. Regime II is extended — potentially decades — but transient. Under baseline calibration (α=0.3, g_K=0.30, n=0.01), the excess growth above Jones is approximately 8.7 percentage points per year during Regime II.

**Lemma 1 — The Mechanical Verification Case.** Only at d_V_s = 1 — where validation is fully mechanical, established for formalized mathematics (Lean 4, Coq, Isabelle/HOL) — is Regime II permanent. The Jones constraint never reasserts. T* → ∞.

**Proposition 2 — Measurement Wedge.** Partially explains the Bloom et al. (2020) finding of declining research productivity: as AI capital grows in Regime I sectors, R&D expenditure rises while validated output stays capped by the validation ceiling, generating a systematic downward bias in expenditure-based productivity measures.

---

## The Two-Stage Decomposition

The paper contests the hidden aggregation assumption in Jones (1995): that AI augmentation applies uniformly to all research tasks. It doesn't.

| Stage | Examples | AI Scalability |
|---|---|---|
| **Generation** | Hypothesis search, compound generation, proof attempts, candidate selection | High — AI raises μᴳ toward ceiling dᴳ/(1−dᴳ) |
| **Validation** | Clinical trials, lab synthesis, human peer review, physical measurement | Bounded — μᵛ bounded by dᵛ/(1−dᵛ) |

When d_G_s > d_V_s — when generation tasks are more digitally executable than validation tasks — AI raises generation capacity faster than validation throughput. Validated output is bounded by the validation ceiling regardless of how fast generation grows.

---

## Empirical Evidence

### Pharmaceuticals: Regime I (d_V_s ≈ 0.10)

The null model (symmetric AI amplification) predicts both Phase I and Phase II success rates rise proportionally. Regime I predicts Phase I rises, Phase II stays flat. The data reject the null model.

| Metric | Historical Baseline | AI Era (post-2020) | Ratio |
|---|---|---|---|
| Phase I success rate | ~52% | ~85% | 1.63× ↑ |
| Phase II efficacy rate | ~35% | ~40% | 1.14× (flat) |

*Source: Jayatunga et al. (2024); historical baselines from Paul et al. (2010) and Hay et al. (2014)*

### Formalized Mathematics: Permanent Regime II (d_V_s = 1)

Proof verification by Lean/Coq is a decidable mechanical task requiring only digital computation. The complementarity ceiling diverges. T* → ∞.

- **IMO:** AlphaProof silver (2024) → Gemini Deep Think gold (2025) — ~1.86× per year
- **miniF2F:** Near-saturation at 99.2%
- **FrontierMath:** 2% → 40% AI success in 14 months
- **Lean benchmark:** AI completes 74.2% of proof steps (Leeman et al. 2024)

---

## T* Calibrations: When Does Regime II End?

Parameters: α = 0.3, g_K = 0.30, n = 0.01

| Sector | d_V_s | Amplification Ceiling | T* (conservative) | T* (alternative) |
|---|---|---|---|---|
| Formalized mathematics | 1.00 | ∞ | ∞ | ∞ |
| Software engineering | 0.70 | 2.33 | ~36 years | ~18 years |
| Materials science | 0.30 | 0.43 | ~17 years | Already Regime I |
| Biochemistry | 0.15 | 0.18 | ~7 years | Already Regime I |
| Pharmaceuticals (validation) | 0.10 | 0.11 | ~1 year (boundary) | Already Regime I |

---

## O*NET Cross-Sector Validation

Digital task share proxies (d̂_s) constructed from O*NET v30.0 Work Activity Importance scores using digital (analyzing data, working with computers, processing information) vs. physical (handling objects, inspecting equipment, general physical activities) task weights.

| Occupation | SOC Code | d̂_s | Regime (Theory) |
|---|---|---|---|
| Mathematicians | 15-2021.00 | 0.890 | Permanent Regime II (Lemma 1) |
| Software Developers | 15-1252.00 | 0.881 | Transient Regime II (~36 yrs) |
| Biochemists | 19-1021.00 | 0.744 | Near transition (~7 yrs) |
| Materials Scientists | 19-2032.00 | 0.717 | Approaching transition |
| Chemists | 19-2031.00 | 0.636 | Regime I |

Rank ordering is consistent with the framework across all sensitivity checks. Full methodology in Appendix B of the paper.

---

## Key Theoretical Antecedents

| Paper | Contribution to This Work |
|---|---|
| Jones (1995) — *JPE* | Semi-endogenous growth baseline; the universal long-run attractor this paper characterizes the conditions for exceeding |
| Bloom, Jones, Van Reenen & Webb (2020) — *AER* | Declining research productivity documentation; Proposition 2 offers a partial AI-era explanation |
| Acemoglu & Restrepo (2018, 2020) — *AER*/*JPE* | Task-based automation framework; task complementarity structure of Theorem 1 |
| Romer (1990) — *JPE* | Endogenous growth baseline |
| Aghion, Jones & Jones (2017) — *NBER* | AI in growth theory; present paper's distinct contribution is the generation-validation decomposition |
| Gans (2025) — *NBER 33907* | AI-driven threshold effects in knowledge; this paper differs by making regime boundaries depend on validation-stage task structure, not AI capability level |

---

## Data & Replication

All data and code for the O*NET analysis (Section 7, Appendix B) and T* calibrations (Table 1) are publicly archived on Harvard Dataverse:

**DOI:** [10.7910/DVN/FA75PH](https://doi.org/10.7910/DVN/FA75PH)

Pharmaceutical pipeline data are from Jayatunga et al. (2024) and documented in the replication archive. All formal results are analytic; proofs are in the paper appendices.

---

## Repository Structure

```
regime-boundaries/
├── paper/
│   └── regime_boundaries_v5.pdf
├── data/
│   └── README_dataverse.md              # Harvard Dataverse documentation
├── code/
│   ├── onet_task_shares.R               # O*NET d̂_s proxy construction (Appendix B)
│   ├── t_star_calibrations.R            # T* calibration table (Table 1)
│   └── regime_boundary_figure.py        # Figure 2: regime boundary dynamics
└── replication/
    └── REPLICATION.md
```

---

## Status

| Milestone | Status |
|---|---|
| Paper (v5) | ✅ Complete |
| Harvard Dataverse DOI | ✅ Active — [10.7910/DVN/FA75PH](https://doi.org/10.7910/DVN/FA75PH) |
| SSRN posting | ✅ Live — [abstract_id=6649740](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=6649740) |
| BUPA submission | ⏳ Targeting mid-May 2026 |
| Journal submission | 📋 Planned |

---

## Citation

```bibtex
@unpublished{lester2026regime,
  author  = {Lester, Ryan S.},
  title   = {The Regime Boundaries of AI-Amplified Research: Task Complementarity, 
             Physical Validation, and the Limits of Semi-Endogenous Growth},
  year    = {2026},
  note    = {Working Paper. SSRN 6649740.},
  url     = {https://papers.ssrn.com/sol3/papers.cfm?abstract_id=6649740},
  doi     = {10.7910/DVN/FA75PH}
}
```

---

## Related Work

- [Rational Foreclosure](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=6614858) — behavioral companion: what happens when people rationally abandon aspirations as the benchmark drifts beyond reach
- [Leftists! Governments and AI Companies Are Designing Your Future Without You](https://rlperspectives.substack.com/p/leftists-governments-and-ai-companies) — public-facing essay on AI adoption, power, and who gets to be in the room

---

**Ryan S. Lester** · rslester@cougarnet.uh.edu · [ORCID](https://orcid.org/0009-0002-7840-5676) · [RL Perspectives](https://rlperspectives.com)
