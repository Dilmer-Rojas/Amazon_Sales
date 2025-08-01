# Análisis de Reseñas de Amazon

<img src="./src/image/amazon.png">

Este repositorio contiene la documentación completa del proyecto de **Análisis Exploratorio de Datos (EDA)** aplicado a reseñas y ventas de productos de **Amazon**.

## Contenido

- [Enlace al dataset de Kaggle](https://www.kaggle.com/datasets/karkavelrajaj/amazon-sales-dataset)
- [Objetivo del Proyecto](#objetivo-del-proyecto)
- [Preguntas Clave](#preguntas-clave)
- [Indicadores Clave KPIs](#indicadores-clave-kpis)
- [Herramientas Utilizadas](#herramientas-utilizadas)

## Objetivo del Proyecto

El objetivo principal es identificar patrones, relaciones y tendencias en las reseñas, calificaciones, precios y descuentos de los productos, con el fin de generar insights útiles para la toma de decisiones comerciales.

## Preguntas Clave


* ¿Qué productos tienen las mejores calificaciones y mayor cantidad de reseñas? (mejor para evitar productos con una sola calificación perfecta) (SQL - POWER BI)
* ¿Existe una relación entre el precio del producto y la calificación otorgada por los usuarios? (PYTHON - POWER BI)
* ¿Los productos con mayores descuentos tienden a recibir mejores calificaciones o más reseñas? (PYTHON - POWER BI)
* ¿Qué categorías presentan, en promedio, mejores calificaciones por parte de los usuarios? (SQL - POWER BI)
* ¿Se observan diferencias significativas en las calificaciones promedio entre distintas marcas? (SQL - POWER BI)
* ¿Cuáles son los productos más populares según la cantidad de reseñas recibidas? (SQL - POWER BI)
* ¿Qué nivel de descuento es más común entre los productos mejor calificados? (SQL - POWER BI)
* ¿Qué categorías tienen los precios más altos y más bajos, y cómo se relacionan con la satisfacción del cliente? (SQL - POWER BI)
* ¿Qué productos presentan mayor diferencia entre el precio original y el precio con descuento? (SQL - POWER BI)
* ¿Existen palabras clave o frases comunes en las reseñas de productos bien valorados? (requiere análisis de texto: NLP básico) (PYTHON)

## Indicadores Clave KPIs

* Promedio de calificaciones por producto
* Número de reseñas por producto
* Relación entre descuento (%) y calificación
* Calificación promedio por categoría
* Ranking de productos mejor valorados


## Herramientas Utilizadas

* **Python 3**: para la limpieza, análisis y visualización inicial de datos (usando Jupyter Notebook).
* **SQL Server**: para la consulta, exploración y transformación de los datos desde una base estructurada.
* **Power BI Desktop**: para la construcción de dashboards interactivos.
* **Power BI Service**: para la publicación y distribución del informe final.