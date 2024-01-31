data <- read.csv('~/Desktop/genomic-data-visualization-2024/data/pikachu.csv.gz',
                 row.names=1)
data[1:10,1:10]
gexp <- data[, 6:ncol(data)]
rownames(gexp) <- data$cell_id

pos <- data[, c('aligned_x', 'aligned_y')]
rownames(pos) <- data$cell_id
head(pos)

rowSums(gexp)
?apply
apply(gexp, 2, var) ## variable genes are across cells

#plot(data$cell_area, rowSums(gexp), pch=".")

## normalize data?
## 1000 = scaling factor (tinker)
## 1 = pseudocount (tinker)
gexpnorm <- log10(gexp/rowSums(gexp)*1000 + 1)
rowSums(gexpnorm)  
## normalize by cell area? nuclear area? maybe by one gene

?prcomp ## other packages that can do this faster
pcs <- prcomp(gexpnorm, center=TRUE, scale=FALSE)
head(pcs$x)
names(pcs)

## scree plot
plot(pcs$sdev[1:30])

## plot two PCs
head(pcs$x)
plot(pcs$x[,1:2], pch=".")

## genes with high loadings on PCs
head(sort(pcs$rotation[,1], decreasing=TRUE))
head(sort(pcs$rotation[,2], decreasing=TRUE))
head(sort(pcs$rotation[,3], decreasing=TRUE))
head(sort(pcs$rotation[,4], decreasing=TRUE))
head(sort(pcs$rotation[,4], decreasing=FALSE))
## what do you think would happen if I color by 
## these gene's expression?

'IGKC' %in% colnames(gexpnorm)

library(ggplot2)
df <- data.frame(pcs$x[,1:2], col = data[, 'CXCL12'])
head(df)
ggplot(df) + geom_point(aes(x = PC1, y = PC2, col=log10(col+1))) + theme_bw()

df <- data.frame(PC1=pcs$x[,1], gene = data[, 'POSTN'])
head(df)
ggplot(df) + geom_point(aes(x = PC1, y = gene)) + theme_bw()


df <- data.frame(pcs$x[,3:4], col = data[, 'ANKRD30A'])
head(df)
ggplot(df) + geom_point(aes(x = PC3, y = PC4, col=log10(col+1))) + theme_bw()
df <- data.frame(pcs$x[,1:2], col = data[, 'ANKRD30A'])
ggplot(df) + geom_point(aes(x = PC1, y = PC2, col=log10(col+1))) + theme_bw()

df <- data.frame(loadings = pcs$rotation['ANKRD30A',1:10])
barplot(pcs$rotation['ANKRD30A',1:10])

df <- data.frame(pcs$x[,9:10], col = data[, 'ANKRD30A'])
ggplot(df) + geom_point(aes(x = PC9, y = PC10, col=log10(col+1))) + theme_bw()

df <- data.frame(pos, col = pcs$x[,1])
ggplot(df) + geom_point(aes(x = aligned_x, y = aligned_y, col=col), size=0.5) + theme_bw()



