# Análisis Exploratorio de Datos (SQL)

## Preprocesamiento de Datos

<img src="../src/image/preprocesamiento.png">

### EDA - SQL

#### ¿Qué productos tienen las mejores calificaciones y mayor cantidad de reseñas? (mejor para evitar productos con una sola calificación perfecta) (SQL - POWER BI)

```sql
SELECT TOP 10
	[Nombre Producto], 
	ROUND([Calificacion], 4) AS [Calificacion],
	[Total Calificaciones]
FROM 
	dbo.amazon_resenas_2
ORDER BY
	ROUND([Calificacion], 4) DESC,
	[Total Calificaciones] DESC
;
```

#### ¿Qué categorías presentan, en promedio, mejores calificaciones por parte de los usuarios? (SQL - POWER BI)



#### ¿Se observan diferencias significativas en las calificaciones promedio entre distintas marcas? (SQL - POWER BI)



#### ¿Cuáles son los productos más populares según la cantidad de reseñas recibidas? (SQL - POWER BI)



#### ¿Qué nivel de descuento es más común entre los productos mejor calificados? (SQL - POWER BI)



#### ¿Qué categorías tienen los precios más altos y más bajos, y cómo se relacionan con la satisfacción del cliente? (SQL - POWER BI)



#### ¿Qué productos presentan mayor diferencia entre el precio original y el precio con descuento? (SQL - POWER BI)


