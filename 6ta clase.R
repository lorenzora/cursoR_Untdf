#graficos con buena calidad#
library("ggplot2")
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point()
gapminder
library(ggplot2)
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point()
#data datos#
#aes como mapear los datos#
#Tenemos que decirle como queremos representar nuestros datos. Con una nueva capa geom. Por ejemplo, puntos:#
ggplot(data = gapminder, aes(x = year, y = lifeExp)) +
  geom_point()
ggplot(data = gapminder, aes(x = lifeExp, y = year, colour=continent)) +
  geom_point()#para color por continente#
?geom_point
?ggplot
head(gapminder)

#Un diagrama de puntos no es la mejor forma para mostrar el cambio en el tiempo. Es mejor usar una gráfica de lineas.#
ggplot(data = gapminder, 
       aes(x = year, y = lifeExp, 
           by = country, color = continent)) +#ponemos una cosa mas#
  geom_line()#sinonimo de by es group#
#usamos geom_line() y hay que agregar el argumento by a aes para que una las lineas según el país.#
#¿Pero si queremos ver los puntos y las lineas a la vez? Añadimos otra capa a nuestro gráfico:#
ggplot(data = gapminder, 
       aes(x = year, y = lifeExp,
           by = country, color = continent)) +
  geom_line() + geom_point()
#Cada capa es dibujada por encima de la anterior#
ggplot(data = gapminder, 
       aes(x = year, y = lifeExp, by = country)) +
  geom_line(aes(color = continent)) + geom_point()
ggplot(data = gapminder, 
       aes(x = year, y = lifeExp, by = country)) +
   geom_point()+ geom_line(aes(color = continent))
#si cambio el orden se solapan las capas#
#si queremos realizar transformaciones de los graficos#
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(alpha = 0.5) + scale_x_log10()
#Tranformamos los datos de GDP antes de graficarlos con og10 y también agregamos transparencia para que se vean los puntos donde están agrupados#
#Podemos mostrar la relación lineal que hay entre nuestros datos#
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point() + scale_x_log10() + geom_smooth(method = "lm")
#con scale tambien se puede revertir la escala y mas opciones#
#Hacer la linea más gruesa (o más fina) con el argumento size:#
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point() + scale_x_log10() + geom_smooth(method = "lm", size = 1.5) #transforma los datos antes de mapearlos#
#Hay dos formas de especificar la estetica de una geometría:Definiendola como un valor: dentro de geom_*() y Mapeandola a los datos: dentro de aes()#
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(colour="red", size=3, alpha = 0.5) + scale_x_log10()
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(colour=continent,size=continent)) + scale_x_log10() + geom_smooth(method = "lm")
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(colour=continent,shape=continent)) + geom_smooth(method = "lm") + coord_trans(x="log10")
#Con facet_*() podemos hacer que cada país tenga su panel#
starts.with <- substr(gapminder$country, start = 1, stop = 1)#nos divide un sting y lo corta de una posicion determinadas3
az.countries <- gapminder[starts.with %in% c("A", "Z"), ]#VECTOR DE VERDADERO Y FALSOO DONDE SE CUMPLA LA CONDICION ANTERIOR#
ggplot(data = az.countries, 
       aes(x = year, y = lifeExp, color = continent)) +
  geom_line() + facet_wrap( ~ country)
#~ crea una formula que depende de o se agrupa#
#Modificando el texto#
#Para controlar la apariencia general del gráfico usamos theme(). Para controlar cosas específicas a los ejes, escalas de colores, formas, etc. usamos scale_*().#
#El nombre de los ejes lo podemos controlar desde scale_*() o desde xlab() ylab()#
ggplot(data = az.countries, 
       aes(x = year, y = lifeExp, color = continent)) +
  geom_line() + 
  facet_wrap( ~ country) +
  xlab("Year") + #para los nombre, pero tambien se puede usar "labs(x="..",y="..")#
  ylab("Life expectancy") + 
  ggtitle("Figura 1") +
  scale_colour_discrete( name = "Continent") + #para discriminar los colores por contiente#
  theme(strip.text = element_text(size = 13))#strip son todAS las bandas arriba de nuestros paneles, en este caso el nombre del pais#
ggplot(data = az.countries, 
       aes(x = year, y = lifeExp, color = continent)) +
  geom_line() + 
  facet_wrap( ~ country) +
  xlab("Year") + #para los nombre, pero tambien se puede usar "labs(x="..",y="..")#
  ylab("Life expectancy") + 
  ggtitle("Figura 1") +
  scale_colour_discrete( name = "Continent", values=c(Africa="red", Americas="blue", Asia= "yellow", Europa="grey", Oceania="orange"))+theme(axis.text.x=element_text(angle = 90, hjust = 1)) + #para discriminar los colores por contiente#
