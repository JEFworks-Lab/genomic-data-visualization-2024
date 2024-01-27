data(iris)
?head
head(iris)
1:3
iris[1:3,]
iris[1:3,1:3]

colnames(iris)
colnames(iris)[c(1,3,4)]

head(iris[,c(1,3,4)])

#install.packages('ggplot2')
library(ggplot2)

ggplot(iris) + 
  geom_point(aes(x = Sepal.Length, y = Sepal.Width,
             col = Species, shape = Species))

## help me encode Sepal.Length, Sepal.Width, Species 
## + Petal.Length
## + Petal.Width
ggplot(iris) + 
  geom_point(aes(x = Sepal.Length, y = Sepal.Width,
                 col = Petal.Width, shape = Species,
                 size = Petal.Length)) + 
  scale_color_continuous(type = "viridis")

ggplot(iris) + 
  geom_point(aes(x = Petal.Length, y = Petal.Width,
                 col = Sepal.Width, shape = Species,
                 size = Sepal.Length)) + 
  scale_color_continuous(type = "viridis")

ggplot(iris) +
  geom_segment(aes(x = 1:nrow(iris), y = 0,
               xend = 1:nrow(iris), yend = Petal.Length,
               col = Species))

#install.packages('ggforce')
library(ggforce)
?geom_mark_ellipse
ggplot(iris) + 
  geom_point(aes(x = Sepal.Length, y = Sepal.Width)) +
  geom_mark_ellipse(aes(x = Sepal.Length, y = Sepal.Width, fill = Species))

  

########### for advanced students: make an upset plot
data(mtcars)

# Set the chart data
expressionInput <- c(`#rstats` = 5, memes = 5, `#rstats&memes` = 3)

#install.packages('UpSetR')
# Create an UpsetR Plot
library(UpSetR)
upset(fromExpression(expressionInput), order.by = "freq")

