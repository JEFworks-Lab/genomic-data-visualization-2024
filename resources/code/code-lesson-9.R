data <- read.csv('~/Desktop/genomic-data-visualization-2024/data/eevee.csv.gz', row.names=1)
pos <- data[,2:3]
gexp <- data[, 4:ncol(data)]
rownames(pos) <- rownames(data) <- data$barcode
dim(gexp)

# subset for faster processing
gexp <- gexp[, colSums(gexp) > 1000] ## highly expressed genes
# probably also normalize...
gexpnorm <- log10(gexp/rowSums(gexp) * mean(rowSums(gexp))+1)
com <- as.factor(kmeans(gexpnorm, centers=2)$cluster)

df <- data.frame(pos, com)
ggplot(df) + geom_point(aes(x = aligned_x, y = aligned_y, col=com))

pv <- sapply(colnames(gexpnorm), function(i) {
  print(i) ## print out gene name
  wilcox.test(gexpnorm[com == 1, i], gexpnorm[com != 1, i])$p.val
})
logfc <- sapply(colnames(gexpnorm), function(i) {
  print(i) ## print out gene name
  log2(mean(gexpnorm[com == 1, i])/mean(gexpnorm[com != 1, i]))
})

# volcano plot
df <- data.frame(pv=-log10(pv), logfc)
ggplot(df) + geom_point(aes(x = logfc, y = pv))
# challenge: label the extreme points (reccomend: ggrepel)

geneclusters <- as.factor(kmeans(t(gexpnorm), centers=10)$cluster)
df <- data.frame(pv=-log10(pv), logfc, geneclusters=geneclusters)
ggplot(df) + geom_point(aes(x = logfc, y = pv, col=geneclusters))

head(geneclusters[geneclusters == 9])
df <- data.frame(pos, gene=gexpnorm[, 'ISG15'])
ggplot(df) + geom_point(aes(x = aligned_x, y = aligned_y, col=gene), size=2) +
  scale_color_gradient2(high = scales::muted("red"), mid = 'white', low = scales::muted("blue"))
df <- data.frame(pos, gene=gexpnorm[, 'AGRN'])
ggplot(df) + geom_point(aes(x = aligned_x, y = aligned_y, col=gene), size=2) +
  scale_color_gradient2(high = scales::muted("red"), mid = 'white', low = scales::muted("blue"))

## please install gganimate
install.packages('gganimate')
library(gganimate)
ggplot(mtcars, aes(factor(cyl), mpg)) + 
  geom_boxplot() + 
  # Here comes the gganimate code
  transition_states(
    gear,
    transition_length = 2,
    state_length = 1
  ) +
  enter_fade() + 
  exit_shrink() +
  ease_aes('sine-in-out')
## https://bit.ly/GDV24_rc
