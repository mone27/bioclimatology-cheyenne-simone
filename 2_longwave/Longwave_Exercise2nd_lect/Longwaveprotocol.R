#From the theory given to do the measurements needed for the second protocol, the voltages need to be transformed from mV to W/m2
#long wave up = 10,53 µV/W/m2 and long wave down = 9,19 µV/W/m2.


E = V/C + 5.67*10^-8*T^4

#The temperature is measure as a resistance not as a voltage, thus the following equation is needed to transformn the resitance into T

alpha <- 1.0295*10^-3
beta <- 2.391*10^-4
gamma <- 1.568*10^-7
T <- (alpha+[beta*(log(R))+gamma*(log(R))^3])^(-1)-273.15

Derive the sky and surface temperature from the longwave radiation components. 
How do they differ and why? Discuss! 
During whichperiods of the year sky and surface temperature differ the most andthe less?
Compare the soil surface temperature derived from the longwaveradiation with the soil temperature at 0.02 m depth. 
To which degreecan the outgoing longwave radiation be used as an estimate ofsurface temperature and what are potential errors?
Calculate the net radiation over the meadow in the forest botanicalgarden and plot the four components. How do the four componentschange over the season and why? Which unexpected results youfound? Discuss!2323
