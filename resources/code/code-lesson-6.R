## from Rafael
df <- data.frame(x=c(1,1,2,2), y=c(1,1,2,2),
                 value=as.factor(c('A','B','A','B')))
df
ggplot(df) +
  geom_point(aes(x, y, color=value), size=15)

df <- data.frame(x=c(1,1,2,2), y=c(1,1,2,2),
                 value=as.factor(c('B','A','B','A')))
df
ggplot(df) +
  geom_point(aes(x, y, color=value), size=15)

ggplot(df) +
  geom_point(aes(x, y, color=value), alpha=.5, size=15)

ggplot(df) +
  geom_point(aes(x, y, color=value, shape=value), alpha=.5, size=15)

?kmeans
com <- kmeans(df[,1:2], centers=3)
names(com)
data.frame(df, com$cluster) # categorical

## own data
data <- read.csv('~/Desktop/genomic-data-visualization-2024/data/pikachu.csv.gz', row.names=1)
data[1:5,1:5]
pos <- data[, 4:5]
gexp <- data[, 6:ncol(data)]
rownames(pos) <- rownames(gexp) <- data$cell_id
cell_area <- data$cell_area
names(cell_area) <- data$cell_id
head(cell_area)

## pick one:
## could k-means cluster genes, different normalization?
## could run PCA on genes, then do k-means clustering
## could run tSNE on genes, then do k-means clustering
## visualize the results on your tissue (pos)
com <- kmeans(cell_area, centers=2)
names(com)
table(com$cluster)
hist(cell_area)
hist(cell_area[com$cluster==1], add=TRUE, col='red')
hist(cell_area[com$cluster==2], add=TRUE, col='blue')

library(ggplot2)
df <- data.frame(pos, kmeans=as.factor(com$cluster))
head(df)
ggplot(df) + 
  geom_point(aes(x = aligned_x, 
                 y=aligned_y, 
                 col=kmeans), 
             size=0.01) +
  theme_minimal()

## look at different tot.withiness
pcs <- prcomp(gexp) ## maybe normalize?
plot(pcs$sdev[1:100])
results <- sapply(seq(2, 20, by=1), function(i) {
  print(i)
  com <- kmeans(pcs$x[,1:20], centers=i)
  return(com$tot.withinss)
})
results
plot(results, type="l")
seq(2, 20, by=1)



