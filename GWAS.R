# Load libraries
# code
../bin/PopLDdecay -InVCF ~/gwas/vcf.vcf -OutStat ~/gwas/LDDecay.stat.gz

# Set a CRAN mirror (e.g., USA)
options(repos = c(CRAN = "https://cloud.r-project.org"))

# Then install the packages
install.packages("data.table")
install.packages("ggplot2")

library(data.table)
library(ggplot2)

# Conda environment create
conda activate gwas_env

# install dependencies
conda install -c conda-forge gcc_linux-64 gxx_linux-64 zlib


# Download PopLDdecay
# Option 1: GitHub clone
git clone https://github.com/hewm2008/PopLDdecay.git
cd PopLDdecay
chmod 755 configure
./configure
make
mv PopLDdecay bin/

# Option 2: .tar.gz file
wget https://github.com/BGI-shenzhen/PopLDdecay/releases/download/v3.40/PopLDdecay-3.40.tar.gz
tar -zxvf PopLDdecay-3.40.tar.gz
cd PopLDdecay-3.40/src
make
make clean

# Test the installation
../bin/PopLDdecay -h

# Run LD analysis
../bin/PopLDdecay -InVCF ~/gwas/vcf.vcf -OutStat ~/gwas/LDDecay.stat.gz

# Generate LD decay plot
perl ../bin/Plot_OnePop.pl -inFile ~/gwas/LDDecay.stat.gz -output ~/gwas/LDDecay

# Insructions for R code
# Notes:
# Make sure the paths are correct relative to src. ../bin/PopLDdecay points to the compiled program.
# The output .png and .pdf will be saved wherever you specify with -output.
# If you have multiple populations or chromosomes, follow the same structure but use -SubPop and/or a list of .stat.gz files as described in the manual.