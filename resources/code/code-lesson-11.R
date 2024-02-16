## if you want to install STdeconvolve and try it out for yourself
require(remotes)
remotes::install_github('JEFworks-Lab/STdeconvolve')


## we will just load the output that I've already run
load('~/Desktop/genomic-data-visualization-2024/data/stdeconvolve.RData')

dim(deconProp)
deconProp[1:5,1:5]
deconGexp[1:5,1:5]
head(pos)

data <- read.csv('~/Desktop/genomic-data-visualization-2024/data/eevee.csv.gz', row.names=1)
data[1:5,1:5]
gexp <- data[, 4:ncol(data)]
rownames(gexp) <- data$barcode

## let's try to visualize this data
head(deconProp)
df <- data.frame(pos, deconProp)
head(df)
p1 <- ggplot(df) + geom_point(aes(x = x, y=y, col=X1)) + 
  scale_colour_gradient(low = 'grey', high='blue')
p1

head(sort(deconGexp[1,], decreasing=TRUE))
df <- data.frame(pos, gene = gexp$KRT17)
head(df)
p2 <- ggplot(df) + geom_point(aes(x = x, y=y, col=gene)) + 
  scale_colour_gradient(low = 'grey', high='red')
p2

library(patchwork)
p1 + p2

gexpnorm <- log10(gexp/rowSums(gexp) * mean(rowSums(gexp))+1)
good.genes <- colnames(gexpnorm)[colSums(gexpnorm)>300]
good.genes
gexpnorm.sub <- gexpnorm[, good.genes]
dim(gexpnorm)
dim(gexpnorm.sub)

pcs <- prcomp(gexpnorm.sub)
plot(pcs$sdev[1:30])
emb <- Rtsne::Rtsne(pcs$x[,1:5])$Y
rownames(emb) <- rownames(gexpnorm.sub)
colnames(emb) <- c('tSNE1', 'tSNE2')
head(emb)

df <- data.frame(emb, deconProp)
head(df)
ggplot(df) + geom_point(aes(x = tSNE1, y=tSNE2, col=X1)) + 
  scale_colour_gradient(low = 'grey', high='blue')
