#From the theory given to do the measurements needed for the second protocol, the voltages need to be transformed from mV to W/m2
#long wave up = 10,53 µV/W/m2 and long wave down = 9,19 µV/W/m2.


E = V/C + 5.67*10^-8*T^4

#The temperature is measure as a resistance not as a voltage, thus the following equation is needed to transformn the resitance into T

alpha <- 1.0295*10^-3
beta <- 2.391*10^-4
gamma <- 1.568*10^-7
T <- (alpha+[beta*(log(R))+gmma*(log(R))^3])^(-1)-273.15