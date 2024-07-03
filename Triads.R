#!usr/bin/Rscript

homo <- read.delim("Sample.txt",header=T)
head(homo)
homo$D3_A_ratio<-homo$subA/(homo$subA+homo$subB+homo$subD)
homo$D3_B_ratio<-homo$subB/(homo$subA+homo$subB+homo$subD)
homo$D3_D_ratio<-homo$subD/(homo$subA+homo$subB+homo$subD)
  
homo$D3_condition = "Balanced"
homo$D3_condition[which(homo$D3_A_ratio <0.2)] = "A_supressed"
homo$D3_condition[which(homo$D3_B_ratio <0.2)] = "B_supressed"
homo$D3_condition[which(homo$D3_D_ratio <0.2)] = "D_supressed"
homo$D3_condition[which(homo$D3_B_ratio < 0.2&homo$D3_D_ratio < 0.2)] = "A_dominant"
homo$D3_condition[which(homo$D3_A_ratio < 0.2&homo$D3_D_ratio < 0.2)] = "B_dominant"
homo$D3_condition[which(homo$D3_A_ratio < 0.2&homo$D3_B_ratio < 0.2)] = "D_dominant"
Data=na.omit(homo)
write.table(Data,"Sample.Group.txt", sep = "\t", row.names = TRUE)
ggtern(Data,aes(x=D3_A_ratio,y=D3_B_ratio,z=D3_D_ratio)) + theme_rgbw() +geom_point(aes(color=D3_condition,size=0.1),alpha=0.5)+ggtitle("Sample.triads.Tn5")


