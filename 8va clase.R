#divide y venceras#
conPBI <- calcPBI(gapminder)
mean(conPBI[conPBI$continent == "Africa", "gdp"])
#ero no es muy lindo. Usando una función disminuimos la repetición. Eso está bueno.
#Pero hay mucha repetición: lleva tiempo, ahora y más adelante, y puede introducir errores.#
#El problema que tenemos se conoce como “divide-aplica-combina”: hay paquetes para esto#
#El paquete plyr#
#El paquete plyr provee un set de herramientas que hacen que sea más amigable lidiar con este problema.#
library(plyr)
gapminder= read.csv("data/gapminder-FiveYearData.csv")
#El nombre de la funciones depende de lo que esperan como entrada, y la estructura de salida. ver cuadro#
#Cada función de **ply (daply, ddply, llply, laply, …) tiene la misma estructura y las mismas 4 caraterísticas clave y estructura:#
#**ply(.data, .variables, .fun)#
#.data - el objeto a ser procesado#
#variables - identifica las variables para dividir#
#.fun - da la función a ser ejecutada en cada pedazo#
conPBI=calcPBI(gapminder)
ddply(
    .data = conPBI,
  .variables = "continent", #no haria falta poner los nombres entre comillas#
  .fun = function(dat) mean(dat$pbi)#mientras coincida el dat del objeto con del dat del mean)
)#ahora si#
dlply( .data = conPBI,
       .variables = "continent",
       .fun = function(dat) mean(dat$pbi)
)
#Podemos especificar varias columnas por grupo:#
ddply(
  .data = conPBI,
  .variables = c("continent","year"),  
  .fun = function(dat) mean(dat$pbi)
)
daply(#en forma de matrix#
  .data = conPBI,
  .variables = c("continent","year"),  
  .fun = function(dat) mean(dat$pbi)
)
#Podemos llamar a estas funciones en lugar de bucles for (y generalmente es más rápido). Para reemplazar un bucle for, pon el código del cuerpo del bucle dentro una función anónima.#
d_ply(
  .data = gapminder,
  .variables = "continent",
  .fun = function(x) {
    meanGDPperCap <- mean(x$gdpPercap)
    print(paste(
      "The mean GDP per capita for", unique(x$continent),
      "is", format(meanGDPperCap, big.mark = ",")#La función format puede ser usada para hacer los números que quedn “bien” para imprimir mensajes.#
    ))
  }
)
#para expectativa de vida#
gapminder$lifeExp
#Ejercicio 1#
d_ply(
  .data = gapminder,
  .variables = "continent",
  .fun = function(x) {
    meanlifeExp <- mean(x$lifeExp)
    mayorlife = max(mean(x$lifeExp))
    print(paste(
      "The mean Life Expectancy for", unique(x$continent),
      "is", format(meanlifeExp, decimal.mark= ",")
    ))
    print(paste(
      "La mayor expectativa es", format(mayorlife,decimal.mark= "," ), "de", 
      unique(x$continent)
    ))
  }
)
#o#
lifeexp_cont= ddply(
    gapminder,
  .(continent, year),
  function(x) {
    meanlifeExp <- mean(x$lifeExp)
  }
)
lifeexp_cont[which.max(lifeexp_cont$V1),]

#ejercicio 2#
d_ply(
  .data = gapminder,
  .variables = c("continent","year"),
  .fun = function(x) {
    meanlifeExp <- mean(x$lifeExp)
    print(paste(
      "The mean Life Expectancy for", unique(x$continent),"in the year", unique(x$year),
      "is", format(meanlifeExp, decimal.mark= ",")
    ))
  }
)
#o#
lifecontyear= ddply(
  .data = gapminder,
  .variables = c("continent","year"),
  .fun = function(x) {
    meanlifeExp <- mean(x$lifeExp)
  }
)
lifecontyear[which.max(lifecontyear$V1), ]
lifecontyear[which.min(lifecontyear$V1),year2007]
#los "..." todos los argumentos que no esten nombrados en una funcion los agrupe#
#ejercicio avanzado: calcula la diferencia de medias entre la expectativa de vida en los años 1952 y 2007 usando la salida del ejercicio 2 usando una de las funciones de plyr.#
lifecontyear2007= lifecontyear[lifecontyear$year=="2007", ]
lifecontyear2007[which.min(lifecontyear2007$V1),]
lifecontyear[lifecontyear$year %in% c(2007, 1952),]
lifecontyear1952=lifecontyear[lifecontyear$year=="1952", ]
lifecontyear1952_2007 = cbind(lifecontyear1952, anio2007= lifecontyear2007$V1)
names(lifecontyear1952_2007)[3]= "anio_1952"
lifecontyear1952_2007$diferencia = with(lifecontyear1952_2007, anio2007 - anio_1952)
lifecontyear1952_2007
?plyr
lifecontyear
#solucion con plyr para el ejercicio avanzado#
ddply (
  lifecontyear, .(continent), 
  function(x) x[x$year==2007, "V1"]-x[x$year== 1952, "V1"])


)

