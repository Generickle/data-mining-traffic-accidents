# Análisis de accidentes de tránsito en Guatemala durante el 2022

## Introducción

Este proyecto tiene como objetivo analizar datos de accidentes de tránsito en Guatemala y extraer ideas valiosas utilizando técnicas de minería de datos. El análisis incluye explorar patrones, asociaciones y grupos en los datos para comprender los factores que contribuyen a los accidentes de tránsito y proponer posibles soluciones para mitigar riesgos y mejorar la seguridad vial.

Para ejecutar este proyecto, sigue estos pasos:

### 1. Instalación de paquetes

Asegúrate de tener instalados los siguientes paquetes de R. Puedes instalarlos utilizando el siguiente código:

```R
install.packages(c("readxl", "haven", "arules", "ggplot2", "rpart", "rpart.plot"))
```

### 2. Cargar bibliotecas

Una vez instalados los paquetes, carga las bibliotecas necesarias utilizando:

```R
library(readxl)
library(haven)
library(arules)
library(ggplot2)
library(rpart)
library(rpart.plot)
```

### 3. Configuración del directorio de trabajo

Asegúrate de que el directorio de trabajo esté configurado correctamente para acceder a los archivos del proyecto. Puedes verificarlo y cambiarlo según sea necesario con:

```R
getwd()  # Verificar el directorio de trabajo actual
setwd("/ruta/al/proyecto")  # Cambiar el directorio de trabajo
```

### 4. Carga de datos

Carga los conjuntos de datos necesarios para el análisis. Por ejemplo:

```R
data_2022 <- read_excel("data/20230526200007YRSvO7OHib0rQxKDCTAl2fkXMl05g9Uz.xlsx")
```

### 5. Ejecución del análisis

Una vez que hayas cargado los datos, puedes ejecutar el análisis utilizando el código proporcionado. Asegúrate de seguir las instrucciones específicas para cada parte del análisis, como la aplicación de algoritmos de minería de datos y la visualización de resultados.

Siguiendo estos pasos, podrás ejecutar el proyecto y obtener los resultados del análisis de datos de tráfico.

## Datos

Los datos utilizados en este proyecto están disponibles en el sitio web del Instituto Nacional de Estadística (INE) de Guatemala. Puedes acceder a los datos de accidentes de tránsito en la siguiente URL: [Accidentes de Tránsito - INE Guatemala](https://www.ine.gob.gt/bases-de-datos/accidentes-de-transito/).

Para facilitar la reproducción y ejecución del análisis, los conjuntos de datos específicos utilizados en este proyecto se han incluido en la carpeta `data` del repositorio. Puedes encontrar los archivos de datos correspondientes allí para su referencia y análisis.

## Librerías Utilizadas

### readxl
`readxl` es una librería que proporciona funciones para leer archivos de Excel (.xls y .xlsx) en R.

### haven
`haven` es una librería diseñada para importar datos desde formatos de archivos comunes de software estadístico, como SPSS, SAS y Stata, directamente a R.

### arules
`arules` es una librería para la minería de reglas de asociación. Ofrece funciones para descubrir y analizar reglas de asociación en conjuntos de datos.

### ggplot2
`ggplot2` es una librería para la visualización de datos. Proporciona una gramática de gráficos que permite a los usuarios crear gráficos de alta calidad de forma flexible y eficiente.

### rpart
`rpart` es una librería que proporciona una implementación del algoritmo de árboles de decisión para el aprendizaje supervisado.

### rpart.plot
`rpart.plot` es una extensión de `rpart` que ofrece funcionalidades adicionales para visualizar árboles de decisión generados por el paquete `rpart`.

## Funciones Utilizadas

- `read_excel()`: Esta función de la librería `readxl` se utiliza para leer archivos de Excel en R.
  
- `read_sav()`: Esta función de la librería `haven` se utiliza para leer archivos de datos SPSS en R.

- `apriori()`: Esta función de la librería `arules` se utiliza para aplicar el algoritmo Apriori para el descubrimiento de reglas de asociación en conjuntos de datos.

- `kmeans()`: Esta función se utiliza para aplicar el algoritmo de agrupamiento K-Means en conjuntos de datos.

- `inspect()`: Esta función se utiliza para visualizar las reglas de asociación o los resultados de los algoritmos de agrupamiento.

- `rpart()`: Esta función se utiliza para ajustar un modelo de árbol de decisión a los datos.

- `rpart.plot()`: Esta función se utiliza para visualizar los árboles de decisión generados por el paquete `rpart`.

- `na.omit()`: Esta función se utiliza para eliminar filas con valores faltantes (N/A) en un conjunto de datos.

- `kmeans()`: Esta función se utiliza para aplicar el algoritmo de agrupamiento K-Means en conjuntos de datos.

- `ggplot()`: Esta función se utiliza para crear gráficos utilizando la gramática de gráficos de `ggplot2`.

- `geom_point()`: Esta función se utiliza para agregar puntos a un gráfico generado con `ggplot()`.

- `labs()`: Esta función se utiliza para establecer etiquetas de título y ejes en un gráfico generado con `ggplot()`.

- `theme_minimal()`: Esta función se utiliza para aplicar un tema minimalista a un gráfico generado con `ggplot()`.

- `predict()`: Esta función se utiliza para realizar predicciones utilizando un modelo ajustado, como un árbol de decisión.