data <- read.csv('~/Desktop/genomic-data-visualization-2024/data/mystery_data.csv.gz', row.names=1)
data[1:5,1:5]

## separate into expression and position
head(data[,3])
pos <- data[,1:2]
gexp <- data[, 3:ncol(data)]

## look at highly variable genes
head(sort(apply(gexp, 2, var), decreasing=TRUE))
head(sort(apply(gexp, 2, mean), decreasing=TRUE))

## normalize by total gene expression and log transform
gexpnorm <- log10(gexp/rowSums(gexp) * mean(rowSums(gexp))+1)
#gexpnorm <- log10(gexp+1)

## visualize on tissue
library(ggplot2)
ggplot(data.frame(pos)) + geom_point(aes(x = x, y = y))

## PCA on normalized gene expression
pcs <- prcomp(gexpnorm)
plot(pcs$sdev[1:5], type="l")
ggplot(data.frame(pcs$x)) + geom_point(aes(x = PC1, y = PC2))

## tSNE 
library(Rtsne)
emb <- Rtsne(pcs$x[,1:5])$Y
ggplot(data.frame(emb)) + geom_point(aes(x = X1, y = X2))

## kmeans
totw <- sapply(1:10, function(i) {
  com <- kmeans(pcs$x[,1:5], centers=i)
  return(com$tot.withinss)
})
plot(totw)
com <- as.factor(kmeans(pcs$x[,1:5], centers=4)$cluster)
head(com)
ggplot(data.frame(emb, com)) + geom_point(aes(x = X1, y = X2, col=com))
ggplot(data.frame(pos, com)) + geom_point(aes(x = x, y = y, col=com))

## differentially expressed genes
diffgexp <- sapply(colnames(gexpnorm), function(g) {
  #g = 'Kctd13'
  wilcox.test(gexpnorm[com == 1, g], gexpnorm[com != 1, g], 
              alternative='greater')$p.val
})
head(sort(diffgexp, decreasing=FALSE))
         
ggplot(data.frame(emb, gene=gexpnorm[,'Fth1'])) + 
  geom_point(aes(x = X1, y = X2, col=gene))
ggplot(data.frame(pos, gene=gexpnorm[,'Fth1'])) + 
  geom_point(aes(x = x, y = y, col=gene))

