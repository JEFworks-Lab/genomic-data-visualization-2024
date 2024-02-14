data <- read.csv('~/Desktop/genomic-data-visualization-2024/data/pikachu.csv.gz', 
                 row.names = 1)
pos <- data[, 4:5]
gexp <- data[6:ncol(data)]
rownames(pos) <- rownames(gexp) <- data$cell_id
head(pos)
head(gexp)

## maybe you want to normalize?
## maybe you want to get kmeans clusters?
## save.image('test.RData') 
## load('test.RData')

pcs <- prcomp(gexp)
emb <- Rtsne::Rtsne(pcs$x[,1:10])$Y
geneofinterest <- log10(gexp$KRT6B+1)
  
## first make a static visualization 
library(ggplot2)
df1 <- data.frame(pcs$x[,1:2], gene=geneofinterest)
colnames(df1) <- c('PC_x', 'PC_y', 'gene')
ggplot(df1) + geom_point(aes(x = PC_x, PC_y, col=gene))

df2 <- data.frame(emb, gene=geneofinterest)
colnames(df2) <- c('PC_x', 'PC_y', 'gene')
ggplot(df2) + geom_point(aes(x = PC_x, PC_y, col=gene))

df3 <- data.frame(pos, gene=geneofinterest)
colnames(df3) <- c('PC_x', 'PC_y', 'gene')
ggplot(df3) + geom_point(aes(x = PC_x, PC_y, col=gene, size=0.1), size=0.1)

library(gganimate)
df <- rbind(cbind(df1, order=1, size=1), 
            cbind(df2, order=2, size=1),
            cbind(df3, order=3, size=0.01))
head(df)
p <- ggplot(df) + geom_point(aes(x = PC_x, y = PC_y, col=gene, size=size), size=0.1)
p

anim <- p + transition_states(order) + view_follow()
animate(anim, height = 300, width = 300)

## if you are having trouble rendering, try
## install.packages('gifski')

df1 <- data.frame(pos, gene=log10(gexp$CD9+1))
colnames(df1) <- c('x', 'y', 'gene')
ggplot(df1) + geom_point(aes(x = x, y, col=gene), size=0.1) +
  scale_color_viridis_c()

df2 <- data.frame(pos, gene=log10(gexp$CD3E+1))
colnames(df2) <- c('x', 'y', 'gene')
ggplot(df2) + geom_point(aes(x = x, y, col=gene), size=0.1) +
  scale_color_viridis_c()

df <- rbind(cbind(df1, label='CD9'), 
            cbind(df2, label='CD3E'))
head(df)
p <- ggplot(df) + geom_point(aes(x = x, y = y, col=gene), size=0.1) +
  scale_color_viridis_c()
p

anim <- p + transition_states(label) + view_follow() +
  labs(title = '{closest_state}') 
animate(anim, height = 300, width = 300)



