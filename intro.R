# CONHECENDO A INTERFACE DO R-STUDIO

# Paineis

# Comandos sensíveis a caracteres maiúsculos e minúsculos


# Evirar o uso de caracteres especiais e acentos


# Decimais "."


# Complemento automático de comandos


# Acesso aos arquivos de "ajuda"
help(colSums)
?colSums

# Acesso a dados e variáveis


# Como instalar e carregar pacotes (módulos)
install.packages('geobr')


# Fazendo contas simples
2+2
2*4
4/2
2^2


# Scripts
#  
x <- 15 # constante da regressao



# Criando objetos

## atomicos
x<-1
x
y<-5
y
x+y 

x<-"Pedro"
x

## Vetores

x<-c("Joao", "Maria")
x
y<-c(1,2,3,4,5,6,7,8,9,10)
y

1:10000


seq(from=0, to=100, by = 10)


rep("norte", 10)


c(rep('Norte', 10), rep('Sul', 5))



#Matriz (duas dimensoes. Linhas e Colunas)
matriz <- matrix(c(10,23,45,45,30,32,21,23,45), nc=3)
matriz

## Dataframes (2 dimensoes. Linhas e Colunas.)

nome <- c("Joao", "Pedro", "Maria", "Carlos") 
idade <- c(35, 20, 25, 31) 
tabela <- data.frame(nome, idade)  
tabela

# Combinando vetores

x<-c(3,4,5,6)
y<-c(4,5,6,9)

z<-c(x,y)

z

rbind(x,y)
cbind(x,y)


# Obtendo o valor máximo e mínimo de um vetor
max(x)
min(y)
mean(x)
sd(x)

# Obtendo a estatística descritiva de um vetor ou tabela

summary(tabela)

# Operadores lógicos (TRUE ou FALSE)
1 == 1 #igualdade
1 == 2

'Joao' == 'Joao'
'Joao' == 'joao'

2!=1 #Diferença
2!=2 

2 > 1 #Maior
1 < 2 #Menor

1 >= 2 #Maior ou igual
2 <= 4 #Menor ou igual


# Importando arquivos
## Orientações e dicas

