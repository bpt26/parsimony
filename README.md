# parsimony

This repository contains the input data, results, and analysis code to infer and optimize a SARS-CoV-2 tree using a variety of approaches including parsimony and maximum likelihood. Here I will keep detailed notes in the README.md files in each subdirectory.

I primarily use UShER and matUtils, which are both part of the UShER package that can be easily installed using the following code:

```
# Create a new environment for UShER
conda create -n usher-env
# Activate the newly created environment
conda activate usher-env
# Set up channels
conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge
# Install the UShER package
conda install usher
```

For more details on these programs, please see [the corresponding wiki](https://usher-wiki.readthedocs.io/en/latest/index.html).
