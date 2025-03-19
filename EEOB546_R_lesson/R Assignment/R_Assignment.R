library(dplyr)
library(tidyverse)
library(reshape2)
library(naniar)
library(ggplot2)

fang <- read.table("https://raw.githubusercontent.com/EEOB-BioData/BCB546_Spring2025/refs/heads/main/assignments/UNIX_Assignment/fang_et_al_genotypes.txt", header=T, sep="\t")
View(fang)

snp <- read.table("https://raw.githubusercontent.com/EEOB-BioData/BCB546_Spring2025/refs/heads/main/assignments/UNIX_Assignment/snp_position.txt", header=TRUE, sep="\t")
View(snp)


dim(fang)
str(fang)
sapply(fang, class)
colnames(fang)[1:5]


Extracted_Maize <- filter(fang, Group %in% c("ZMMIL","ZMMLR","ZMMMR"))
view(Extracted_Maize)

Extracted_Teosinte <- filter(fang, Group %in% c("ZMPBA","ZMPIL","ZMPJA"))
view(Extracted_Teosinte)


Filtered_SNP <- snp[ , c("SNP_ID", "Chromosome", "Position")] 
Extracted_Maize <- Extracted_Maize[,!names(Extracted_Maize) %in% c("JG_OTU", "Group")]
Extracted_Teosinte <- Extracted_Teosinte[,!names(Extracted_Teosinte) %in% c("JG_OTU", "Group")]

colnames(Extracted_Maize)[1] <- "SNP_ID"
colnames(Extracted_Teosinte)[1] <- "SNP_ID"

Transposed_Maize <- t(Extracted_Maize)
Transposed_Teosinte <- t(Extracted_Teosinte)

colnames(Transposed_Maize) <- Transposed_Maize[1, ] 
colnames(Transposed_Teosinte) <- Transposed_Teosinte[1, ] 

Merged_SNP_Maize <- merge(Filtered_SNP, Transposed_Maize, by.x = "SNP_ID", by.y = "row.names")
Merged_SNP_Teosinte <- merge(Filtered_SNP, Transposed_Teosinte, by.x = "SNP_ID", by.y = "row.names")

nrow(Filtered_SNP)
nrow(Transposed_Maize)
nrow(Transposed_Teosinte)

Merged_SNP_Maize <- tibble::as_tibble(Merged_SNP_Maize)

sapply(Merged_SNP_Maize, mode)

Merged_SNP_Maize$Position <- suppressWarnings(as.numeric(as.character(Merged_SNP_Maize$Position)))
Merged_SNP_Maize <- Merged_SNP_Maize[!is.na(Merged_SNP_Maize$Position), ]

sapply(Merged_SNP_Maize, mode)



dir.create('./increasing_maize')

Process_Chromosome <- function(i) {
  Chromosome_Maize <- filter(Merged_SNP_Maize, Chromosome == i)
  
  Chromosome_Maize_inc <- Chromosome_Maize %>% arrange(Position)
  
  Chromosome_Maize_inc[Chromosome_Maize_inc == "?/?"] <- "?"
  
  write.table(Chromosome_Maize_inc, file = paste("/increasing_maize_", i, ".txt"), quote = FALSE, sep = "\t", row.names = FALSE)
}

sapply(1:10, Process_Chromosome)

Maize_Chromosome <- read.table("C:/Users/viraa/Documents/BCB546_Spring2025/EEOB546_R_lesson/R Assignment/increasing_maize/increasing_maize_1.txt", 
                          header = TRUE, sep = "\t", stringsAsFactors = FALSE)

View(Maize_Chromosome)
