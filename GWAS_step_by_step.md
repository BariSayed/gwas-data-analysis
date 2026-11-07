# GWAS / LD Analysis — Step-by-step notes

Personal working notes for a hands-on Genome-Wide Association Studies (GWAS)
training, focused on linkage-disequilibrium (LD) decay analysis with
**PopLDdecay**, plus VCF/PLINK/Haploview data preparation.

> Personal server paths have been redacted to `/raid3/<user>/...`. Commands are
> kept as worked during the training; adapt file names/paths to your own data.

## Quick genotype inspection

```bash
# select the first 3 columns of a genotype VCF
cut -f1-3 genotype.vcf > genotype.xls
# PLINK binary location (example): /raid3/<user>/PLINK/plink
```

## Linkage disequilibrium (PopLDdecay)

Install PopLDdecay — see https://github.com/BGI-shenzhen/PopLDdecay

```bash
# Linux/Unix
tar -zxvf PopLDdecay-3.40.tar.gz
cd PopLDdecay-3.40/src
make ; make clean
../bin/PopLDdecay

# alternative download
wget https://github.com/BGI-shenzhen/PopLDdecay/archive/v3.40.tar.gz
tar -zxvf v3.40.tar.gz
cd PopLDdecay-3.40/src
sh make.sh
../bin/PopLDdecay
```

Run LD decay:

```bash
# standard form
./bin/PopLDdecay -InVCF SNP.vcf.gz -OutStat LDdecay
# worked example (run from inside bin/, single chromosome)
./PopLDdecay -InVCF chr1.vcf -OutStat LDdecay
#   -InVCF : input VCF (change to your file, e.g. chr1.vcf)
#   -OutStat : output prefix (no change needed)

# help
./PopLDdecay -h
```

Plot LD decay:

```bash
# standard
perl Plot_OnePop.pl -inFile LDdecay.stat.gz -output LD.graph
# per-chromosome example
perl Plot_OnePop.pl -inFile LDdecay.chr10.stat.gz -output LD.chr10.graph
```

## Haploview input preparation (PLINK + VCFtools)

```bash
# .tped for whole genome
nohup ../../biosoft/plink-1.09/plink \
  --vcf prepared.357subset.maf0.05.miss0.9.vcf \
  --allow-extra-chr --allow-no-sex --recode12 --transpose \
  --out prepared.357subset.maf0.05.miss0.9

# subset a region into a new VCF (example region on chr10)
nohup /raid3/<user>/vcftools_0.1.13/bin/vcftools \
  --vcf genotype.vcf --chr 10 --from-bp 13988043 --to-bp 14665106 \
  --recode --out chr10 &

# VCF -> PLINK .ped for a specific chromosome
nohup /raid3/<user>/vcftools_0.1.13/bin/vcftools \
  --vcf chr10.recode.vcf --plink --out chr10 &

# build .map, then .info file
cut -f2,4 genotype.map | sed 's/:/-/g' > genotype.info
cut -f2,4 chr10.map   | sed 's/:/-/g' > chr10.info
```

## LD decay plot (example output)

An example LD-decay plot (`LDDecay.png`) was produced from the training data.
The plot and all input/output data are **not** committed to this repository — see
the README and `.gitignore`.
