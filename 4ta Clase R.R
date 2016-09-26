x <- c(5.4, 6.2, 7.1, 4.8, 7.5)
names(x) <- c('a', 'b', 'c', 'd', 'e')
x
x[1]
x[4]
x[c(1, 3)]#Podemos pedir varios elementos a la vez#
#O rebanadas de un vector:#
x[1:4]
#Podemos pedir el mismo elemento muchas veces:#
x[c(1,1,3)]
#Si le pedimos el elemento 0, nos devuelve un vector vacío#
x[0]
#Si usamos un número negativo como indice del vector, R va a devolver todos los elementos excepto el especificado.#
x[-2]
#Podemos eliminar varios elementos#
x[c(-1, -5)]
#Para eliminar los elementos de un vector, tenemos que asignar los resultados de nuevo a la variable:#
x <- x[-4]
x
x <- c(5.4, 6.2, 7.1, 4.8, 7.5)
names(x) <- c('a', 'b', 'c', 'd', 'e')
print(x)
x[2:4]?
x[c(2,3,4)]
x[c(-1,-5)]
#tres comandos distintos para lo mismo#
#Podemos extrar los elementos usando su nombre, en vez de un índice:#
x[c("a", "c")]
#Pero es más complicado usarlo para eliminar elementos:#
x[-which(names(x) == "a")]
#Para eliminar muchos elementos por nombre hay que usar otro operador#
x[-which(names(x) %in% c("a", "c"))]
#Dado el vector x ¿Qué esperas que haga el siguiente código?#
x[-which(names(x) == "g")]
x[]
x[integer()]
x[-which(names(x) == "c")]
x[-which(names(x) =="a":"e" )]
?-which
which(names(x) =="a") 
#nos devuelve un vector logico#
names(x)=="a"
#funciones entre % esun operador binario#
(names(x) == "g")
which(names(x) == "g")
x[which(names(x) == 'a')]  # returns all three values, si hay m{as de un valor asignado a "a"#
names(x) == c('a', 'c')
#== funciona de manera ligeramente diferente que %in%. Va a comparar cada elemento de su izquierda con el correspodiente a la derecha.#
#c("a", "b", "c", "e")  # names of x
|    |    |    |    # The elements == is comparing
# c("a", "c")#
#Cuando uno de los argumentos es más corto que el otro, el más corto es reciclado#
  c("a", "b", "c", "e")  # names of x
|    |    |    |    # The elements == is comparing
  c("a", "c", "a", "c") #reciclaje es que repite los facotres al tener una longitud menos#
