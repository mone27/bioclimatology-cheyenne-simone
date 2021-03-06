---
  title: "R Notebook"
output: html_notebook
---
  

library(tidyverse)


Formulas

$$e_s = 6.1078 e^{\frac{17.08085 T_a} {234.175°C + T_a}}$$
  
  $$T_d = \frac{(len(e_a) - ln(6.1708))\cdot234.17} {17.08085 - ln(e_a) + ln(6.1078)}$$
  

hum <- read_csv("Data_lectures/4_air_humidity/04_Air_humidity_TA_RH_PA_NP_Hainich.csv")
names(hum) <- c("datetime", "ta", "rh", "pa")


c2k <- function(c) c + 273.15
k2c <- function(k) k - 273.15
Rv <- 461.47 # J K -1 kg -1 ] - gas constant of water vapour
get_es <-  function(ta)  6.1078 * exp((17.08085 * ta) / (234.175 + ta))
get_td <- function(e_a) ((log(e_a) - log(6.1708)) * 234.17) / (17.08085 - log(e_a) + log(6.1078))
get_rh <- function(e_a, e_s) e_a/e_s * 100
rh2ea <- function(rh, e_s) rh/100 * e_s
# need to convert e_a from hPa to Pa and the temperature to degrees Kelvin
# convert the output in g/Kg 
get_abs_hum <- function(e_a, ta) (e_a * 100 / (Rv * c2k(ta)) ) * 1000
#here there is no need to convert to Pa because the pressures is present both at numerator and denomiator
get_spec_hum <- function(e_a, p) 0.622 * e_a / (p - 0.378 * e_a) 
get_mix_ratio <- function(e_a, p) 0.622 * e_a / (p - e_a)
get_p_def <- function(ea, es) es - ea
get_t_eq <- function(ta, mix_ratio) k2c(c2k(ta) + 2.5 * mix_ratio)

head(hum)

hum <- mutate(hum,
              es = get_es(ta),
              ea = rh2ea(rh, es),
              td = get_td(ea),
              abs_hum = get_abs_hum(ea, ta),
              spec_hum = get_spec_hum(ea, pa),
              mix_ratio = get_mix_ratio(ea, pa),
              p_def = get_p_def(ea, es),
              t_eq = get_t_eq(ta, mix_ratio)
)




hum %>%
  filter(week(datetime) ==1) %>%
  gather("type", "val", es, ea, p_def) %>%
  ggplot(aes(datetime, val, colour=type))+
  geom_line()



hum %>%
  filter(week(datetime) ==1) %>%
  gather("type", "val", ta, td) %>%
  ggplot(aes(datetime, val, colour=type))+
  geom_line()

hum %>%
  filter(week(datetime) ==6) %>%
  gather("type", "val", abs_hum) %>%
  ggplot(aes(datetime, val, colour=type))+
  geom_line()

hum %>%
  gather("type", "val", abs_hum) %>%
  ggplot(aes(datetime, val, colour=type))+
  geom_line()

hum %>%
  filter(week(datetime) ==6) %>%
  gather("type", "val", spec_hum, mix_ratio) %>%
  ggplot(aes(datetime, val, colour=type))+
  geom_line()

head(hum)

hum %>%
  filter(week(datetime) ==6) %>%
  gather("type", "val", ta, td, t_eq) %>%
  ggplot(aes(datetime, val, colour=type))+
  geom_line()

