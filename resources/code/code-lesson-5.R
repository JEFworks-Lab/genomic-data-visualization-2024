data <- read.csv('~/Desktop/genomic-data-visualization-2024/data/eevee.csv.gz', row.names=1)
dim(data)
data[1:5,1:5]
pos <- data[,2:3]
gexp <- data[, 4:ncol(data)]

## recommend limiting the number of genes
?apply
topgene <- names(sort(apply(gexp, 2, var), decreasing=TRUE)[1:1000]) 
gexpfilter <- gexp[,topgene]
dim(gexpfilter)

## what happens if we normalize the data?
## if we log transform?
#gexpnorm <- log10(gexpfilter/rowSums(gexpfilter) * mean(rowSums(gexpfilter))+1)

## let's try PCA
?prcomp
pcs <- prcomp(gexpfilter)
dim(pcs$x)
plot(pcs$sdev[1:30])

## run tSNE
library(Rtsne)
?Rtsne
emb1 <- Rtsne(pcs$x[,1:15], dims = 2, perplexity = 5) ## what happens if we run tSNE on PCs?
emb2 <- Rtsne(pcs$x[,1:15], dims = 2, perplexity = 100) ## what happens if we run tSNE on PCs?
names(emb)

## plot
df <- data.frame(pcs$x[,1:2], emb1=emb1$Y, emb2=emb2$Y, gene = rowSums(gexpfilter))
#p1 <- ggplot(df) + geom_point(aes(x = PC1, y = PC2, col=gene)) + theme_classic()
p1 <- ggplot(df) + geom_point(aes(x = emb1.1, y = emb1.2, col=gene)) + theme_classic()
p2 <- ggplot(df) + geom_point(aes(x = emb2.1, y = emb2.2, col=gene)) + theme_classic()

library(patchwork)
p1 + p2 + plot_annotation(tag_levels = 'a') + plot_layout(ncol = 1)