names(x)=="a"|names(x)=="c"
#También se puede hacer otros subconjuntos usando vectores lógicos:#
x[c(TRUE, TRUE, FALSE, FALSE)]#como puse menos, lo volvio a reciclar#
x[c(TRUE, FALSE)]
x[x > 7]#Dado que las operaciones de comparacion devuelven vectores lógicos se pueden usar.#
x > 7
#&, operador “Y lógico”: devuelve TRUE si ambos son TRUE#
#|, operador “O lógico”: devuelve TRUE si al menos uno es TRUE#
#Las reglas de reciclado aplican para estos operadores && y || son similares pero solo operan en el primer elemento#
#!, operador “NO lógico”: convierte TRUE en FALSE y viceversa#
#all devuelve TRUE cuando todos los valores son TRUE#
#any devuelve TRUE si alguno de los valores es TRUE#
x[x>4& 7>x]
x>4& 7>x
#is.na devuelve un vector lógico donde hay NA#.
#is.nan, e is.infinite hacen lo mismo con valores NaN e Inf.#
#is.finite devuelve todas las posiciones en un vector que no contienen NA, NaN o Inf.#
#na.omit filtra todos los valores perdidos de un vector.#
f <- factor(c("a", "a", "b", "c", "c", "d"))
f[f == "a"]
f[f %in% c("b", "c")]
f[1:3]
f[-3]#Pero no elimina los niveles:#
factor(f[-3])
f[!f %in% c("b", "c")]
#Con la matrices también se usa la función [. Pero se necesitan dos argumentos, el primero es la fila y el segundo la columna:#
set.seed(1)#un vector pseudoaleatorio#
m <- matrix(rnorm( 6 * 4), ncol = 4, nrow = 6)
m[3:4, c(3, 1)]
#Podemos dejar alguno de los argumentos en blanco para otener todas las filas o columnas respectivamente:#
m[, c(3,4)]
m[3,]#Si solo accedemos a una fila o una columna, R la convierte automaticamente a un vector:#
m[3, , drop = FALSE]#Para evitarlo hay que usar el argumento drop = FALSE#
m[5,2]
m
#A diferencia de los vectores, da un error si se trata de acceder a un elemento inexistente:#
m[, c(3,6)]
#array#
m[5]#por defecto se aleneaba por filas#
#Es confuso y poco útil en general. Pero es útil notar que las matrices están construidas usando un formato columnar.#
matrix(1:6, nrow = 2, ncol = 3)
#Si deseas poblar la matriz por filas, usa el argumento byrow = TRUE#
matrix(1:6, nrow = 2, ncol = 3, byrow = TRUE)
m <- matrix(1:18, nrow = 3, ncol = 6)
print(m)
m[2,4,2,5]
m[2:5]
m[4:5,2]
m[2,c(4,5)]
#Subconjuntos de Listas#
xlist <- list(a = "UNTDF", b = 1:10, data = head(iris))
xlist[1]
xlist
#Se puede usar de igual forma que con vectores pero las comparaciones no funcionan.#
xlist[1:2]
#Para extraer elementos individuales de una lista hay que usar [[#
xlist[[1]]
#El resultado es un vector no una lista.Pero no se puede extraer más de un elemento por vez#
xlist[[1:2]]
class(xlist)
#Ni usarlo para eliminar elementos#
xlist[[-1]]
#Pero se pueden usar los nombres para hacer subconjuntos y extraer elementos:#
xlist[["a"]]
#La función $ es un atajo para extraer elementos por nombre.#
xlist$data
xlist[[2]][2]
xlist$2
xlist[[2]]$"2"
xlist$b[2]
?attributes()
mod <- aov(pop ~ lifeExp, data=gapminder)
names(gapminder)
mod <- aov(poblacion ~ Expectariva, data=gapminder)
gapminder <- read.csv(gapminder.FiveYearData.csv)
gapminder=gapminder.FiveYearData
mod <- aov(pop ~ lifeExp, data=gapminder)
mod
attributes(mod)=df.residual
mod$df.residual #esto es para el ejecicio 6, residual df#
#Con un argumento [ se comporta como en una lista y devuelve una columna. El resultado es un data.frame.#
head(gapminder[3], 5)
head(gapminder[["lifeExp"]])
#Y $ provee una forma conveniente de extraer una columna por nombre:#
head(gapminder$year)
#Y con dos argumentos, [ se comporta como si fuese una matriz#
gapminder[1:3,]
#Si solo elegimos una fila el resultado es un data.frame: Pero para una columna devuelve una vector a menos que especifiquemos drop = FALSE#
#corregir errores#
gapminder[gapminder$year ==1957,] #al original le faltaba un =#
gapminder[,-1:-4]#le faltaba un sigo - al 4 , sino era un secuencia#
gapminder[gapminder$lifeExp < 80,]#al original le faltaba el simbolo y la coma#
gapminder[80< gapminder$lifeExp,]

gapminder[c(1, 4,5),]
gapminder[,c(1, 4 , 5)]
gapminder[2002 <gapminder$year   & gapminder$year<2007,]
gapminder[gapminder$year == 2002,]&[gapminder$year==2007,]
gapminder[1:20]#columnas no definidas#
gapminder[1:20, ]
gapminder_small=gapminder[1:9&19:23,]
