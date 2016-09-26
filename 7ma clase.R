#Septima Clase#
#funciones#
dir.create("functions")
# seguimos  con estructura de datos#
#Los gráficos creados con ggplot2 pueden guardarse con ggsave#
#ggsave("Mi_grafico_mas_reciente.pdf")#guarda el ultimo archivo en el formato pdf#
#También podemos especificar que gráfico guardar con el argumento plot Hay otras opciones, como ancho (width), alto (height), ppp (dpi).#
#Por otro lado, quizás queremos guardar varios gráficos en un solo documento.#
#Hay una forma más flexible, la función pdf crea un nuevo dipositivo donde guardar los gráficos.#
library(ggplot2)
pdf("Life_Exp_vs_time.pdf", width=12, height=4)
ggplot(data=gapminder, aes(x=year, y=lifeExp, colour=country)) +
  geom_line()+
  theme(legend.position= "bottom")
  
# ¡Acordarse de apagar el dispositivo!#

dev.off()

pdf("Mi_grafico.pdf", width = 12, height = 8, onefile = TRUE)
for(continent in levels(gapminder$continent)){
  print(ggplot(data=gapminder[gapminder$continent == continent, ], aes(x=year, y=lifeExp, colour=country)) +
          geom_line())
}
dev.off()

pdf("Life_Exp_vs_time2.pdf", width=12, height=12, onefile = TRUE) #cambie el titulo, pero no me dejaba poner el mismo nombre porque estaba abierto#

ggplot(data=gapminder, aes(x=year, y=lifeExp, colour=country)) +
  geom_line() + facet_grid(continent ~ .) +
    theme(legend.position = "bottom") 
  

# You then have to make sure to turn off the pdf device!

dev.off()#siempre chequear que dice null device, sino seguir ejecutandolo#
?facet_grid
#ambién en algún momento vamos a querer guardar datos. Podemos usar la función write.table que es similar a read.table#

#Creemos un script para limpiar datos, y solo queremos los datos de Australia:#
dir.create("cleaned-data")
aust_subset <- gapminder[gapminder$country == "Australia",]#sustrato de datos de austraila#

write.table(aust_subset,
            file="cleaned-data/gapminder-aus.csv",
            sep=","
)
aust_subset #me incluyo las filas, para subsanarlo:#
write.table(aust_subset,
            file="cleaned-data/gapminder-aus.csv",
            sep=",", quote = FALSE, row.names = FALSE
)
head(aust_subset)
aust_subset <- gapminder[gapminder$country == "Australia",]

write.table(aust_subset,
            file = "cleaned-data/gapminder-aus.csv",
            sep = ",", quote = FALSE, row.names = FALSE
)
head(aust_subset)
subset_1990 = gapminder[1990 < gapminder$year,]

write.table(subset_1990,
            file = "cleaned-data/gapminder-1990.csv",
            sep = ",", quote = FALSE, row.names = FALSE
)
head(subset_1990)
