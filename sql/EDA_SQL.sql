USE Amazon_Sales;

-- Comprobar tipos de datos

EXEC sp_help [dbo.amazon_resenas_2];

/*
	RESPONDER LAS PREGUNTAS CLAVE USANDO SQL

* ¿Qué productos tienen las mejores calificaciones y mayor cantidad de reseñas? (mejor para evitar productos con una sola calificación perfecta)
* ¿Qué categorías presentan, en promedio, mejores calificaciones por parte de los usuarios?
* ¿Se observan diferencias significativas en las calificaciones promedio entre distintas marcas?
* ¿Cuáles son los productos más populares según la cantidad de reseñas recibidas?
* ¿Qué nivel de descuento es más común entre los productos mejor calificados?
* ¿Qué categorías tienen los precios más altos y más bajos, y cómo se relacionan con la satisfacción del cliente?
* ¿Qué productos presentan mayor diferencia entre el precio original y el precio con descuento?
*/

-- ¿Qué productos tienen las mejores calificaciones y mayor cantidad de reseñas? (mejor para evitar productos con una sola calificación perfecta)
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

-- ¿Qué categorías presentan, en promedio, mejores calificaciones por parte de los usuarios?
SELECT TOP 10
    [Categoria N 1],
    ROUND(AVG([Calificacion]), 2) AS Promedio_Calificacion
FROM
    dbo.amazon_resenas_2
GROUP BY
    [Categoria N 1]
ORDER BY
    Promedio_Calificacion DESC;

-- ¿Se observan diferencias significativas en las calificaciones promedio entre distintas marcas?
SELECT 
    LEFT([Nombre Producto], CHARINDEX(' ', [Nombre Producto] + ' ') - 1) AS Marca_Estimada,
    ROUND(AVG([Calificacion]), 2) AS Promedio_Calificacion,
    COUNT(*) AS Total_Productos
FROM 
    dbo.amazon_resenas_2
WHERE 
    [Calificacion] IS NOT NULL
GROUP BY 
    LEFT([Nombre Producto], CHARINDEX(' ', [Nombre Producto] + ' ') - 1)
HAVING 
    COUNT(*) >= 5  -- puedes ajustar este umbral
ORDER BY 
    Promedio_Calificacion DESC;

-- ¿Cuáles son los productos más populares según la cantidad de reseñas recibidas?
SELECT TOP 10
    [Nombre Producto],
    COUNT([ID Resena]) AS [Total de Reseñas]
FROM
    dbo.amazon_resenas_2
GROUP BY
    [Nombre Producto]
ORDER BY
    COUNT([ID Resena]) DESC;

-- ¿Qué nivel de descuento es más común entre los productos mejor calificados?
SELECT 
    [Porcentaje Descuento], 
    COUNT(*) AS [Cantidad de Productos]
FROM 
    dbo.amazon_resenas_2
WHERE 
    Calificacion >= 4.0
GROUP BY 
    [Porcentaje Descuento]
ORDER BY 
    [Cantidad de Productos] DESC;

-- ¿Qué categorías tienen los precios más altos y más bajos, y cómo se relacionan con la satisfacción del cliente?
SELECT 
    [Categoria N 1],
    ROUND(AVG([Precio Final]), 2) AS [Precio Promedio],
    ROUND(AVG([Calificacion]), 2) AS [Calificacion Promedio],
    COUNT(*) AS [Cantidad Productos]
FROM 
    dbo.amazon_resenas_2
WHERE 
    [Precio Final] IS NOT NULL AND [Calificacion] IS NOT NULL
GROUP BY 
    [Categoria N 1]
ORDER BY 
    [Precio Promedio] DESC;  -- Puedes cambiar a ASC para ver las más baratas
 
-- ¿Qué productos presentan mayor diferencia entre el precio original y el precio con descuento?
SELECT TOP 10
    [Nombre Producto],
    [Precio Original],
    [Precio Final],
    ([Precio Original] - [Precio Final]) AS Diferencia_Precio
FROM 
    dbo.amazon_resenas_2
WHERE 
    [Precio Original] IS NOT NULL AND [Precio Final] IS NOT NULL
ORDER BY 
    Diferencia_Precio DESC;
