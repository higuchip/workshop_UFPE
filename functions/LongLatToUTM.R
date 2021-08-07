# from https://stackoverflow.com/questions/18639967/converting-latitude-and-longitude-points-to-utm. Thanks stanislav!

library(sp)
library(rgdal)
#Function
LongLatToUTM<-function(x,y,zone){
  xy <- data.frame(X = x, Y = y)
  coordinates(xy) <- c("X", "Y")
  proj4string(xy) <- CRS("+proj=longlat +datum=WGS84")  ## for example
  res <- spTransform(xy, CRS(paste("+proj=utm +zone=",zone," +south",sep='')))
  return(as.data.frame(res))
}