ddply(gapminder, .(continent), summarise,
      media_lifeExp = mean(lifeExp),
      sd_lifeExp = sd(lifeExp)
      )

#Vamos a usar las 6 más comunes y también el pipe (tubo) (%>%) para combinarlas:#
#select()#
#filter()#
#group_by()#
#summarize()#
#mutate()#
install.packages('dplyr')
library(dplyr)
year_country_gdp <- select(gapminder,year,country,gdpPercap)
year_country_gdp
year_country_gdp <- gapminder %>% select(year,country,gdpPercap)#la salida del total lo manda al select, va leyendo hacia abajo#
year_country_gdp
#¿Cómo funcionan los pipes?#
#Usando filter() Podemos filtrar usando filter()#
year_country_gdp_euro <- gapminder %>%
  filter(continent == "Europe") %>%
  select(year, country, gdpPercap)
year_country_gdp_euro
#Ejercicio 1:Escribe en una sola operación (que puede tener varias lineas e incluir pipes) que produzca un data.frame que tenga los valores de África para lifeExp, country y year, pero no otros continentes.#

#¿Cuántas filas tiene tu data.frame? ¿Por qué?#
africa_vida = gapminder %>%
  filter(continent=="Africa") %>%
  select(year, country, lifeExp) #importa mucho el orden, debido a que no podemos filtrar algo excluido#
africa_vida
#tieme 624 porque no son todos los paises#

#Podemos definir variables de agrupación usando group_by()#
str(gapminder %>% group_by(continent)#se puede agregar mas cosas como year aca#)
#La estructura no es igual que en original.Una list que contiene las filas que corresponden a un continente en particular#

#Usando summarize() group_by() no es muy interesante por si solo. Es más interesante de usar con summarize(). Esto nos permite usar otras funciones como mean o sd de forma similar a plyr#
gdp_bycontinents <- gapminder %>%
  group_by(continent) %>%
  summarize(mean_gdpPercap = mean(gdpPercap))
gdp_bycontinents
lifebycountry = gapminder %>%
  group_by(country) %>%
  summarize(mean_lifeExp = mean(lifeExp))
lifebycountry
lifebycountry[which.max(lifebycountry$mean_lifeExp),]
lifebycountry[which.min(lifebycountry$mean_lifeExp),]
#otra manera, utilizando filter, no olvidar in y que la funcion es range#

lifebycountry %>% filter(mean_lifeExp %in% range(mean_lifeExp))

#Nos permite calcular la media de PBI por continente pero se pueden hacer más cosas. También podemos agrupar por varias variables. Por ejemplo year y continent.#
gdp_bycontinents_byyear <- gapminder %>%
  group_by(continent, year) %>%
  summarize(mean_gdpPercap = mean(gdpPercap))
gdp_bycontinents_byyear
#Eso de por si es bastante útil, pero además podemos calcular ¡varias variables por vez!#
gdp_pop_bycontinents_byyear <- gapminder %>%
  group_by(continent, year) %>%
  summarize(mean_gdpPercap = mean(gdpPercap),
            sd_gdpPercap = sd(gdpPercap),
            mean_pop = mean(pop),
            sd_pop = sd(pop))
gdp_pop_bycontinents_byyear
 #Podemos crear nuevas antes de (o incluso después) de resumir la información usando mutate().#
gdp_pop_bycontinents_byyear <- gapminder %>%
  mutate(gdp_billion = gdpPercap*pop/10^9) %>%
  group_by(continent,year) %>%
  summarize(mean_gdpPercap = mean(gdpPercap),
            sd_gdpPercap = sd(gdpPercap),
            mean_pop = mean(pop),
            sd_pop = sd(pop),
            mean_gdp_billion = mean(gdp_billion),
            sd_gdp_billion = sd(gdp_billion))
gdp_pop_bycontinents_byyear

#Calcula la expectativa de vida promedio en 2002 para dos países seleccionados al azar de cada continente. Luego ordena los nombres de los continentes en el orden inverso a la expectativa de vida.#
?sample_n()
?arrange
ejeravanzado= gapminder %>% 
  filter(year==2002) %>% 
  group_by(continent) %>% 
  sample_n(2) %>% 
  summarize(mean_lifeExp= mean(lifeExp)) %>% 
  arrange(desc(mean_lifeExp))
#como lo hizo luciano#
gapminder %>% 
  filter(year == 2002) %>% 
  group_by(continent) %>% 
  sample_n(2) %>% 
  summarize(mean_lifeExp=mean(lifeExp)) %>%
  arrange(desc(mean_lifeExp))
#los paises los elige al azar dentro de los continetes, por mas que no te muestre cuales, esa seria otra salida#
