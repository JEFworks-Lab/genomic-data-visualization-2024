data <- read.csv('~/Desktop/genomic-data-visualization-2024/data/eevee.csv.gz', row.names=1)
head(data)
pos <- data[,2:3]
colnames(pos) <- c('x', 'y')
cd <- data[, 4:ncol(data)]
rownames(pos) <- rownames(cd) <- data$barcode

library(STdeconvolve)
## remove pixels with too few genes
counts <- cleanCounts(t(cd), min.lib.size = 100)
## feature select for genes
corpus <- restrictCorpus(counts, removeAbove=1.0, removeBelow = 0.05)
## choose optimal number of cell-types
ldas <- fitLDA(t(as.matrix(corpus)), Ks = seq(2, 9, by = 1))
## get best model results
optLDA <- optimalModel(models = ldas, opt = "min")
## extract deconvolved cell-type proportions (theta) and transcriptional profiles (beta)
results <- getBetaTheta(optLDA, perc.filt = 0.05, betaScale = 1000)
deconProp <- results$theta
deconGexp <- results$beta
## visualize deconvolved cell-type proportions
vizAllTopics(deconProp, pos,
             r=8, lwd=0)	 

save(deconProp, deconGexp, pos, file="~/Desktop/genomic-data-visualization-2024/data/stdeconvolve.RData")
load(file="~/Desktop/genomic-data-visualization-2024/data/stdeconvolve.RData")
