################Quality control##############
library(dplyr)
##The assembly level is Contig data
NCBI_contig <- NCBI %>%
  filter(Level == "Contig")

#LQ:Contig n50 < 100000
n50_contig_low <- NCBI_contig %>%
  filter(Contig.N50 < 100000) 
table(n50_contig_low$order)

#MQ:100000 < Contig n50 < 10000000
n50_contig_me <- NCBI_contig %>%
  filter(Contig.N50 > 100000 & Contig.N50 < 1000000)
table(n50_contig_me$order)

#HQ:1000000 < Contig n50 
n50_contig_hi <- NCBI_contig %>%
  filter(Contig.N50 > 1000000)
table(n50_contig_hi$order)


##The assembly level is Scaffold data
NCBI_scaffold <- NCBI %>%
  filter(Level =="Scaffold")

#LQ:Contig n50 < 100000
n50_scaffold_low <- NCBI_scaffold %>%
  filter(Scaffold.N50 < 1000000)
table(n50_scaffold_low$order)

#MQ:Contig n50 < 100000
n50_scaffold_me <- NCBI_scaffold %>%
  filter(Scaffold.N50 > 1000000)
table(n50_scaffold_me$order)

##The assembly level is Chromosome data
NCBI_chromosome <- NCBI %>%
  filter(Level =="Chromosome")

#HQ:Contig n50 < 1000000
n50_chromosome_low <- NCBI_chromosome %>%
  filter(Contig.N50 < 1000000 )
table(n50_chromosome_low$order)

#GQ:Contig n50 > 1000000
n50_chromosome_me <- NCBI_chromosome %>%
  filter(Contig.N50 > 1000000)
table(n50_chromosome_me$order)

##Merge data frame
NCBI_filtered <- rbind(n50_contig_me,n50_contig_hi,n50_scaffold_me,n50_chromosome_low,n50_chromosome_me)