ggplot(data = az.countries, 
         aes(x = year, y = lifeExp, color = continent)) +
  geom_line() + 
  facet_wrap( ~ country) +
  xlab("Year") +
  ylab("Life expectancy") + 
  ggtitle("Figura 1") +
  scale_colour_manual( name = "Continent",
                       values =
                         c(Africa = "red",
                           Americas = "blue",
                           Asia = "yellow",
                           Oceania = "orange",
                           Europe = "purple"))+ 
  theme(axis.text.x=
          element_text(angle = 90, hjust = 1))
#ultimo grafico#
library(gganimate)
library(tweenr)
library(dplyr)

gapminder_2 <- gapminder %>% 
  transform(ease = rep("cubic-in-out", nrow(gapminder)),
            continent = as.numeric(continent))

gapminder_tw <- tween_elements(gapminder_2,
                               time = "year", 
                               group = "country", 
                               ease = "ease",
                               nframes = 120)
gapminder_tw <- transform(gapminder_tw, 
                          continent = factor(continent,
                                             labels = levels(gapminder$continent))
)
year <- gapminder_tw[!duplicated(gapminder_tw$year), c("year", ".frame")] %>% transform(year = round(year))

p <- ggplot(gapminder_tw, 
            aes(gdpPercap, lifeExp, frame = .frame)) +
  geom_point(aes(size = pop,
                 color = continent)) +
  geom_text(data = year, aes(x = mean(gapminder$gdpPercap), 
                             y = max(gapminder$lifeExp) + 1, label = year), size = 12) +
  scale_x_log10() +
  xlab("PBI per capita") +
  scale_y_continuous("Expectativa de vida") +
  scale_color_discrete("Continente") +
  scale_size_continuous("Población") +
  theme_light(20)




gg_animate(p, title_frame = FALSE)
# Cargar paquetes
if(!require(gganimate) {
  if(!require(devtools)) install.packages("devtools")  
  devtools::install_github("dgrtwo/gganimate")
}
library(gganimate)
if(!require(tweenr) {
  if(!require(devtools)) install.packages("devtools")  
  devtools::install_github("thomasp85/tweenr")
}
library(tweenr)
library(dplyr)

# Agregar una columna con la forma de ease es como es la velocidad de la interpolación
# Y tranformar el factor en númerico por un bug en tweenr
gapminder_2 <- gapminder %>% 
  transform(ease = rep("cubic-in-out", nrow(gapminder)),
            continent = as.numeric(continent))

#Interpolar elementos entre años por país
gapminder_tw <- tween_elements(gapminder_2,
                               time = "year", 
                               group = "country", 
                               ease = "ease",
                               nframes = 120)

# Volver continente a factor
gapminder_tw <- transform(gapminder_tw, 
                          continent = factor(continent,
                                             labels = levels(gapminder$continent))
)
#Solo elegir un año por frame para graficar como "titulo"
year <- gapminder_tw[!duplicated(gapminder_tw$year), c("year", ".frame")] %>% transform(year = round(year))

p <- ggplot(gapminder_tw, 
            aes(gdpPercap, lifeExp, frame = .frame)) +
  geom_point(aes(size = pop,
                 color = continent)) + # punto con tamaño como población y color como continente
  geom_text(data = year, aes(x = mean(gapminder$gdpPercap), # agregar el texto del año en la mitad del gdp
                             y = max(gapminder$lifeExp) + 1, label = year), size = 12) + # y el máximo de lifeExp +1 para no tapar nada
  scale_x_log10() +
  xlab("PBI per capita") +
  scale_y_continuous("Expectativa de vida") +
  scale_color_discrete("Continente") +
  scale_size_continuous("Población") +
  theme_light(20)


gg_animate(p, title_frame = FALSE)

#Vectorizacion#
#vectorizar xq es mas legible, conciso y menos probabilidad de error.#
gapminder#ejercicio 1#
gapminder2 = cbind(gapminder,"popmill"=c(gapminder$pop/1000000))
gapminder2
head(gapminder2)
ggplot(data = gapminder2, 
       aes(x = year, y = popmill, by = country)) +
  geom_point(aes(colour=continent))
#las operaciones sobre matrices tambien estan vectorizadas#
#multiplicacion matricial: %*%#
m= matrix(1:12, nrow=3, ncol = 4)
m
m**-1#todos los numeros a la -1 en cada posicion#
m*c(1,0,1)#multiplica cada columna por esos numeros#
c(0,20)<m #una vez mayor a 0 y otra vez mayor a 20#
m*c(1,0,-1,-2)#va lleando el vector por columnas y pasando
1/12
#estamos interesados en ver la suma de fracciones#
n=(1:100)
n
x=1/(n**2)
x
sum(x)#para ver todos los valores de n de 100#
#ahora quiero que n sea 10000#
n2=(1:10000)
x=1/(n2**2)
x
sum(x)
#o tmb#
x= 1:10000
sum(x**-2)
#mas inmediata#