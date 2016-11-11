rm(list=ls())
library(ggmap)
library(ggplot2)
library(varhandle)
library(grid)
library(ggtree)
library(png)
library(gridExtra)

c17 <- c("dodgerblue2","#E31A1C", # red
         "green4",
         "#6A3D9A", # purple
         "#FF7F00", # orange
         "gray70",
         "maroon","deeppink1","blue1","steelblue4",
         "darkturquoise","yellow4","yellow3",
         "darkorange4","brown")

#Load the data
all <- read.csv(file="Location.csv")

#Load the map
map <- get_map(location=c(-20,-10,55,30), zoom = 3, maptype = "satellite", scale = 2)

#Render the map
p0 <- ggmap(map, size=c(500, 500), extent="device", legend="bottom")

#Render data set 1
p1 <- p0 +
  geom_segment(data=all[which(all$source == "16G"),], aes(x=longitude, y=latitude, xend=longitude_end, yend=latitude_end), 
               colour="black") +
  geom_point(data = all[which(all$source == "16G"),], aes(x =longitude_end, y = latitude_end), colour = "black") +
  coord_cartesian()

#Add data set 2 (You can replicate this function to add more data set. Just change the color!)
p2 <- p1 +
  geom_segment(data=all[which(all$source == "1000G"),], aes(x=longitude, y=latitude, xend=longitude_end, yend=latitude_end), 
               colour="red") +
  geom_point(data = all[which(all$source == "1000G"),], aes(x =longitude_end, y = latitude_end), colour = "red") +
  coord_cartesian() 

#Render the Whole sample
p3 <- p2 +
  geom_point(data = all, aes(x =longitude_end, y = latitude_end, color = population, size=freq)) +
  scale_size_continuous(range = c(8,20),guide=FALSE) +
  scale_color_manual(values=c17) +
  guides(fill=FALSE, alpha = FALSE, size = FALSE) +
  geom_text(data= all, aes(x =longitude_end, y = latitude_end,label= freq)) +
  theme(legend.title=element_blank()) + 
  guides(colour = guide_legend(override.aes = list(size=6))) 

#Function to separate the legend
g_legend<-function(a.gplot){ 
  tmp <- ggplot_gtable(ggplot_build(a.gplot)) 
  leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box") 
  legend <- tmp$grobs[[leg]] 
  return(legend)} 
legend <- g_legend(p3) 

#Produce the plots
png("map.png")
p0
dev.off()

png("map_1.png")
p1
dev.off()

png("map_2.png")
p2
dev.off()

png("map_final.png")
grid.arrange(p3 + theme(legend.position = "none"),ncol=1, nrow=1)
dev.off()

png("legend_final.png")
grid.arrange(legend,ncol=1, nrow=1)
dev.off()