mi_suma <- function(a, b) {
  suma <- a + b
  return(suma)#En R no es necesario explicitar el return.Automáticamente devuelve el último comando ejecutado. Solo puede devolver un solo objeto.#
}
#por un lado sumamos a+b y despues le pedimos que nos de la suma#
mi_suma(5,4)#asigno a a 5 y a b 4, devolviendonos la suma#
#Definamos una función para convertir grados Kelvin en Fahrenheit#
kelvin_a_fahr <- function(temp) {
  fahr <- (temp - 273.15) * (9/5) + 32
  return(fahr)
}
# El punto de congelación del agua#
kelvin_a_fahr(273.15)
kelvin_a_fahr(373.15)
Celcius_a_kel <- function(temp) {
  kel <- (temp + 273.15)
  return(kel)
}
Celcius_a_kel(0)
Celcius_a_kel(100)
kelvin_a_fahr(273.15, 373.15)#Error in kelvin_a_fahr(273.15, 373.15) : unused argument (373.15)#
Celcius_a_fahr <- function(temp) {
  kelvin <- (temp + 273.15)
    fahr <- (kelvin) * (9/5) - 459.67
    return(fahr)
  }
Celcius_a_fahr(0)
#idea de usar funciones ya definidas#
celsius_a_fahr<- function(temp) {
    kelvin= Celcius_a_kel(temp)
    fahr = kelvin_a_fahr(kelvin)
    return(fahr)
}    #esta es la manera para integrar funciones#
celsius_a_fahr(0)
head(gapminder)
calcPBI <- function(dat) {
  pbi <- dat$pop * dat$gdpPercap
  pbi
}
calcPBI(head(gapminder))
#Vamos a añadir argumentos para poder seleccionar el país y el año:#
# Toma el set de datos y multiplica la columna #
# población por PBI per capita#
calcPBI <- function(dat, year=NULL, country=NULL) {
  if(!is.null(year)) { #para que lo asigne si es nulo, se convierta en falso graias al !#
    dat <- dat[dat$year %in% year, ] #con el % in% podemos poner varios anios#
  }
  if (!is.null(country)) {
    dat <- dat[dat$country %in% country,] #lo mismo que anio, lo hacemos para pais#
  }
  pbi <- dat$pop * dat$gdpPercap
  
  new <- cbind(dat, pbi = pbi)
  return(new)
}
calcPBI(head(gapminder))
calcPBI(gapminder, year = 2007)
calcPBI(gapminder, country = "Argentina")
calcPBI(gapminder, year= 1952:1987, country = "New Zealand")#aca desde un anio al otro#
calcPBI(gapminder, year= 1952 & 1987, country = "New Zealand")
calcPBI(gapminder, year= c(1952,1987), country = "New Zealand")
#La función paste() puede ser usada para combinar texto.# 
mejores_practicas <- c("Escribe", "programas", "para", "personas", 
                       "no", "para", "computadoras")
paste(mejores_practicas, collapse = " ")
#Escribe una función llamada vallar, con dos argumentos texto y envoltura, e imprime el texto envuelto con la envoltura.#
vallar=function(texto,envoltura){
    paste0(envoltura, paste(texto, collapse = " "), envoltura)
}#ahora si, llevar del caso concreto al generalizado, pudiendo cambiar abajo los argumentos#
vallar(mejores_practicas,"***")

