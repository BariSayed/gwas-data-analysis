# GWAS / LD-Decay Analysis

Code and worked notes from a **hands-on Genome-Wide Association Studies (GWAS)
training**, focused on **linkage-disequilibrium (LD) decay** analysis with
PopLDdecay, plus VCF → PLINK/Haploview data preparation and LD-decay plotting in R.

This repository was completed as a **training assignment**. It contains **only my
own code and notes** — see *Data & attribution* below.

> ⚠️ **No data is included in this repository.** The genotype/phenotype data
> (VCF, HapMap, kinship, population-structure, trait tables, LD `.stat.gz`, and all
> figures) belong to the course / instructor and are **not redistributed here**.

---

## Contents

| File | Description |
|------|-------------|
| `GWAS.R` | PopLDdecay install + LD-decay run + R (data.table / ggplot2) setup and plotting |
| `GWAS_step_by_step.md` | My step-by-step working notes: PopLDdecay, VCFtools region subsetting, PLINK/Haploview input prep |

## Workflow overview

```
Genotype VCF
     │
     ▼
PopLDdecay  ──►  LDdecay.stat.gz  ──►  Plot_OnePop.pl / R (ggplot2)  ──►  LD-decay plot
     │
     ├─ VCFtools  → region / per-chromosome subsets
     └─ PLINK     → .ped / .map / .tped  → Haploview
```

## Software

- **PopLDdecay** (LD decay) — https://github.com/BGI-shenzhen/PopLDdecay
- **VCFtools**, **PLINK** (VCF filtering / format conversion)
- **R**: data.table, ggplot2
- **Haploview** (LD block visualization)

## Expected data (not committed)

The scripts expect genotype/phenotype inputs such as `vcf.vcf`,
`mdp_genotype*.hmp.txt`, `mdp_kinship.txt`, `mdp_phenotype.txt`,
`mdp_population_structure.txt`, `mdp_traits.*`, and produce `LDDecay.stat.gz` /
`LDDecay.png`. All of these are excluded via [`.gitignore`](.gitignore).

## Data & attribution

> **Please update the bracketed fields below before sharing.**

- **Training / course:** A Hands-on Training on Genome-Wide Association Studies (GWAS) Data Analysis
- **Organizer / instructor:** _[organizing centre / instructor]_
- **Date:** March 2025

The **genotype, phenotype and related data are the property of the course /
instructor** and are **not included** in this repository. This repository contains
only the analysis code and my own working notes. No raw data, instructor
presentation materials, promotional materials, or other participants' personal
information are redistributed here.

## License

The **code and notes** in this repository are released under the
[MIT License](LICENSE); this applies only to the material authored here, not to any
data or third-party materials.
