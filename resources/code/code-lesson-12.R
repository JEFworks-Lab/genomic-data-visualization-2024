data <- read.csv('~/Desktop/genomic-data-visualization-2024/data/codex_spleen_subset.csv.gz', 
                 row.names=1)
head(data)
dim(data)

pos <- data[, 1:2]
area <- data[, 3]
pexp <- data[, 4:31]
head(pexp)

## plot x,y coordinates and visualize area
library(ggplot2)
df <- data.frame(pos, area)
ggplot(df) + geom_point(aes(x=x, y=y, col=area), size=0.1)

## normalize the protein expression data
hist(log10(colSums(pexp)+1))
hist(log10(rowSums(pexp)+1))
plot(log10(area+1), log10(rowSums(pexp)+1), pch=".")

pexp.norm <- log10(pexp/rowSums(pexp) * mean(rowSums(pexp))+1)

hist(pexp.norm[,'CD4'])
hist(log10(pexp.norm[,'CD4']+1))

## kmeans clustering
tw <- sapply(1:20, function(i) {
  kmeans(pexp.norm, centers=i)$tot.withinss
})
plot(tw, type='l')

## dimensionality reduction
pvar <- apply(pexp.norm, 2, var)
pmean <- apply(pexp.norm, 2, mean)
sort(apply(pexp.norm, 2, var))

pcs <- prcomp(pexp.norm)
head(pcs$x)

plot(pcs$sdev[1:30])
emb <- Rtsne::Rtsne(pexp.norm)$Y
#emb <- Rtsne::Rtsne(pcs$x[,1:12])$Y
head(emb)

hist(pexp.norm$Podoplanin)

df <- data.frame(emb, protein = pexp.norm$Podoplanin)
ggplot(df) + geom_point(aes(x = X1, y = X2, col=protein), size=0.1)

df <- data.frame(pcs$x, protein = pexp.norm$Podoplanin)
ggplot(df) + geom_point(aes(x = PC3, y = PC4, col=protein), size=0.1)

## get clusters
tw <- sapply(1:20, function(i) {
  print(i)
  kmeans(emb, centers=i)$tot.withinss
})
plot(tw, type='l')

com <- as.factor(kmeans(emb, centers=5)$cluster)
df <- data.frame(emb, com=com)
ggplot(df) + geom_point(aes(x = X1, y = X2, col=com), size=0.1)
df <- data.frame(pos, com=com)
ggplot(df) + geom_point(aes(x = x, y = y, col=com), size=0.5)

## differential expression
pvals <- sapply(colnames(pexp), function(p) {
  print(p)
  test <- t.test(pexp.norm[com == 2, p], pexp.norm[com != 2, p])
  test$p.value
})
fc <- sapply(colnames(pexp), function(p) {
  print(p)
  mean(pexp.norm[com == 2, p])/mean(pexp.norm[com != 2, p])
})
pvals
fc
df <- data.frame(pv = -log10(pvals), log2fc = log2(fc), label=colnames(pexp))
head(df)
ggplot(df) + geom_point(aes(x = log2fc, y = pv)) + 
  geom_text(aes(x = log2fc, y = pv, label=label))
