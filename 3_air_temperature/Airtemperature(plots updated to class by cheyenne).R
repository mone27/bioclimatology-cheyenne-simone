#Plot air temperature inside the canopy and above the canopy.
#Indicate time periods when the two temperatures differ and explain why.

library(ggplot2)
data2 <- read.csv("Hainich_T_air_soil_degC.csv")

data2$Date<- as.POSIXct(data2$Date, format= "%Y-%m-%d %H:%M")

#data2$belowcanopy <- paste(data2$TA_40m, data2$TA_32m, data2$TA_20m, data2$TA_10m, data2$TA_2m, sep="")

#above_canopy <- data2$TA_44m

ggplot(data2, aes(x= Date))+ 
  geom_line(aes(y= TA_40m, colour = '40m' )) + 
  geom_line(aes(y= TA_32m, colour = '32m' )) + 
  geom_line(aes(y= TA_20m, colour = '20m' )) + 
  geom_line(aes(y= TA_10m, colour = '10m' )) + 
  geom_line(aes(y= TA_2m, colour = '2m' )) + 
  geom_line(aes(y= TA_44m, colour = 'Above canopy'))+
  labs(y = "Temperature ºC", x = "Time period", color = "")


#Plot air temperature in 2 m height and soil temperature in 0.02 m depth. Explain the characteristics of the time series?

ggplot(data2, aes(x= Date))+ 
  geom_line(aes(y= TA_2m, colour = 'Air Temperature 2m' )) + 
  geom_line(aes(y= Tsoil_002m_degC, colour = 'Soil Temperature 0.02m'))+
labs(y = "Temperature ºC", x = "Time period", color = "")


#Estimate the response time of a mercury thermometer (soil temperature) and an Assmann thermometer (air temperature).
#Visualize and discuss differences.


data <- read.csv("Air_temperature_calibration.csv")

library(ggplot2)
library(tidyverse)

ggplot(data, aes(x= Time))+ 
  geom_line(aes(y= T_soil_thermometer_degC, colour = 'Soil temperature C' )) + 
  geom_line(aes(y= T_assmann_thermometer_degC, colour = 'Air temperature C'))+
  labs(y = "Temperature ºC", x = "Time period", color = "")


#Mercury thermometer

temp_mercury <- data$T_soil_thermometer_degC


T_a <- 25.4 # Ambient Temperature
T_0 <- temp_mercury[1] # first measure 
temp_res <- mutate(data, log_t = log((T_0 - T_a) / (temp_mercury - T_a)) )
#log_t <- log((T_0 - T_a) / (temp_mercury - T_a))

ggplot(temp_res, aes(x=Time, y=log_t)) +
  geom_line()+
  labs(y = "Temperature ºC", x = "Time period", color = "")


(model_res1 <- lm(Time ~ log_t, data=temp_res))

timeresponse <- round(coef(model_res1)[1])
view(timeresponse) #seconds
ggplot(temp_res, aes(x=Time, y=timeresponse)) +
  geom_line()+
  labs(y = "Temperature ºC", x = "Time period", color = "")

#Assmann thermometer

temp_assmann <- data$T_assmann_thermometer_degC


T_a <- 25.4 # Ambient Temperature
T_0 <- temp_assmann[1] # first measure 
temp_res_assmann <- mutate(data, log_t_assmann = log((T_0 - T_a) / (temp_assmann - T_a)) )
#log_t <- log((T_0 - T_a) / (temp_mercury - T_a))

ggplot(temp_res_assmann, aes(x=Time, y=log_t_assmann)) +
  geom_line()+
  labs(y = "Temperature ºC", x = "Time period", color = "")

(model_res2 <- lm(Time ~ log_t_assmann, data=temp_res_assmann))

timeresponse_assmann <- round(coef(model_res2)[1])
view(timeresponse_assmann) #seconds

