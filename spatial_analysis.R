install.packages('spatstat')
install.packages('spatstat.local')
install.packages('rgdal')
install.packages('sp')

library(spatstat)
library(spatstat.local)

# LongLatToUTM

source('functions/LongLatToUTM.R')

library(dplyr)
publico<-points_in_recife %>% 
  filter (grupo_nat_juridica == 'PUBLICO')

privado<-points_in_recife %>% 
  filter (grupo_nat_juridica == 'PRIVADO')

poly_utm<-LongLatToUTM(st_coordinates(recife_geo)[,1], st_coordinates(recife_geo)[,2], 23)           
pts_publico<-LongLatToUTM(st_coordinates(publico)[,1], st_coordinates(publico)[,2], 23)
pts_privado<-LongLatToUTM(st_coordinates(privado)[,1], st_coordinates(privado)[,2], 23)

poly_utm
pts_publico
pts_privado



#Define o poligono da  área estudada no formato do spatstat
w<-owin(poly=data.frame(x=rev(poly_utm$X), y=rev(poly_utm$Y)))
plot(w)



#Definir coordenadas espaciais no formato específico do spatstat
publico.pts<-ppp(pts_publico$X,pts_publico$Y, window=w)
plot(publico.pts, pch=20)

privado.pts<-ppp(pts_privado$X,pts_privado$Y, window=w)
plot(privado.pts, pch=20)


plot(density(publico.pts))
plot(w, add=T)
points(publico.pts, pch=20, cex=.5, col="black")

plot(density(privado.pts))
plot(w, add=T)
points(privado.pts, pch=20, cex=.5, col="black")



norm_palette <- colorRampPalette(c("white","black"))
pal_trans <- norm_palette(5)

par(mfrow=c(1,2))
plot(density(publico.pts), main="Publico", col=pal_trans)
plot(w, add=T)
points(publico.pts, pch=20, cex=.2, col="red")

plot(density(privado.pts), main="Privado", col=pal_trans)
plot(w, add=T)
points(privado.pts, pch=20, cex=.2, col="red")


# Teste para verificar a homogeneidade na distribuicao dos dados
homtest(publico.pts, nsim = 19)
homtest(privado.pts, nsim = 19)



EL.inhom.publico <- envelope(publico.pts, 
                     Linhom, nsim=19, 
                     correction="best")

plot(EL.inhom.publico, . - r ~ r, 
     ylab=expression(hat("L")), legend=F,
     xlab="Distância (m)")


EL.inhom.privado <- envelope(privado.pts, 
                             Linhom, nsim=19, 
                             correction="best")

plot(EL.inhom.privado, . - r ~ r, 
     ylab=expression(hat("L")), legend=F,
     xlab="Distância (m)")

