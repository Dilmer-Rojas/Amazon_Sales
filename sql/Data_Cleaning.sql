USE Amazon_Sales;

SELECT * FROM dbo.amazon_resenas;

/* Identificando Duplicados*/

WITH duplicados AS (SELECT *,
	ROW_NUMBER() OVER(PARTITION BY product_id, product_name, category, discounted_price, actual_price, discount_percentage, rating, rating_count, about_product, user_id, user_name, review_id, review_title, review_content, img_link, product_link ORDER BY product_id) AS row_num
FROM dbo.amazon_resenas)

SELECT COUNT(*) AS num_duplicados
FROM duplicados
WHERE row_num > 1;

/* Valores Null */

SELECT
	SUM(CASE WHEN product_id IS NULL THEN 1 ELSE 0 END) AS nulos_product_id,
	SUM(CASE WHEN product_name IS NULL THEN 1 ELSE 0 END) AS nulos_product_name,
	SUM(CASE WHEN category IS NULL THEN 1 ELSE 0 END) AS nulos_category,
	SUM(CASE WHEN discounted_price IS NULL THEN 1 ELSE 0 END) AS nulos_discounted_price,
	SUM(CASE WHEN actual_price IS NULL THEN 1 ELSE 0 END) AS nulos_actual_price,
	SUM(CASE WHEN discount_percentage IS NULL THEN 1 ELSE 0 END) AS nulos_discount_percentage,
	SUM(CASE WHEN rating IS NULL THEN 1 ELSE 0 END) AS nulos_rating,
	SUM(CASE WHEN rating_count IS NULL THEN 1 ELSE 0 END) AS nulos_rating_count,
	SUM(CASE WHEN about_product IS NULL THEN 1 ELSE 0 END) AS nulos_about_product,
	SUM(CASE WHEN user_id IS NULL THEN 1 ELSE 0 END) AS nulos_user_id,
	SUM(CASE WHEN user_name IS NULL THEN 1 ELSE 0 END) AS nulos_user_name,
	SUM(CASE WHEN review_id IS NULL THEN 1 ELSE 0 END) AS nulos_review_id,
	SUM(CASE WHEN review_title IS NULL THEN 1 ELSE 0 END) AS nulos_review_title,
	SUM(CASE WHEN review_content IS NULL THEN 1 ELSE 0 END) AS nulos_review_content,
	SUM(CASE WHEN img_link IS NULL THEN 1 ELSE 0 END) AS nulos_img_link,
	SUM(CASE WHEN product_link IS NULL THEN 1 ELSE 0 END) AS nulos_product_link
FROM dbo.amazon_resenas;

/* Valores Blank */

SELECT
	SUM(CASE WHEN product_id = '' THEN 1 ELSE 0 END) AS blank_product_id,
	SUM(CASE WHEN product_name = '' THEN 1 ELSE 0 END) AS blank_product_name,
	SUM(CASE WHEN category = '' THEN 1 ELSE 0 END) AS blank_category,
	SUM(CASE WHEN discounted_price = '' THEN 1 ELSE 0 END) AS blank_discounted_price,
	SUM(CASE WHEN actual_price = '' THEN 1 ELSE 0 END) AS blank_actual_price,
	SUM(CASE WHEN discount_percentage = '' THEN 1 ELSE 0 END) AS blank_discount_percentage,
	SUM(CASE WHEN rating = '' THEN 1 ELSE 0 END) AS blank_rating,
	SUM(CASE WHEN rating_count = '' THEN 1 ELSE 0 END) AS blank_rating_count,
	SUM(CASE WHEN about_product = '' THEN 1 ELSE 0 END) AS blank_about_product,
	SUM(CASE WHEN user_id = '' THEN 1 ELSE 0 END) AS blank_user_id,
	SUM(CASE WHEN user_name = '' THEN 1 ELSE 0 END) AS blank_user_name,
	SUM(CASE WHEN review_id = '' THEN 1 ELSE 0 END) AS blank_review_id,
	SUM(CASE WHEN review_title = '' THEN 1 ELSE 0 END) AS blank_review_title,
	SUM(CASE WHEN review_content = '' THEN 1 ELSE 0 END) AS blank_review_content,
	SUM(CASE WHEN img_link = '' THEN 1 ELSE 0 END) AS blank_img_link,
	SUM(CASE WHEN product_link = '' THEN 1 ELSE 0 END) AS blank_product_link
