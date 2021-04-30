
data <- read.csv("LW_SW_TSoil_BotGarten.csv")
View(data)
A <- data$LW_IN_W_m.2 #atmospheric longwave radiation
E <- data$LW_OUT_W_m.2 #surface reflected longwave radiation
netbalance_lw <- A-E

Rsw <- data$SW_OUT_W_m.2 #Reflected solar radiation
G <-data$SW_IN_W_m.2 #Global radiation, is the sum of direct and diffuse solar radiation
netbalance_sw <- Rsw/G
netradiationbalance_earthsurface <- netbalance_lw+netbalance_sw

sigma <- 5.67*10^-8 #W/m2K4

T <- data$Pyrgeometer_Temp_degC*273

e <- E/sigma*T^4

T <- (E/e*sigma)^(1/2)

plot(T)
plot(e)
sky_temp <- 
surface_temp <- 

#Derive the sky and surface temperature from the longwave radiation
#components. How do they differ and why? Discuss! During which
#periods of the year sky and surface temperature differ the most and
#the less?

##1a. 
##1b. I think in winter, due to the heat storaged from earth during the whole year and the less intense radiation from the sun coming during this season
  
#Compare the soil surface temperature derived from the longwave
#radiation with the soil temperature at 0.02 m depth. To which degree
#can the outgoing longwave radiation be used as an estimate of
#surface temperature and what are potential errors?

##2a. 

#Calculate the net radiation over the meadow in the forest botanical
#garden and plot the four components. How do the four components
#change over the season and why? Which unexpected results you
#found? Discuss!