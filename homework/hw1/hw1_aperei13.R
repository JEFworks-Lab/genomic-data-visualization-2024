library(ggplot2)

outpth <-'~/genomic-data-visualization-2024/homework/hw1/'

file <- '~/genomic-data-visualization-2024/data/pikachu.csv.gz'
data <- read.csv(file)

head(data)


# Get coordinates of max CCDC80 region
max_region <- data[which.max(data$CCDC80), c("aligned_x", "aligned_y")]
xmin <- max_region$aligned_x[1] - 20
xmax <- max_region$aligned_x[1] + 20
ymin <- max_region$aligned_y[1] - 20
ymax <- max_region$aligned_y[1] + 20

im_xy_genes<- ggplot(data)+
  geom_point(aes(x=aligned_x,y=aligned_y,
             col=CCDC80)) + 
  geom_rect(aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax), 
            fill = "red", alpha = 0.01)

ggsave(paste0(outpth, "hw1_aperei13.png"), plot = im_xy_genes)