FROM dbo.amazon_resenas;

SELECT discount_percentage
FROM dbo.amazon_resenas
WHERE discount_percentage = '';

-- No son Blank -> Son descuentos del 0%

/* CREANDO UNA NUEVA TABLA PARA ALMACENAR DATA*/

GO

/****** Object:  Table [dbo].[amazon_resenas_2]    Script Date: 31/07/2025 19:27:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[amazon_resenas_2](
	[product_id] [nvarchar](50) NOT NULL,
	[product_name] [nvarchar](max) NOT NULL,
	[category] [nvarchar](400) NOT NULL,
	[discounted_price] [float] NOT NULL,
	[actual_price] [float] NOT NULL,
	[discount_percentage] [tinyint] NOT NULL,
	[rating] [float] NOT NULL,
	[rating_count] [float] NOT NULL,
	[about_product] [nvarchar](max) NOT NULL,
	[user_id] [nvarchar](250) NOT NULL,
	[user_name] [nvarchar](150) NOT NULL,
	[review_id] [nvarchar](150) NOT NULL,
	[review_title] [nvarchar](max) NOT NULL,
	[review_content] [nvarchar](max) NOT NULL,
	[img_link] [nvarchar](150) NOT NULL,
	[product_link] [nvarchar](200) NOT NULL,
	[row_num] [int]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


INSERT INTO dbo.amazon_resenas_2
SELECT *,
	ROW_NUMBER() OVER(PARTITION BY product_id, product_name, category, discounted_price, actual_price, discount_percentage, rating, rating_count, about_product, user_id, user_name, review_id, review_title, review_content, img_link, product_link ORDER BY product_id) AS row_num
FROM dbo.amazon_resenas;

SELECT * FROM dbo.amazon_resenas_2;

/* Eliminamos la columna row_num */

ALTER TABLE dbo.amazon_resenas_2
DROP COLUMN row_num;

SELECT
	*
FROM
	dbo.amazon_resenas_2;

-- Renombrar columnas

EXEC sp_rename 'dbo.amazon_resenas_2.product_id', 'ID Producto', 'COLUMN';
EXEC sp_rename 'dbo.amazon_resenas_2.product_name', 'Nombre Producto', 'COLUMN';
EXEC sp_rename 'dbo.amazon_resenas_2.category', 'Categoria', 'COLUMN';
EXEC sp_rename 'dbo.amazon_resenas_2.discounted_price', 'Precio Final', 'COLUMN';
EXEC sp_rename 'dbo.amazon_resenas_2.actual_price', 'Precio Original', 'COLUMN';
EXEC sp_rename 'dbo.amazon_resenas_2.discount_percentage', 'Porcentaje Descuento', 'COLUMN';
EXEC sp_rename 'dbo.amazon_resenas_2.rating', 'Calificacion', 'COLUMN';
EXEC sp_rename 'dbo.amazon_resenas_2.rating_count', 'Total Calificaciones', 'COLUMN';
EXEC sp_rename 'dbo.amazon_resenas_2.about_product', 'Descripcion Producto', 'COLUMN';
EXEC sp_rename 'dbo.amazon_resenas_2.user_id', 'ID Usuario', 'COLUMN';
EXEC sp_rename 'dbo.amazon_resenas_2.user_name', 'Nombre Usuario', 'COLUMN';
EXEC sp_rename 'dbo.amazon_resenas_2.review_id', 'ID Resena', 'COLUMN';
EXEC sp_rename 'dbo.amazon_resenas_2.review_title', 'Titulo Resena', 'COLUMN';
EXEC sp_rename 'dbo.amazon_resenas_2.review_content', 'Contenido Resena', 'COLUMN';
EXEC sp_rename 'dbo.amazon_resenas_2.img_link', 'Enlace Imagen', 'COLUMN';
EXEC sp_rename 'dbo.amazon_resenas_2.product_link', 'Enlace Producto', 'COLUMN';

