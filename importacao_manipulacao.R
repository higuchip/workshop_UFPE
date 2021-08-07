# carregando pacotes
library(dplyr) # manipulação de dados
library(geobr)  # dados geoespaciais
library(ggplot2) #vizualização dos dados
library(sf)  #manipulação de dados espaciais

# Importação, vizualização e manipulação dos dados com dplyr


## Importando a base de dados
df <- read.table('dados/BASE GERAL_com lat e long e dist_EMANUEL_v1.csv',
                 header=T, dec=',', sep=";")
df

# Vizualização e explorar os dados.

View(df)

head(df) #primeiras linhas
tail(df) #ultimas linhas

dim(df) #dimensão


names(df) #nomes das colunas
names(df)[5] <- 'dummy'
names(df)


#Selecionado colunas

df$municipio
df[,8]

# Subsets de linhas e colunas

df[1,c(1,8)]


#Usando o pacote dplyr
# install.packages('dplyr') #instalar
library(dplyr) #carregar

## Filtrando os dados de Recife

head(df)

df_recife <- df %>% filter(municipio == "RECIFE") 

View(df_recife)
head(df_recife)


## Selecionado colunas

coordenadas <- df %>% filter(municipio=="RECIFE") %>% 
  select(longitude, latitude)
head(coordenadas)


## Ordenando os dados


df_recife %>% arrange(latitude) #ordem crescente
df_recife %>% arrange(desc(latitude)) #ordem crescente


## Resumindo informações

df_recife %>% group_by(grupo_nat_juridica) %>% count()


df_recife %>% 
  group_by(grupo_nat_juridica) %>% #Agrupando
  summarise(contagem = n()) # sumarizando em função da contagem


## Transformando para o formato sf
install.packages('sf')
library(sf)

df_recife_sf <- df_recife %>%   
  st_as_sf(
    coords = c("longitude", "latitude"),
    agr = "constant",
    crs = 4326,        #transformacao para datum WGS84
    stringsAsFactors = FALSE,
    remove = TRUE
  )
df_recife_sf


library(geobr)


# Vizualização dos dados espaciais
## Obtenção de metadados
metadata <- download_metadata() #obter os metadados do geobr
head(metadata)
View(metadata)

## Selecionando de dados referente aos municípios de Pernambuco
#all_mun_pe <- read_municipality(code_muni=26, year=2020)
all_mun_pe <- read_municipality(code_muni='PE', year=2020)
head(all_mun_pe)
View(all_mun_pe)
dim(all_mun_pe)

## Filtrando o mapa de Recife e definindo o datum WGS84
recife_geo <- all_mun_pe %>% 
  filter(name_muni == 'Recife') %>% 
  st_transform(4326) 
recife_geo

## Selecionado pontos dentro do polígono de Recife
points_in_recife <- 
  st_join(df_recife_sf, recife_geo) %>% 
  filter(!is.na(code_muni)) # 
points_in_recife

## Gerando mapa por meio do ggplot2
install.packages('ggplot2')
library(ggplot2)

### Vizualização 
ggplot()+
  geom_sf(data=recife_geo,
          fill="#2D3E50", size=.15, 
          show.legend = FALSE)+
  geom_sf(data=points_in_recife, 
          aes(color=grupo_nat_juridica))+
  facet_wrap(~grupo_nat_juridica)+
  scale_color_manual(values=c("#ed6881", "#f7f707", "#cf13e8"))+
  theme_minimal()+theme(legend.position="none")

