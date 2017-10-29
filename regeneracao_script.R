#carregando biblio
library(raster)
library(rgdal)
library(RPostgreSQL)
library(rgeos)

##Conectando ao banco IIS
con_iis <- dbConnect(drv = dbDriver("PostgreSQL"), host="localhost", port=5432, dbname="iis", user="postgres", password="postgres")
frag <- dbGetQuery(con_iis, "select sos.geom from sos_ma.sos_11_12 where legend not like '%MATA%'")

#carregando shp MA
MA <- readOGR(dsn='/home/felipe/Projetos/ARF_spatial_planning/ENM/data/', layer='Bioma_MA1148')
urb <- readOGR(dsn = '/home/felipe/Projetos/Regeneracao/Area_urbana_SAD69_albers/',layer = 'Area_urbana')
urb <- gIntersection(spTransform(urb, CRS(proj4string(MA))), MA) 

reads <- readOGR(dsn = '/home/felipe/Projetos/Regeneracao/Roads_SAD69_albers/', layer = 'roads_SAD69_alb')

rivers <- readOGR(dsn = '/home/felipe/Projetos/Regeneracao/Rivers_SAD69_albers/', layer = 'Drenagem_SAD69_alb')

#dados:
frag <- readOGR('./')
solo <- stack('./BLD_sd2_M_04_dec_2013.tif', './SNDPPT_sd2_M_04_dec_2013.tif')
plot(solo)
solo <- crop(solo, MA)
solo <- mask(solo, MA)
plot(solo)

?projectRaster
