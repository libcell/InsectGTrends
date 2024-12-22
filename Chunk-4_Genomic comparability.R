#########################Comparability analysis####################
###Different assembly levels
##Get data for each assembly level
fi_contig <- NCBI %>%
  filter(Assembly_Level == "Contig")

fi_scaffold <- NCBI %>%
  filter(Assembly_Level == "Scaffold")

fi_Chromosome <- NCBI %>%
  filter(Assembly_Level== "Chromosome")

#Draw a box map of the genome features in turn
#@data = fi_contig/fi_scaffold/fi_Chromosome
#@y=Genome_size/GC/Genes/CDS/ncRNA
p <- ggplot(data, aes(x=order, y=ncRNA,color=order)) + 
  stat_boxplot(geom="errorbar",width=0.5,size=0.8)+
  geom_boxplot(outlier.shape = 8,outlier.size = 0.5,linewidth=1.2)+
  geom_jitter(shape=16,size=1.2,alpha=0.15,position = position_jitter(0.4))+
  theme_classic()+
  theme(legend.position = "none",
        axis.text.x = element_text(angle = 45, hjust = 1, size = 14), # X 轴字体
        axis.text.y = element_text(size = 14), # Y 轴字体
        axis.title.x = element_blank(), # 移除 X 轴标签
        axis.title.y = element_blank())

###Different sequencing depths
NCBI$Genome_coveraged <- as.numeric(gsub("x", "", NCBI$Genome_coverage))
#low, medium, and high are distinguished
NCBI$NCBI <- cut(NCBI$Genome_coveraged, 
                    breaks = c(15, 50, 100, Inf), 
                    labels = c("Low", "Medium", "High"),
                    right = FALSE,  
                    include.lowest = TRUE)

fi_low <- NCBI %>%
  filter(Genome_coveraged == "Low")

fi_medium <- NCBI %>%
  filter(Genome_coveraged == "Medium")

fi_high <- NCBI %>%
  filter(Genome_coveraged== "High")

library(ggplot2)
#Draw a box map of the genome features in turn
#@data = fi_low/fi_medium/fi_high
#@y=Genome_size/GC/Genes/CDS/ncRNA
p <- ggplot(data, aes(x=order, y=ncRNA, color=order)) + 
  stat_boxplot(geom="errorbar", width=0.5, size=0.8) + 
  geom_boxplot(outlier.shape = 8, outlier.size = 0.5, linewidth=1.2) + 
  geom_jitter(shape=16, size=1.2, alpha=0.15, position = position_jitter(0.4)) + 
  theme_classic() + 
  theme(legend.position = "none",
        axis.text.x = element_text(angle = 45, hjust = 1, size = 14), # X 轴字体
        axis.text.y = element_text(size = 14), # Y 轴字体
        axis.title.x = element_blank(), # 移除 X 轴标签
        axis.title.y = element_blank())
p1
