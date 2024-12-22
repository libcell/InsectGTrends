################Obtain insect data information##############
##@Ncbi.csv is where NCBI downloads raw insect data
NCBI <- read.csv("/Users/jingsun/Desktop/NCBI.csv")

##Acquired chromosome number
NCBI$chromosome_count <- sapply(NCBI$Replicons, function(x) {
  # Use strsplit to split a string by semicolon
  chromosomes <- strsplit(x, ";")[[1]]
  # Count the part containing the 'chromosome' and 'linkage group'
  length(grep(c("chromosome","linkage group"), chromosomes))
})

##Acquired classified information
library(taxize)

Species_name <- NCBI[,]        # Species name extraction
Species_name <- c(Species_name)         # Convert to vector
Species_name <- trimws(Species_name)    # Remove the Spaces before and after the name

for (i in 1:length(Species_name)) {
  tryCatch({
    # Get taxonomic information about current species
    g1_list[[i]] <- tax_name(Species_name[i], get = c("order","family"), db = "ncbi")
    print(paste("Processed:", name[i]))
  }, error = function(e) {
    print(paste("Error processing:", name[i], "Error message:", e$message))
  })
  Sys.sleep(5)
}

# Merge data frame
NCBI <- merge(NCBI,g1_list,by = "Species_name")

##Acquired Mitochondrial size and N50
library(rentrez)
entrez_dbs()
#Get gene_id through Assembly
term <- NCBI$Assembly
for (term in term) {
  es <- entrez_search(db = "assembly", term = term)
  cat(es$ids, file = output_file, append = TRUE)
  cat("\n", file = output_file, append = TRUE)
}
close(output_ids)

#Obtain N50 and Mitochondrial size from gene_id
for (id in id) {
  es <- entrez_summary(db = "nuccore", id = id)
  writeLines(paste(es$organism, es$slen,es$contign50,es$scaffoldn50, sep = "\t"), output_ids)
}
close(output_ids)

#Merge data frame
NCBI <- merge(NCBI,output_ids,by = "Assembly")


##Obtain sequencing technology and sequencing depth
#Terminal operation
#ids <- read.csv("/*/Assembly.csv") 
#ids <- ids$Assembly
#for (i in ids) { 
#  commandline <- paste("datasets summary genome accession", i, ">>", "/*/results.txt") 
#  system(commandline) 
#}
data1 <- readLines("/*/results.txt")
ids <- read.csv("/*/assembly.csv")
ids <- ids$Assembly
mapping_table <- data.frame(Acession_number = ids,
                            Current_acession_number = rep(NA, length(ids)),
                            Genome_coverage = rep(NA, length(ids)))
for(i in 1:length(dat)) {
  text <- strsplit(dat[i], ",")[[1]]
  loc.ca <- grep("current_accession", text)
  loc.gc <- grep("genome_coverage", text)
  
  if (length(loc.ca) != 0) {
    ca <- text[loc.ca]
    loc.ca1 <- strsplit(ca, ":")[[1]][2]
    genomeCA <- gsub("\\\"", "", loc.ca1)
    mapping_table[i, 2] <- genomeCA
  }
  
  if (length(loc.gc) != 0) {
    gc <- text[loc.gc]
    loc.gc1 <- strsplit(gc, ":")[[1]][2]
    genomeGC <- gsub("\\\"", "", loc.gc1)
    mapping_table[i, 3] <- genomeGC
  }
  
  print("===================Start=============================================")
  print(genomeCA)
  print(genomeGC)
  print("===================End===============================================")
  Sys.sleep(0.1)
} 

NCBI <- merge(mapping_table,NCBI,by="Assembly",all.x = TRUE)



