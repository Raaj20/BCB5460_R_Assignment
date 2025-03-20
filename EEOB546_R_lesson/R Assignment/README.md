# BCB_5460_R_Assignment --\> Viraaj

## Data and Packages

Initial datasets for this assignment were linked directly to the course's GitHub page. -fang_et_al_genotypes.txt -snp_position.txt

They can be found here:<https://github.com/EEOB-BioData/BCB546_Spring2025/tree/main/assignments/UNIX_Assignment>

The packages required are the following: dplyr, tidyverse, reshape2, naniar, ggplot2, readr.

Please ensure these packages are installed and loaded.

## Data Inspection

The following functions were performed to inspect both datasets. - dim --\> To view the number of rows and columns.\
- str --\> To identify the type of vector the provided datasets belong to.\
- class --\> The columns were listed to inspect the type of vector each were.\
- colnames --\> The first five columns were then printed.\

## Data Processing

### Extracting and Processing

-   Subsets of SNPs based on specific groups were created
    -   Maize groups- `ZMMIL`, `ZMMLR`, `ZMMMR`.\
    -   Teosinte groups- `ZMPBA`, `ZMPIL`, `ZMPJA`.\
-   Removed unwanted columns (e.g., `"JG_OTU"`, `"Groups"`).
-   Renaming columns for clarity(e.g., `"SNP_ID"`). This helped to ensure the perfect matching of datasets while merging.

### Transposing and Merging

-   Transposing extracted Maize and Teosinte datasets using the `"t()"` function and merging with SNP positions.
-   Before sorting, the "Position" variable was transformed from a "character" to a "numeric" vector.
-   Missing or erroneous `"NA"` values from cleaning the datasets were removed.

### Sorting Files

-   Once the files were merged, the SNPs were sorted by chromosome and position in increasing and decreasing order.
-   All the sorted files were saved in the directory (`./increasing_maize/`, `./decreasing_maize/`) as .txt files.
-   The `"sapply()"` function was used instead of the `"for"` loop to improve processing efficiency.
-   The sorted files can now be checked by using the code `"read.table("./increasing_maize/increasing_maize1")"` and can be edited for specificity.

## Visualization

### SNP Distribution Across Chromosomes

-   Sub-setting a combined Maize and Teosinte SNP dataset from the original `"fang"` dataset.\
-   Transposing using `"t()"` function Generates bar plots showing the distribution of SNPs across chromosomes.\
-   Using `"pivot_longer"` to reshape SNP data, to analyze SNP distributions across different groups.

### Comparison of SNPs in Maize vs. Teosinte

-   Pivoting the original `"fang"` dataset and subsetting it again to a combined Maize and Teosinte file based on Groups.
-   Merging with Filtered SNPs and adding a column with the `"mutate()"` function to include the SNP type, i.e., Maize or Teosinte.
-   Finally, segregating data using the `"if_else()"` function based on the type.

### Homozygous vs. Heterozygous

-   Classifies SNPs into homozygous (`A/A`, `T/T`, `G/G`, `C/C`) and heterozygous categories using the `"mutate()"` and `"if_else()"` functions.\
-   Visualize SNP variation within and between Maize and Teosinte samples.

### Missing Data

-   Detects missing SNP data within Maize and Teosinte samples by searching for `"NA"` values.
-   It uses `"if_else()"` to classify whether values are missing, allowing for easier display.

### SNP Proportion Pie Charts

-   Using pie charts to show the proportional contribution of each group within Maize and Teosinte samples.\
-   The `"coord_polar()"` converts bar plots to pie charts while `"facet_wrap()"` displays both types side-by-side.

### End of R_Assignment :)
