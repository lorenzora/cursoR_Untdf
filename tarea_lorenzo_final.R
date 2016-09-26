## Acá deben hacer la tarea
salarios=read.csv(file = "data/salarios-2016.csv", encoding = "UTF-8")
salarios=salarios.2016
salarios
str
str(salarios)
#anio integral y cargo factor#
#asig mensual: doble#
salarios[salarios$cargo== "Presidente",]#bieeen pudimos ver todo de mauricio#
max(salarios$asignacion_mensual) #vemos quien gano mas#
salarios[217056 <salarios$asignacion_mensual,]# aca lo abtuve, pero tuve conflicto con la coma#
salarios$asignacion_mensual==217056.8
min(salarios$asignacion_mensual)
salarios[salarios$asignacion_mensual<115837,]#mismo poniendo numeros enteros#
levels(salarios$apellido_nombre)=c(levels(salarios$apellido_nombre),"Lorenzo, Rodrigo Anthony")
salarios=rbind(salarios, 2016, 1 ,"Enero", "Ciencia, Tecnolog????a E Innovación Productiva", "Lorenzo, Rodrigo Anthony", "Ministro", 300000)#no funciono#
salarios=salarios.2016
salarios
salarios=rbind(salarios, (2016, 1 ,"Enero", "Ciencia, Tecnolog????a E Innovación Productiva", "Lorenzo, Rodrigo Anthony", "Ministro", 300000))
salarios
levels(salarios$apellido_nombre)
levels(salarios$apellido_nombre)=c(levels(salarios$apellido_nombre),"Lorenzo, Rodrigo Anthony")
salarios=rbind(salarios, (2016, 1 ,"Enero", "Ciencia, Tecnolog????a E Innovación Productiva", "Lorenzo, Rodrigo Anthony", "Ministro", 300000))
levels(salarios$cargo)=c(levels(salarios$cargo),"Ejecutor de R")
levels(salarios$cargo)
salarios
salarios=rbind(salarios, c(2016, 4, "Abril", "Cultura", "Lorenzo, Rodrigo Anthony", "Ejecutor de R", 329749.7))
salarios
sum(salarios$asignacion_mensual, na.rm = FALSE)
salarios$asignacion_mensual
colSums(salarios$asignacion_mensual[1:92])
rowSums(salarios$asignacion_mensua=
          
          x=(1:56)
        sum(x)
        x
        sum(salarios$asignacion_mensual)
        sum(salarios$asignacion_mensual)
        sum(salarios$anio)
        salarios
        salarios$asignacion_mensual
        ?accumulative
        cumsum(salarios$asignacion_mensual)
        salarios=cbind(salarios,cumsum(salarios$asignacion_mensual))
        salarios
        colnames(salarios)
        salarios$`cumsum(salarios$asignacion_mensual)`=salarios$"montoacumulado"
        salarios
        salarios=cbind(salarios,"montoacumulado"=cumsum(salarios$asignacion_mensual))
        salarios
        ?for
        paste("El sueldo de", salarios$cargo, salarios$apellido_nombre, "en", salarios$mes, "fue de $", salarios$asignacion_mensual)