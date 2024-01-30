## breast cancer tissue sections
## serial tissue sections
## both datasets are looking at the same structure/region

data1 <- read.csv('pikachu.csv.gz', row.names = 1)
dim(data1) ## ~17000 cells
ncol(data1) ## ~300 genes 
## nucleus area estimated from DAPI segmentation
## cell area estimated from dilating around nucleus
## aligned x y are cell centroid positions
data1[1:10,1:10]
colnames(data1)

data2 <- read.csv('eevee.csv.gz', row.names = 1)
dim(data2)
data2[1:10,1:10]
colnames(data2)
## ~18000 genes
## ~700 spots

## look at your data
## compare a neighbor (different pokemon)
## infer what are the columns corresponding to, data #

data <- data2
library(ggplot2)
ggplot(data) + 
  geom_point(aes(x=aligned_x, 
                 y=aligned_y,
                 col = log10(CD4+1)), 
             size=2,
             shape=15
             ) +
  theme_bw()

## advanced students, you may be interested in calculating 
## total gene expression
## variance across genes
## relationships between other summary statistics 
## about the data


