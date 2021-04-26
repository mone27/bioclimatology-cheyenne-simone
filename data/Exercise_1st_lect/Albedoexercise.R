Shortwavedata <- read.csv("Shortwave_incoming_diffuse_W_m-2_Hainich_2020.csv", header = TRUE, sep = ",")
View(Shortwavedata)
incoming_diffuse <- Shortwavedata$Shortwave_incoming_diffuse_W_m.2
incoming_directly <- Shortwavedata$Shortwave_incoming_W_m.2




calib_factorsdata <- read.csv("Shortwave_incoming_outgoing_belowcanopy_mV_Hainich_2020.csv")

View(calib_factorsdata)
conver_incoming <- calib_factorsdata$Shortwave_incoming_mV
conver_outgoing <-  calib_factorsdata$Shortwave_outgoing_mV
conver_belowcanopy <- calib_factorsdata$Shortwave_incoming_bewlow_canopy_mV

conversion1 <- as.numeric(conver_incoming* 86.5801) #mV *( W m-2 )/mV  = W m-2
conversion2 <- as.numeric(conver_outgoing * 86.5801) #mV *( W m-2 )/mV = W m-2
conversion3 <- as.numeric(conver_belowcanopy * 194.9318) #mV *( W m-2 )/mV = W m-2

dataconverted <- c("conversion1, conversion2,conversion3")
View(dataconverted)
albedo <- conversion1-conversion2
albedo_canopy <- conversion2-conversion3
plot(albedo, ylim = c(-700,850 ),main='Albedo',
     xlab='', ylab='', col="blue", type = "l" )
lines(albedo_canopy, col="red")
legend("bottomright", inset=0.01, legend=c("albedo", "albedo with canopy"), 
       lwd=2, cex=1.2, col=c("blue", "red"), bg="lightyellow")

totalalbedo <- albedo-albedo_canopy
plot(totalalbedo, ylim = c(-250,1100 ),main='Albedo',
     xlab='', ylab='', col="blue", type = "l" )
