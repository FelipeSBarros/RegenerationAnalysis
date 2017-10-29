#setwd("/home/felipe/Projetos/Regeneracao")
require(plyr)
require(sp)
require(rgdal)
require(raster)
require(igraph)
require(adehabitatMA)
require(reshape)
require(rgeos)
require(maptools)

#frags <- raster("./Frags_MA_Albers.tif")
#frags <- raster("/home/felipe/Projetos/Regeneracao/Frags_MA.tif")
#plot(frags)

# Running focal with square matrix:
#m <- matrix(1,nrow=11,ncol=11)
#fun1 <- function(x){sum/83539600}
#frags[is.na(frags)] <- 0
#f1 <- focal(frags, w=m  , fun=sum, na.rm=T)
#plot(f1)

# Running focal with Circular matrix:
frags <- raster("./Frags_MA_mod.tif")
source("~/Projetos/SCRIPTS/Circular_Focal.R")
args(circular.focal.matrix)
w <- circular.focal.matrix(res(frags)[1], 5000)
# Running focal
#frags[is.na(frags)] <- 0
#writeRaster(frags, "./Frags_MA_mod.tif")

f1 <- focal(frags, w=w  , fun=sum, na.rm=T)
plot(f1)

porc<-f2*100/121
plot(porc)

writeRaster(porc, "./Focal_MA.tif")
#-0.185 * Ln(% cover) + 1.0583
#f2[f2==0] <- NA
uncert <- -0.185* log(f2+1) + 1.0583
plot(uncert)
writeRaster(uncert, "./Uncertainty_frag_MA.tif", overwrite = TRUE)