/* Separar Categorías en Columnas distintas por Niveles */

SELECT Categoria
FROM dbo.amazon_resenas_2;

ALTER TABLE dbo.amazon_resenas_2
ADD [Categoria N 1] NVARCHAR(100),
    [Categoria N 2] NVARCHAR(100),
    [Categoria N 3] NVARCHAR(100),
    [Categoria N 4] NVARCHAR(100),
    [Categoria N 5] NVARCHAR(100),
    [Categoria N 6] NVARCHAR(100),
    [Categoria N 7] NVARCHAR(100);

CREATE FUNCTION dbo.SepararCamelCase(@Texto NVARCHAR(MAX))
RETURNS NVARCHAR(MAX)
AS
BEGIN
    DECLARE @i INT = 1, @Resultado NVARCHAR(MAX) = '', @Len INT = LEN(@Texto)
    WHILE @i <= @Len
    BEGIN
        DECLARE @Char NCHAR(1) = SUBSTRING(@Texto, @i, 1)
        IF @i > 1 AND UNICODE(@Char) BETWEEN 65 AND 90 AND UNICODE(SUBSTRING(@Texto, @i-1, 1)) BETWEEN 97 AND 122
            SET @Resultado += ' ' + @Char
        ELSE
            SET @Resultado += @Char
        SET @i += 1
    END
    RETURN @Resultado
END


-- Paso 1: CTE para dividir las categorías
WITH categorias_divididas AS (
    SELECT 
        r.[ID Producto],
        TRIM(dbo.SepararCamelCase(
            REPLACE(
                REPLACE(
                    REPLACE(value, ',', ', '),   -- ← AÑADE espacio después de coma
                '&', ' y'),
            '-', ' ')
        )) AS nivel,
        ROW_NUMBER() OVER(PARTITION BY r.[ID Producto] ORDER BY (SELECT NULL)) AS nivel_num
    FROM dbo.amazon_resenas_2 r
    CROSS APPLY STRING_SPLIT(
        REPLACE(REPLACE(r.Categoria, '&', ' y '), '-', ' '), '|'
    )
)

-- Paso 2: Subconsulta para pivotear niveles
, niveles_pivot AS (
    SELECT 
        [ID Producto],
        MAX(CASE WHEN nivel_num = 1 THEN nivel END) AS 'Categoria N 1',
        MAX(CASE WHEN nivel_num = 2 THEN nivel END) AS 'Categoria N 2',
        MAX(CASE WHEN nivel_num = 3 THEN nivel END) AS 'Categoria N 3',
        MAX(CASE WHEN nivel_num = 4 THEN nivel END) AS 'Categoria N 4',
        MAX(CASE WHEN nivel_num = 5 THEN nivel END) AS 'Categoria N 5',
        MAX(CASE WHEN nivel_num = 6 THEN nivel END) AS 'Categoria N 6',
        MAX(CASE WHEN nivel_num = 7 THEN nivel END) AS 'Categoria N 7'
    FROM categorias_divididas
    GROUP BY [ID Producto]
)

-- Paso 3: Hacemos el UPDATE a la tabla original
UPDATE r
SET 
    r.[Categoria N 1] = n.[Categoria N 1],
    r.[Categoria N 2] = n.[Categoria N 2],
    r.[Categoria N 3] = n.[Categoria N 3],
    r.[Categoria N 4] = n.[Categoria N 4],
    r.[Categoria N 5] = n.[Categoria N 5],
    r.[Categoria N 6] = n.[Categoria N 6],
    r.[Categoria N 7] = n.[Categoria N 7]
FROM dbo.amazon_resenas_2 r
JOIN niveles_pivot n ON r.[ID Producto] = n.[ID Producto];

/* VER LA TABLA */

SELECT *
FROM dbo.amazon_resenas_2;