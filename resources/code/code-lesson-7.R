data <- read.csv('~/Desktop/genomic-data-visualization-2024/data/pikachu.csv.gz', 
                 row.names = 1)
pos <- data[, 4:5]
gexp <- data[6:ncol(data)]

# normalize?
gexpnorm <- log10(gexp/rowSums(gexp) * mean(rowSums(gexp))+1)
# pca
pcs <- prcomp(gexpnorm)
plot(pcs$sdev[1:100])
# tsne
emb <- Rtsne(pcs$x[,1:20])$Y # faster than tSNE on genes

# kmeans
com <- as.factor(kmeans(gexpnorm, centers=10)$cluster)
p1 <- ggplot(data.frame(emb, com)) + 
  geom_point(aes(x = X1, y = X2, col=com), size=0.01) + 
  theme_bw()

com2 <- as.factor(kmeans(pcs$x[,1:20], centers=10)$cluster)
p2 <- ggplot(data.frame(emb, com2)) + 
  geom_point(aes(x = X1, y = X2, col=com2), size=0.01) + 
  theme_bw()
p1 + p2

p1

ggplot(data.frame(emb, gene = gexpnorm[, 'ERBB2'])) + 
  geom_point(aes(x = X1, y = X2, col=gene), size=0.01) + 
  theme_bw()

# pick a cluster of interest
g <- 'ERBB2'
gexpnorm[com == 1, g]
gexpnorm[com != 1, g]
par(mfrow=c(2,1))
hist(gexpnorm[com == 1, g])
hist(gexpnorm[com != 1, g])
?t.test
t.test(gexpnorm[com == 1, g],
       gexpnorm[com != 1, g],
       alternative = "greater")$p.val

results <- sapply(colnames(gexpnorm), function(g) {
  wilcox.test(gexpnorm[com == 7, g],
         gexpnorm[com != 7, g],
         alternative = "greater")$p.val
})
head(sort(results, decreasing=FALSE))

ggplot(data.frame(emb, gene = gexpnorm[, 'ERN1'])) + 
  geom_point(aes(x = X1, y = X2, col=gene), size=0.01) + 
  theme_bw()

# what's the difference between t.test and wilcox.test
# differential expression between cluster 1 vs 2
# what if you do differential expression on non-normalized?

results2 <- sapply(1:10, function(i) {
  print(i)
  results <- sapply(colnames(gexpnorm), function(g) {
    wilcox.test(gexpnorm[com == i, g],
                gexpnorm[com != i, g],
                alternative = "greater")$p.val
  })
  topgene <- names(head(sort(results, decreasing=FALSE))[1])
  print(topgene)
  return(topgene)
})
results2

ggplot(data.frame(emb, gene = gexpnorm[, 'CCL5'])) + 
  geom_point(aes(x = X1, y = X2, col=gene), size=0.01) + 
  theme_bw()












