#utilizando tidyr#
install.packages("tidyr")
install.packages("dplyr")
library("tidyr")
library("dplyr")
gapminder= read.csv("data/gapminder-FiveYearData.csv")
str(gapminder)
#De formato ancho a largo gather()#
gap_wide= read.csv("http://bit.ly/gap_wide", stringsAsFactors = FALSE)
gap_wide
str(gap_wide)
View(gap_wide)
#para poner en formato largo##el primero es el nombre y el segudo los valores#
gap_long <- gap_wide %>%
  gather(obstype_year,obs_values, starts_with('pop'),
         starts_with('lifeExp'), starts_with('gdpPercap'))
str(gap_long)
View(gap_long)
#Podríamos haber escrito todos los nombre, pero la función starts_with() nos ahorra trabajo. También podemos usar el signo - para indicar cuales columnas nos son variables.#
#Ahora obstype_year en verdad contiene dos cosas: la observación, el año#
gap_long <- gap_long %>% 
  separate(obstype_year,
           into = c('obs_type','year'), sep = "_")
gap_long$year <- as.integer(gap_long$year)
unique(gap_long$obs_type)
gap_long
gap_long_cont = gap_long %>% 
    group_by(continent, obs_type) %>%
    summarise(mean_longcontr = mean(obs_values))
gap_long_cont
options(scipen = 99)#para verlos con numeros "normales"#
#para hacer anova#

library(plyr)
gap_aov_plyr= dlply(gap_long, .(obs_type), function(x)
   aov (obs_values ~ continent, data = x))
gap_aov_plyr
#o tmb#
gap_aov_plyr2= dlply(gap_long, .(obs_type), function(x)
  aov (obs_values ~ continent*year, data = x))
gap_aov_plyr2
#del slack#
gap_aov <- gap_long %>% 
  group_by(obstype) %>% 
  do(aov = aov(obs_value ~ continent, data = . ))
gap_aov_plyr <- dlply(gap_long, .(obstype), function(x) 
  aov(obs_value ~ continent * year, data = x))
#De formato largo a intermedio con spread(): Vamos a chequear que los datos sean iguales a los otros. Vamos a usar el opuesto de gather() para extender nuestras variables observadas con la función spread(). Podemos hacerlo hasta el formato intermedio o el ancho#
gap_normal <- gap_long %>% spread(obs_type, obs_values)
dim(gap_normal)
dim(gapminder)
names(gap_normal)
names(gapminder)
#Ahora tenemos un formato intermedio gap_normal, con las mismas dimensiones pero el orden de las variables es distinto. Lo arreglamos antes de probar si son all.equal()#
gap_normal <- gap_normal[,names(gapminder)]
all.equal(gap_normal,gapminder) #para compararlos#

#El original estaba ordenado por country, continent, luego year.#
gap_normal <- gap_normal %>% arrange(country,continent,year)
all.equal(gap_normal,gapminder)

#Ahora convirtamos desde largo hasta ancho#

#Vamos a conservar las variables identificatorias y extender todas las observaciones de las tres medidas (pop,lifeExp,gdpPercap) y tiempo (year).#

#Primero necesitamos crear las etiquetas apropiadas para nuestras nuevas variables (tiempo*medida) y también unificar nuestras variables identificatorias pas simplificar el proceso:#

gap_temp <- gap_long %>% 
  unite(var_ID, continent, country, sep = "_")
str(gap_temp)

#los vamos a unir de nuevo en var names#

gap_temp <- gap_long %>%
  unite(ID_var,continent,country,sep = "_") %>%
  unite(var_names, obs_type, year, sep = "_")
str(gap_temp)

#luego de hacer todo esto lo vamos a entuvar a sprend para expandir los valores#

gap_wide_new <- gap_long %>%
  unite(ID_var, continent, country, sep = "_") %>%
  unite(var_names, obs_type, year, sep = "_") %>%
  spread(var_names, obs_values)
str(gap_wide_new)

#Lleva esto un paso más lejos y crea gap_ridiculamente_ancho extendiendo paises, año y las tres medidas. Pista la nueva data.frame debería tener solo 5 filas#

gap_ridiculamente_ancho = gap_long %>% 
  unite(var_names, country, year, obs_type, sep="_") %>% 
  spread(var_names, obs_values)
dim(gap_ridiculamente_ancho)

#Ahora tenemos una dataframe ancho, pero la variable ID_var podría ser más usable, separemos en dos variables con separate()#
gap_wide_betterID <- separate(gap_wide_new, ID_var, 
                              c("continent","country"), sep = "_")
str(gap_wide_betterID)

all.equal(gap_wide, gap_wide_betterID)

#¡Fuimos y volvimos!#
install.packages("jsonlite")
