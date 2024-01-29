library(ggplot2)

file <- '~/Documents/genomic-data-visualization-2024/data/pikachu.csv.gz'
data <- read.csv(file)

head(data)


ggplot(data)+
  geom_point(aes(x=aligned_x, y=ERBB2, 
                 size=aligned_y,
                 col=cell_area)) + 
  scale_colour_gradient(low = 'lightgrey',
                        high='red') + 
  theme_minimal() 


# spatial location of cells with respect to nucleus area and cell area
ggplot(data)+
  geom_point(aes(x=aligned_x,y=aligned_y,
                 size= nucleus_area,
                 col=cell_area)) #+
# scale_colour_gradient(low = 'lightgrey',
# high='red') 

ggplot(data)+
  geom_bin2d(aes(x=aligned_x,y=aligned_y,
                 size= nucleus_area,
                 col=cell_area),
             bin=100)